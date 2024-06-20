import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'booking.dart'; // Import halaman konfirmasi booking
import 'main.dart';


// Inisialisasi tanggal sewa dan tanggal pengembalian
DateTime tanggalSewa = DateTime.now();
DateTime tanggalPengembalian = tanggalSewa.add(Duration(days: 7)); // Contoh: 7 hari setelah tanggal sewa

// Format tanggal untuk ditampilkan
DateFormat dateFormat = DateFormat('yyyy-MM-dd'); // Sesuaikan dengan format yang Anda inginkan

class BusanaDetailPage extends StatefulWidget {
  final Busana busana;

  BusanaDetailPage({required this.busana});

  @override
  _BusanaDetailPageState createState() => _BusanaDetailPageState();
}

class _BusanaDetailPageState extends State<BusanaDetailPage> {
  int jumlahSewa = 1; // Jumlah busana yang akan disewa, diinisialisasi dengan 1
  String ukuranSewa = 'M'; // Ukuran busana yang akan disewa, diinisialisasi dengan M

  // Metode untuk menambah jumlah busana yang akan disewa
  void tambahJumlahSewa() {
    setState(() {
      jumlahSewa++;
    });
  }

  // Metode untuk mengurangi jumlah busana yang akan disewa
  void kurangJumlahSewa() {
    if (jumlahSewa > 1) {
      setState(() {
        jumlahSewa--;
      });
    }
  }

  // Metode untuk mengubah ukuran busana yang akan disewa
  void ubahUkuranSewa(String newSize) {
    setState(() {
      ukuranSewa = newSize;
    });
  }

  // Metode untuk membuat booking dan menavigasi ke halaman konfirmasi booking
  void _buatBooking() {
    int totalHarga = widget.busana.harga * jumlahSewa;

    BookingData bookingData = BookingData(
      busana: widget.busana,
      ukuran: ukuranSewa,
      jumlah: jumlahSewa,
      totalHarga: totalHarga,
      bookingName: 'Nama Pemesan', // Ganti dengan nilai yang sesuai
      bookingDetails: 'Detail Pemesanan',
      tanggalSewa: tanggalSewa,
      tanggalPengembalian:  tanggalPengembalian,// Ganti dengan nilai yang sesuai
    );

    bookedItems.add(bookingData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.busana.nama),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/${widget.busana.nama.toLowerCase()}.jpg',
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Harga: Rp ${widget.busana.harga}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Region: ${widget.busana.region}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Rating: ${widget.busana.rating}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Deskripsi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '${widget.busana.deskripsi}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.inventory, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Stok Tersedia: ${widget.busana.stok}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Ukuran Tersedia:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white, // Warna teks pada item yang dipilih
                fillColor: Color.fromARGB(255, 145, 121, 99), // Warna background pada item yang dipilih
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('S'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('M'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('L'),
                  ),
                ],
                isSelected: ['S', 'M', 'L'].map((size) => size == ukuranSewa).toList(),
                onPressed: (index) {
                  String newSize = ['S', 'M', 'L'][index];
                  ubahUkuranSewa(newSize);
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: kurangJumlahSewa,
                  ),
                  SizedBox(width: 16),
                  Text(
                    '$jumlahSewa', // Tampilkan jumlah busana yang akan disewa
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: tambahJumlahSewa,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Harga: Rp ${widget.busana.harga * jumlahSewa}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
  onPressed: _buatBooking,
  style: ElevatedButton.styleFrom(
    
  ),
  child: Text('Booking'),
),
            ],
          ),
        ),
      ),
    );
  }
}