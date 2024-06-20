import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'booking.dart';
import 'return.dart';
import 'profile.dart';
import 'detail.dart';
import 'package:provider/provider.dart';
import 'notification.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaidItemsProvider(), // Membuat provider PaidItemsProvider
    child: MaterialApp(
      home: HomePage(),
    ),
    );
  }
}

class Busana {
  final String nama;
  final int harga;
  final String region;
  final double rating;
  final String deskripsi;
  final int stok;
  final List<String> ukuran;

  Busana({
    required this.nama,
    required this.harga,
    required this.region,
    required this.rating,
    required this.deskripsi,
    required this.stok,
    required this.ukuran,
  });

  factory Busana.fromJson(Map<String, dynamic> json) {
    return Busana(
      nama: json['nama'],
      harga: int.parse(json['harga']),
      region: json['region'],
      rating: json['rating'].toDouble(),
      deskripsi: json['deskripsi'],
      stok: json['stok'],
      ukuran: List<String>.from(json['ukuran']),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedRegion;
  String? selectedPriceRange;
  String searchQuery = '';
  List<Busana> busanaList = [];
  List<Busana> allBusanaList = [];
  List<String> regionList = [];
  int _selectedIndex = 0;
  List<BookingData> paidItems = [];

  @override
  void initState() {
    super.initState();
    fetchBusana();
  }



  Future<void> fetchBusana([String? region, String? priceRange]) async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:8000/busana${region != null ? '?region=$region' : ''}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Busana> fetchedBusanaList = data.map((item) => Busana.fromJson(item)).toList();

      setState(() {
        if (region == null) {
          // Initialize allBusanaList and regionList only once
          allBusanaList = fetchedBusanaList;
          regionList = allBusanaList.map((busana) => busana.region).toSet().toList();
        }
        busanaList = applyFilters(fetchedBusanaList, priceRange, searchQuery);
      });
    } else {
      throw Exception('Failed to load busana adat');
    }
  }

  List<Busana> applyFilters(List<Busana> busanaList, String? priceRange, String searchQuery) {
    List<Busana> filteredList = busanaList;

    if (priceRange != null) {
    switch (priceRange) {
    case '0-75000':
      filteredList = filteredList.where((busana) {
        return busana.harga <= 75000;
      }).toList();
      break;
        case '75000-150000':
  filteredList = filteredList.where((busana) {
    return busana.harga > 75000 && busana.harga <= 150000;
  }).toList();
  break;

        case '> 150000':
  filteredList = filteredList.where((busana) {
    return busana.harga > 150000;
  }).toList();
  break;

      }
    }

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((busana) {
        return busana.nama.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filteredList;
  }

  Widget _buildRatingStars(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      IconData starIcon = Icons.star_border;
      if (i < rating.floor()) {
        starIcon = Icons.star;
      } else if (i < rating.ceil()) {
        starIcon = Icons.star_half;
      }
      stars.add(Icon(starIcon, size: 16));
    }
    return Row(children: stars);
  }

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });

  switch (index) {
    case 0:
      // Navigasi ke halaman Home jika diperlukan
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      break;
    case 1:
      // Navigasi ke halaman Booking
      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingConfirmationPage()));
      break;
    case 2:
      // Navigasi ke halaman Return dengan meneruskan paidItems
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReturnPageContent()));
      break;
    case 3:
      // Navigasi ke halaman Profile jika diperlukan
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
      break;
    default:
      break;
  }
}

  

    // Handle navigation to different pages here if necessary
    // For now, it only changes the selected index
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sewadat'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(),
                  ),
                );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double appBarWidth = constraints.maxWidth;

              String imagePath = 'assets/banner.jpeg';

              return Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 90.0,
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 8),
                Text('Rungkut, SURABAYA',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(133, 111, 64, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Pilih Daerah'),
                  value: selectedRegion,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedRegion = newValue;
                      });
                      fetchBusana(newValue, selectedPriceRange);
                    }
                  },
                  items: regionList.map((region) {
                    return DropdownMenuItem(
                      child: Text(region),
                      value: region,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari Nama Busana',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  busanaList = applyFilters(allBusanaList, selectedPriceRange, searchQuery);
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPriceRange = '0-75000';
                    });
                    fetchBusana(selectedRegion, '0-75000');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedPriceRange == '0-75000'
                        ? Color.fromARGB(255, 145, 121, 99)
                        : Color.fromRGBO(188, 160, 101, 1),
                  ),
                  child: Text('Rp 0 - Rp 75000'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPriceRange = '75000-150000';
                    });
                    fetchBusana(selectedRegion, '75000-150000');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedPriceRange == '75000-150000'
                        ?Color.fromARGB(255, 145, 121, 99)
                        : Color.fromRGBO(188, 160, 101, 1),
                  ),
                  child: Text('Rp 75000 - Rp150000'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPriceRange = '> 150000';
                    });
                    fetchBusana(selectedRegion, '> 150000');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedPriceRange == '> 150000'
                        ? Color.fromARGB(255, 145, 121, 99)
                        : Color.fromRGBO(188, 160, 101, 1),
                  ),
                  child: Text('> Rp 150000'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: busanaList.length,
                itemBuilder: (context, index) {
                  final busana = busanaList[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () {
                        // Navigasi ke halaman detail saat item diklik
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusanaDetailPage(busana: busana),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/${busana.nama.toLowerCase()}.jpg'),
                        radius: 30,
                      ),
                      title: Text(busana.nama),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Harga: Rp ${busana.harga}'),
                          Text('Region: ${busana.region}'),
                          Row(
                            children: [
                              Text('Rating: '),
                              _buildRatingStars(busana.rating),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.undo),
            label: 'Return',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
         currentIndex: _selectedIndex,
  selectedItemColor: Color.fromARGB(255, 145, 121, 99), // warna untuk item yang dipilih
  unselectedItemColor: const Color.fromRGBO(158, 158, 158, 1), // warna untuk item yang tidak dipilih
  onTap: _onItemTapped,
      ),
    );
  }
   
}