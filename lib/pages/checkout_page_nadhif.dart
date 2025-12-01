import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/booking_controller_nadhif.dart';

class CheckoutPageNadhif extends StatelessWidget {
  final String userId;
  const CheckoutPageNadhif({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<BookingControllerNadhif>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout Ticket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Movie: ${logic.movieTitleNadhif}",
                style: TextStyle(fontSize: 18)),

            SizedBox(height: 8),
            Text("Seats:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(logic.selectedSeatsNadhif.join(", ")),

            SizedBox(height: 20),
            Text("Total Price",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Rp ${logic.totalPriceNadhif}",
                style: TextStyle(fontSize: 20)),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await logic.checkoutNadhif(userId);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Booking Berhasil!")),
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );
                  }
                },
                child: Text(
                  "Bayar Sekarang",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
