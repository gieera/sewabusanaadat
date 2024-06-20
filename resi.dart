/*import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import "return.dart";

class ResiPage extends StatefulWidget {
  @override
  _ResiPageState createState() => _ResiPageState();
}

class _ResiPageState extends State<ResiPage> {
  String nomorResi = "ABC123456789XYZ"; // Nomor resi statis

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nomor Resi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nomor Resi Pengiriman Anda:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              nomorResi,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            BarcodeWidget(
              barcode: Barcode.code128(),
              data: nomorResi,
              width: 200,
              height: 80,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Aksi yang ingin dilakukan ketika tombol "Selesai" ditekan
                // Misalnya, kembali ke halaman sebelumnya atau melakukan operasi tertentu
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReturnPageContent(),
                    ),
                  ); // Kembali ke halaman sebelumnya
              },
              child: Text('Selesai'),
            ),
          ],
        ),
      ),
    );
  }
}*/