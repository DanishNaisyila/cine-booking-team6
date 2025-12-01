import 'package:cine_booking_team6/controllers/auth_controller_dian.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller_dian.dart';
import '../pages/history_page_nadhif.dart';
import '../pages/login_page_azka.dart';

class ProfilePageVina extends StatelessWidget {
  const ProfilePageVina({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthControllerDian>(context);
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Akun Anda",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Text("Email : ${user?.email}"),
            const SizedBox(height: 10),
            Text("UID   : ${user?.uid}"),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const HistoryPageNadhif()),
                );
              },
              child: const Text("Lihat Riwayat Booking"),
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await auth.logoutAzka();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LoginPageAzka()),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
