import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booking.dart'; // Sesuaikan dengan import file booking.dart jika berbeda
import 'profile.dart'; // Sesuaikan dengan import halaman profile yang benar
import 'main.dart';
import 'konfirmasipengembalian.dart';

class ReturnPageContent extends StatefulWidget {
  
  @override
  _ReturnPageContentState createState() => _ReturnPageContentState();
}

class _ReturnPageContentState extends State<ReturnPageContent> {
  int _selectedIndex = 2; // Indeks default untuk Return

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
        // Tidak perlu navigasi jika sudah di halaman Return
        break;
      case 3:
        // Navigasi ke halaman Profile jika diperlukan
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
      default:
        break;
    }
  }

  void _returnBusana(BookingData item) {
    // Navigasi ke halaman ReturnProcessPage untuk proses pengembalian
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReturnProcessPage(
          item: item,
          onReturnConfirmed: (returnedItem) {
            // Hapus item yang dikembalikan dari daftar paidItems
            Provider.of<PaidItemsProvider>(context, listen: false).removeItem(returnedItem);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil paidItems dari Provider
    List<BookingData> paidItems = Provider.of<PaidItemsProvider>(context).paidItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Return Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Barang yang Telah Dibayar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: paidItems.length,
                itemBuilder: (context, index) {
                  final item = paidItems[index];
                  return Card(
                    elevation: 4, // Memberikan bayangan pada card
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/${item.busana.nama.toLowerCase()}.jpg'),
                      ),
                      title: Text(item.busana.nama),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ukuran: ${item.ukuran}'),
                          Text('Jumlah: ${item.jumlah}'),
                          Text('Total Harga: ${item.totalHarga}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Ubah warna latar belakang tombol
                        ),
                        onPressed: () {
                          _returnBusana(item);
                        },
                        child: Text(
                          'Kembalikan',
                          style: TextStyle(color: Colors.white), // Ubah warna teks
                        ),
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
  unselectedItemColor: Colors.grey, // warna untuk item yang tidak dipilih
        onTap: _onItemTapped,
      ),
    );
  }
}