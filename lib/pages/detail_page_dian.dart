import 'package:flutter/material.dart';
import '../models/movie_model_azka.dart';
import 'seat_page_dian.dart';

class DetailPageDian extends StatelessWidget {
  final MovieModelAzka movie;

  const DetailPageDian({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: movie.posterUrl,
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 380,
              ),
            ),

            const SizedBox(height: 20),

            // --- TITLE ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 14),

            // --- RATING & DURATION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 22),
                const SizedBox(width: 6),
                Text(
                  "${movie.rating} / 10",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 18),
                const Icon(Icons.timer_outlined, color: Colors.white70, size: 22),
                const SizedBox(width: 6),
                Text(
                  "${movie.duration} min",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- DESCRIPTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movie.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 32),

            // --- BOOK BUTTON ---
            SizedBox(
              width: 250,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeatPageDian(movie: movie),
                    ),
                  );
                },
                child: const Text(
                  'Book Ticket',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
