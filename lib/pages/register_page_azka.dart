import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller_dian.dart';

class RegisterPageAzka extends StatefulWidget {
  const RegisterPageAzka({super.key});

  @override
  State<RegisterPageAzka> createState() => _RegisterPageAzkaState();
}

class _RegisterPageAzkaState extends State<RegisterPageAzka> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final usernameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthControllerDian>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Register - Azka")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameC,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: "Email (@student.univ.ac.id)"),
            ),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final message = await auth.registerAzka(
                  email: emailC.text.trim(),
                  password: passC.text,
                  username: usernameC.text.trim(),
                );

                if (message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                  return;
                }

                // Jika berhasil → kembali ke login
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Registrasi berhasil! Silakan login.")),
                );

                Navigator.pop(context);
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}