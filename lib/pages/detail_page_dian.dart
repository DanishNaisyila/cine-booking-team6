import 'package:flutter/material.dart';
import '../models/movie_model_azka.dart';
import 'seat_page_dian.dart';

class DetailPageDian extends StatelessWidget {
  final MovieModelAzka movie;
  const DetailPageDian({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SeatPageDian(movie: movie)),
          );
        },
        label: const Text("Book Ticket"),
        icon: const Icon(Icons.event_seat_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: movie.movieId,
              child: Image.network(
                movie.posterUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 420,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 20, color: Colors.amber),
                      const SizedBox(width: 6),
                      Text("${movie.rating} / 10  •  ⏱ ${movie.duration} min"),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    "Movie description is not provided in data model.\n"
                    "You can add description if backend already supports it.",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
