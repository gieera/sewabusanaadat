import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booking.dart'; // Import BookingData and PaidItemsProvider
import 'konfirmasipembayaran.dart'; // Sesuaikan dengan import file konfirmasipembayaran.dart
import 'konfirmasipengembalian.dart'; // Sesuaikan dengan import file konfirmasipengembalian.dart
import 'konfirmasipengembalian.dart';
import 'resi.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengambil data paidItems dari PaidItemsProvider
    List<BookingData> paidItems = Provider.of<PaidItemsProvider>(context).paidItems;

    // Contoh data pengembalian (harus disesuaikan dengan logika aplikasi Anda)
    List<BookingData> returnItems = []; // Ganti dengan metode untuk mendapatkan data pengembalian

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Notifikasi: Data Pembayaran Diterima',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (paidItems.isNotEmpty)
              Column(
                children: paidItems.map((item) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      title: Text('Busana: ${item.busana.nama}'),
                      subtitle: Text('Amount: ${item.totalHarga}\nUkuran: ${item.ukuran}\nJumlah: ${item.jumlah}'),
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      onTap: () {
                        // Navigasi ke halaman detail konfirmasi pembayaran
                        /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResiPage(),
                    ),
                  );*/
                      },
                    ),
                  );
                }).toList(),
              )
            else
              Text('Belum ada data pembayaran diterima.'),

            SizedBox(height: 40),

            Text(
              'Notifikasi: Data Pengembalian Diproses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (returnItems.isNotEmpty)
              Column(
                children: returnItems.map((item) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      title: Text('Busana: ${item.busana.nama}'),
                      subtitle: Text('Ukuran: ${item.ukuran}\nJumlah: ${item.jumlah}'),
                      leading: Icon(Icons.assignment_returned, color: Colors.orange),
                      onTap: () {
                        // Navigasi ke halaman detail konfirmasi pengembalian
                        
                      },
                    ),
                  );
                }).toList(),
              )
            else
              Text('Belum ada data pengembalian diproses.'),
          ],
        ),
      ),
    );
  }
}