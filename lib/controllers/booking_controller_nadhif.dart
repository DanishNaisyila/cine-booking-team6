import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingControllerNadhif with ChangeNotifier {
  // STATE
  List<String> selectedSeatsNadhif = [];
  List<String> soldSeatsNadhif = ["A1", "A2", "B5", "C7"];
  int totalPriceNadhif = 0;

  String movieTitleNadhif = "";
  int basePriceNadhif = 0;

  // SETUP FILM
  void setMovieDataNadhif({
    required String title,
    required int basePrice,
  }) {
    movieTitleNadhif = title;
    basePriceNadhif = basePrice;

    selectedSeatsNadhif.clear();
    totalPriceNadhif = 0;

    notifyListeners();
  }

  // TOGGLE SEAT
  void toggleSeatNadhif(String seatCode) {
    if (selectedSeatsNadhif.contains(seatCode)) {
      selectedSeatsNadhif.remove(seatCode);
    } else {
      selectedSeatsNadhif.add(seatCode);
    }

    calculateFinalPriceNadhif();
    notifyListeners();
  }

  // LONG TITLE TAX
  int calculateLongTitleTaxNadhif() {
    if (movieTitleNadhif.length > 10) {
      return 2500;
    }
    return 0;
  }

  // EVEN SEAT DISCOUNT (10%)
  bool isEvenSeatNadhif(String seatCode) {
    final number = int.tryParse(
      seatCode.replaceAll(RegExp(r'[^0-9]'), ''),
    ) ?? 0;

    return number % 2 == 0;
  }

  // TOTAL PRICE
  void calculateFinalPriceNadhif() {
    int total = 0;
    int longTitleTax = calculateLongTitleTaxNadhif();

    for (String seat in selectedSeatsNadhif) {
      int seatPrice = basePriceNadhif;

      // Long Title Tax
      seatPrice += longTitleTax;

      // Odd/Even Rule → Genap diskon 10%
      if (isEvenSeatNadhif(seat)) {
        final discount = (basePriceNadhif * 0.10).toInt();
        seatPrice -= discount;
      }

      total += seatPrice;
    }

    totalPriceNadhif = total;
  }

  // CHECKOUT → FIRESTORE
  Future<void> checkoutNadhif(String userId) async {
    final bookingId = FirebaseFirestore.instance
        .collection("bookings")
        .doc()
        .id;

    await FirebaseFirestore.instance
        .collection("bookings")
        .doc(bookingId)
        .set({
      "booking id": bookingId,
      "user id": userId,
      "movie title": movieTitleNadhif,
      "seats": selectedSeatsNadhif,
      "total price": totalPriceNadhif,
      "booking date": Timestamp.now(),
    });
  }
}
