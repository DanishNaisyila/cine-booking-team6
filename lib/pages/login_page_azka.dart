import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller_dian.dart';
import 'register_page_azka.dart';
import 'profile_page_vina.dart';

class LoginPageAzka extends StatefulWidget {
  const LoginPageAzka({super.key});

  @override
  State<LoginPageAzka> createState() => _LoginPageAzkaState();
}

class _LoginPageAzkaState extends State<LoginPageAzka> {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthControllerDian>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login - Azka")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final message = await auth.loginAzka(
                  email: emailC.text.trim(),
                  password: passC.text,
                );

                if (message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                  return;
                }

                // Jika login berhasil → ke profil
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePageVina()), 
                );
              },
              child: const Text("Login"),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPageAzka()),
                );
              },
              child: const Text("Belum punya akun? Register"),
            ),
          ],
        ),
      ),
    );
  }
}