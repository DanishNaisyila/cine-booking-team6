import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'controllers/booking_controller_nadhif.dart';
import 'models/movie_model_azka.dart';
import 'pages/home_page_dian.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookingControllerNadhif(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cinema Booking',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const MovieLoaderNadhif(),
      ),
    );
  }
}

class MovieLoaderNadhif extends StatelessWidget {
  const MovieLoaderNadhif({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("movies")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final docs = snapshot.data!.docs;

        List<MovieModelAzka> movies = docs.map(
          (e) => MovieModelAzka.fromMap(
            e.data() as Map<String, dynamic>,
          ),
        ).toList();

        return HomePageDian(movies: movies);
      },
    );
  }
}
