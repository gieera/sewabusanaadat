import 'package:flutter/material.dart';
import 'booking.dart'; // Sesuaikan dengan nama file halaman konfirmasi booking jika berbeda
import 'konfirmasipembayaran.dart'; // Sesuaikan dengan nama file halaman konfirmasi pembayaran

class PaymentPage extends StatefulWidget {
  final List<BookingData> selectedItems;

  PaymentPage(this.selectedItems);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedDeliveryOption = 0; // Indeks default untuk opsi pengiriman
  String _selectedBank = 'BCA'; // Opsi pembayaran bank yang dipilih
  bool _isAgreedToTerms = false; // Apakah pengguna menyetujui syarat dan ketentuan

  List<BookingData> paidItems = []; // List untuk menyimpan data yang sudah dibayar

  // Deskripsi dan harga pengiriman
  static const Map<int, String> deliveryOptions = {
    0: 'Pengiriman Hemat Rp 10.000  (3-7 hari sampai lokasi)',
    1: 'Pengiriman Reguler Rp 20.000  (2 hari sampai lokasi)',
  };

  // Biaya pengiriman
  static const Map<int, int> deliveryCosts = {
    0: 10000,
    1: 20000,
  };

  // Metode untuk menghitung total harga dengan biaya pengiriman
  int calculateTotalPrice() {
    int totalPrice = 0;
    for (var item in widget.selectedItems) {
      totalPrice += item.totalHarga;
    }
    // Tambahkan biaya pengiriman berdasarkan opsi yang dipilih
    totalPrice += deliveryCosts[_selectedDeliveryOption]!;
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Pembayaran',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Total Amount: ${calculateTotalPrice()}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey),
                    Text(
                      'Busana yang Dipilih:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.selectedItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.selectedItems[index];
                        return ListTile(
                          title: Text(item.busana.nama),
                          subtitle: Text('Ukuran: ${item.ukuran}, Jumlah: ${item.jumlah}, Total Harga: ${item.totalHarga}'),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/${item.busana.nama.toLowerCase()}.jpg'),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey),
                    Text(
                      'Pilih Opsi Pengiriman',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: deliveryOptions.entries.map((entry) {
                        return RadioListTile(
                          title: Text(
                            entry.value,
                            style: TextStyle(fontSize: 14),
                          ),
                          value: entry.key,
                          groupValue: _selectedDeliveryOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedDeliveryOption = value as int;
                            });
                          },
                          activeColor: Color.fromARGB(255, 145, 121, 99), // warna untuk item yang dipilih
                          toggleable: true,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey),
                    Text(
                      'Pilih Metode Pembayaran',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      value: _selectedBank,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBank = newValue!;
                        });
                      },
                      items: <String>['BCA', 'Mandiri', 'BNI', 'BRI']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey),
                    Row(
                      children: [
                        Checkbox(
                          value: _isAgreedToTerms,
                          onChanged: (value) {
                            setState(() {
                              _isAgreedToTerms = value!;
                            });
                          },
                        ),
                        Text('Saya menyetujui syarat dan ketentuan'),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isAgreedToTerms
                          ? () {
                              // Simpan data yang sudah dibayar
                              paidItems = List.from(widget.selectedItems);
                              // Navigasi ke halaman konfirmasi pembayaran dengan kode unik
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KonfirmasiPembayaranPage('1234 5678 9012 3456', paidItems), // Ganti dengan kode unik dan data yang sesuai
                                ),
                              );
                            }
                          : null, // Tombol dinonaktifkan jika syarat dan ketentuan tidak disetujui
                      style: ElevatedButton.styleFrom(
                       
                      ),
                      child: Text('Bayar Sekarang'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}