import 'package:flutter/material.dart';
import 'main.dart';
import 'booking.dart';
import 'return.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Index for ProfilePage

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation to the respective pages
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingConfirmationPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReturnPageContent()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index < 3) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              color: const Color.fromARGB(255, 145, 121, 99),
              child: ListTile(
                title: Text(
                  index == 0 ? 'Profile Engie' : index == 1 ? 'Profile Risma' : 'FAQ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  index == 0 ? Icons.person : index == 1 ? Icons.person : Icons.question_answer,
                  color: Colors.white,
                ),
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileEngiePage()),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileRismaPage()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQPage()),
                    );
                  }
                },
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hubungi Kami',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 145, 121, 99),
                    ),
                  ),
                  SizedBox(height: 4),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    color: const Color.fromRGBO(158, 158, 158, 1),
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Telepon'),
                      subtitle: Text('0812-3456-7890'),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    color: const Color.fromRGBO(158, 158, 158, 1),
                    child: ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email'),
                      subtitle: Text('info@sewadat.com'),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    color: const Color.fromRGBO(158, 158, 158, 1),
                    child: ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text('Alamat'),
                      subtitle: Text('Jl. Rungkut Madya No. 12'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        separatorBuilder: (context, index) => SizedBox(height: 8.0), // Mengatur jarak antar card
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

class ProfileEngiePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Engie'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 145, 121, 99), Color.fromRGBO(158, 158, 158, 1)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/fotoEngie.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Name: Engie Ramadhani', style: TextStyle(fontSize: 18, color: Colors.white)),
                Text('NPM: 22082010029', style: TextStyle(fontSize: 18, color: Colors.white)),
                Text('Tempat, Tanggal Lahir: Tanjungpandan, 29 Oktober 2004', style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    // Handle URL navigation
                  },
                  icon: Icon(Icons.link, color: Colors.white),
                  label: Text('GitHub', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileRismaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Risma'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 145, 121, 99), Color.fromRGBO(158, 158, 158, 1)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 247, 245, 245).withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/fotoRisma.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Name: Risma Paramesti', style: TextStyle(fontSize: 18, color: Colors.white)),
                Text('NPM: 22082010014', style: TextStyle(fontSize: 18, color: Colors.white)),
                Text('Tempat, Tanggal Lahir: Sidoarjo, 6 April 2004', style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    // Handle URL navigation
                  },
                  icon: Icon(Icons.link, color: Colors.white),
                  label: Text('GitHub', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Apa itu aplikasi sewa busa adat (sewadat)?'),
              subtitle: Text(
                'Aplikasi sewa busa adat (sewadat) adalah platform untuk menyewa busa adat secara online dengan berbagai pilihan busa adat tradisional.',
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Bagaimana cara menyewa busa adat di aplikasi sewadat?'),
              subtitle: Text(
                'Untuk menyewa busa adat di aplikasi sewadat, Anda dapat masuk ke aplikasi, pilih busa adat yang Anda inginkan, lakukan pemesanan, dan ikuti petunjuk selanjutnya.',
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Apakah ada syarat khusus untuk menyewa busa adat?'),
              subtitle: Text(
                'Syarat umum untuk menyewa busa adat biasanya meliputi identitas yang valid dan pembayaran sesuai ketentuan yang berlaku.',
              ),
            ),
          ),
          // Tambahkan lebih banyak pertanyaan dan jawaban sesuai kebutuhan
        ],
      ),
    );
  }
}