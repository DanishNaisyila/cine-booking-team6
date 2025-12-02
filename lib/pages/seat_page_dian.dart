import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_model_azka.dart';
import '../controllers/booking_controller_nadhif.dart';

class SeatPageDian extends StatelessWidget {
  final MovieModelAzka movie;

  const SeatPageDian({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingController = Provider.of<BookingControllerNadhif>(context);

    // Pastikan judul & basePrice dikirim ke controller
    bookingController.setMovieDataNadhif(
  title: movie.title,
  basePrice: movie.basePrice,
);


    return Scaffold(
      appBar: AppBar(title: const Text("Select Seat")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Booking for: ${movie.title}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text("Base Price: Rp ${movie.basePrice}"),
            const SizedBox(height: 20),

            // ===== GRID KURSI 6x8 =====
            Expanded(
              child: GridView.builder(
                itemCount: 48, // 6 x 8
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ 8; // 0–5
                  final col = index % 8;  // 0–7

                  final rowLetter = String.fromCharCode(65 + row); // A-F
                  final seatNumber = col + 1;
                  final seatCode = "$rowLetter$seatNumber";

                  final isSold = bookingController.soldSeatsNadhif.contains(seatCode);
                  final isSelected = bookingController.selectedSeatsNadhif.contains(seatCode);

                  Color seatColor;
                  if (isSold) {
                    seatColor = Colors.red;
                  } else if (isSelected) {
                    seatColor = Colors.blue;
                  } else {
                    seatColor = Colors.grey.shade400;
                  }

                  return GestureDetector(
                    onTap: isSold
                        ? null
                        : () => bookingController.toggleSeatNadhif(seatCode),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: seatColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        seatCode,
                        style: const TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // ===== TOMBOL PROCEED =====
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  bookingController.calculateFinalPriceNadhif();


                  Navigator.pushNamed(context, "/checkout");
                },
                child: const Text("Proceed to Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
