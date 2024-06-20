import 'package:flutter/material.dart';
import 'booking.dart'; // Sesuaikan dengan import file booking.dart jika berbeda
 // Sesuaikan dengan import halaman return
import 'package:provider/provider.dart';
import 'resi.dart';

class KonfirmasiPembayaranPage extends StatelessWidget {
  final String kodeUnik;
  final List<BookingData> paidItems;

  KonfirmasiPembayaranPage(this.kodeUnik, this.paidItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pembayaran'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Virtual Account :',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                kodeUnik,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Silakan lakukan pembayaran sesuai dengan Virtual Account di atas untuk menyelesaikan transaksi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Kirim data yang sudah dibayar ke halaman ReturnPage
                  Provider.of<PaidItemsProvider>(context, listen: false).setPaidItems(paidItems);

                 /* Navigator.push(
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