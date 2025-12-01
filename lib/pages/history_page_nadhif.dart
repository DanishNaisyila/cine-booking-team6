import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HistoryPageNadhif extends StatelessWidget {
  const HistoryPageNadhif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Booking")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("bookings")
            .orderBy("booking date", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final data = bookings[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data["movie title"]),
                subtitle: Text("Seats: ${data["seats"].join(", ")}"),
                trailing: QrImageView(
                  data: data["booking id"],
                  size: 60,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
