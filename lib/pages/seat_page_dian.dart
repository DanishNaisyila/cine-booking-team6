import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/movie_model_azka.dart';
import '../controllers/booking_controller_nadhif.dart';

class SeatPageDian extends StatefulWidget {
  final MovieModelAzka movie;
  const SeatPageDian({Key? key, required this.movie}) : super(key: key);

  @override
  State<SeatPageDian> createState() => _SeatPageDianState();
}

class _SeatPageDianState extends State<SeatPageDian> {
  @override
  void initState() {
    super.initState();

    // Set data movie hanya sekali (tidak reset saat rebuild)
    Future.microtask(() {
      final bookingController =
          Provider.of<BookingControllerNadhif>(context, listen: false);
      bookingController.setMovieDataNadhif(
        title: widget.movie.title,
        basePrice: widget.movie.basePrice,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingController = Provider.of<BookingControllerNadhif>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Select Seat")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Booking for: ${widget.movie.title}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text("Base Price: Rp ${widget.movie.basePrice}"),
            const SizedBox(height: 16),

            // ===== GRID KURSI 6 x 8 =====
            Expanded(
              child: GridView.builder(
                itemCount: 48,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ 8;
                  final col = index % 8;

                  final rowLetter = String.fromCharCode(65 + row); // A-F
                  final seatNumber = col + 1;
                  final seatCode = "$rowLetter$seatNumber";

                  final isSold = bookingController.soldSeatsNadhif.contains(seatCode);
                  final isSelected =
                      bookingController.selectedSeatsNadhif.contains(seatCode);

                  Color seatColor;
                  if (isSold) {
                    seatColor = Colors.red; // tidak bisa dipilih
                  } else if (isSelected) {
                    seatColor = Colors.blue; // dipilih
                  } else {
                    seatColor = Colors.grey.shade400; // default
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
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ===== BUTTON PROCEED =====
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: bookingController.selectedSeatsNadhif.isEmpty
                    ? null
                    : () {
                        bookingController.calculateFinalPriceNadhif();

                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        Navigator.pushNamed(
                          context,
                          "/checkout",
                          arguments: userId,
                        );
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
