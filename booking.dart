import 'package:flutter/material.dart';
import 'main.dart'; // Sesuaikan dengan import main.dart untuk menggunakan kelas Busana
import 'return.dart'; // Sesuaikan dengan import halaman return yang benar
import 'profile.dart'; // Sesuaikan dengan import halaman profile yang benar
import 'pembayaran.dart';
import 'package:intl/intl.dart';


// List yang digunakan untuk menyimpan data booking
List<BookingData> bookedItems = [];

class PaidItemsProvider extends ChangeNotifier {
  List<BookingData> _paidItems = [];

  List<BookingData> get paidItems => _paidItems;

  void setPaidItems(List<BookingData> items) {
    _paidItems = items;
    notifyListeners();
  }
  
  void removeItem(BookingData item) {
    _paidItems.remove(item);
    notifyListeners();
  }
}

// Class untuk menyimpan data booking
class BookingData {
  final Busana busana;
  final String ukuran;
  final int jumlah;
  final int totalHarga;
  bool isChecked; // Menandai apakah busana dipilih atau tidak
  final String bookingName;
  final String bookingDetails;
  final DateTime tanggalSewa; // Tanggal sewa ditambahkan
  final DateTime tanggalPengembalian; // Tanggal pengembalian ditambahkan

  BookingData({
    required this.busana,
    required this.ukuran,
    required this.jumlah,
    required this.totalHarga,
    this.isChecked = false, // Defaultnya tidak dipilih
    required this.bookingName,
    required this.bookingDetails,
    required this.tanggalSewa, // Diinisialisasi saat pembuatan objek BookingData
    required this.tanggalPengembalian, // Diinisialisasi saat pembuatan objek BookingData
  });
}

class BookingConfirmationPage extends StatefulWidget {
  @override
  _BookingConfirmationPageState createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  int _selectedIndex = 1; // Indeks default untuk Booking

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
        // Tidak perlu navigasi jika sudah di halaman Booking
        break;
      case 2:
        // Navigasi ke halaman Return jika diperlukan
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReturnPageContent()));
        break;
      case 3:
        // Navigasi ke halaman Profile jika diperlukan
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
      default:
        break;
    }
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (var item in bookedItems) {
      if (item.isChecked) {
        totalPrice += item.totalHarga;
      }
    }
    return totalPrice;
  }

  void _handleCheckOut() {
    // Filter data yang dipilih untuk disimpan atau diproses lebih lanjut
    List<BookingData> selectedItems = bookedItems.where((item) => item.isChecked).toList();

    // Misalnya, simpan data yang dipilih atau kirim ke layanan backend
    // Di sini Anda bisa menambahkan logika sesuai dengan kebutuhan aplikasi Anda

    // Contoh sederhana, menavigasi ke halaman pembayaran
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage(selectedItems)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Busana yang Dibooking:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: bookedItems.length,
                itemBuilder: (context, index) {
                  final bookingData = bookedItems[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: CheckboxListTile(
                      title: Text('${bookingData.busana.nama}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ukuran: ${bookingData.ukuran}'),
                          Text('Jumlah: ${bookingData.jumlah}'),
                          Text('Total Harga: ${bookingData.totalHarga}'),
                          Text('Tanggal Sewa: ${DateFormat('dd MMMM yyyy').format(bookingData.tanggalSewa)}'),
                          Text('Tanggal Pengembalian: ${DateFormat('dd MMMM yyyy').format(bookingData.tanggalPengembalian)}'),
                        ],
                      ),
                      secondary: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/${bookingData.busana.nama.toLowerCase()}.jpg',
                        ),
                      ),
                      value: bookingData.isChecked,
                      onChanged: (value) {
                        setState(() {
                          bookingData.isChecked = value!;
                        });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                'Total Harga Keseluruhan: ${calculateTotalPrice()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 145, 121, 99), // warna untuk item yang dipilih
        unselectedItemColor: Colors.grey, // warna untuk item yang tidak dipilih
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Return',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      // Tombol Check Out di bagian bawah layar
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: _handleCheckOut,
          style: ElevatedButton.styleFrom(
            
          ),
          child: Text('Check Out'),
        ),
      ],
    );
  }
}