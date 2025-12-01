import 'package:flutter/material.dart';
import '../models/movie_model_azka.dart';

class SeatPageDian extends StatelessWidget {
  final MovieModelAzka movie;

  const SeatPageDian({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Seat")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Booking for: ${movie.title}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text("Seat layout (6 x 8) will be implemented by Member 3."),
              const SizedBox(height: 12),
              Text(
                "Base Price: Rp ${movie.basePrice}",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Seat selection UI belum diimplementasi.")),
                  );
                },
                child: const Text("Proceed (placeholder)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
