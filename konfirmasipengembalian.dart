import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import untuk DateFormat
import 'booking.dart'; // Sesuaikan dengan import file booking.dart jika berbeda
import 'resi.dart';

class ReturnProcessPage extends StatefulWidget {
  final BookingData item;
  final Function(BookingData) onReturnConfirmed; // Fungsi untuk memberi sinyal bahwa pengembalian dikonfirmasi

  ReturnProcessPage({required this.item, required this.onReturnConfirmed});

  @override
  _ReturnProcessPageState createState() => _ReturnProcessPageState();
}

class _ReturnProcessPageState extends State<ReturnProcessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proses Pengembalian'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Anda sedang mengembalikan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircleAvatar(
              backgroundImage: AssetImage('assets/${widget.item.busana.nama.toLowerCase()}.jpg'),
              radius: 50,
            ),
            SizedBox(height: 8),
            Text(widget.item.busana.nama, style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            Text(
              'Tanggal Sewa: ${DateFormat('dd MMMM yyyy').format(widget.item.tanggalSewa)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Tanggal Pengembalian: ${DateFormat('dd MMMM yyyy').format(widget.item.tanggalPengembalian)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Memberi sinyal bahwa pengembalian dikonfirmasi dan menampilkan Virtual Account
                widget.onReturnConfirmed(widget.item);

                // Navigasi ke halaman Virtual Account dengan Virtual Account yang sudah dihasilkan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VirtualAccountPage(virtualAccount: '1234 5678 9012 3456'), // Ganti dengan virtual account yang dihasilkan
                  ),
                );
              },
              child: Text('Konfirmasi Pengembalian'),
            ),
          ],
        ),
      ),
    );
  }
}

class VirtualAccountPage extends StatelessWidget {
  final String virtualAccount;

  VirtualAccountPage({required this.virtualAccount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Virtual Account Anda',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                virtualAccount,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResiPage(),
                    ),
                  );*/
                },
                child: Text('Selesai'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}