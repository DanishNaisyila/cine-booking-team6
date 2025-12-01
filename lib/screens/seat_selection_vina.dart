import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_model_azka.dart';
import '../widgets/seat_item_vina.dart';
import '../controllers/booking_controller_nadhif.dart';
import '../pages/checkout_page_nadhif.dart';

class SeatSelectionVina extends StatefulWidget {
  final MovieModelAzka movie;

  const SeatSelectionVina({Key? key, required this.movie}) : super(key: key);

  @override
  State<SeatSelectionVina> createState() => _SeatSelectionVinaState();
}

class _SeatSelectionVinaState extends State<SeatSelectionVina> {

  // Data kursi terjual tetap lokal (belum dari Firebase)
  final Set<String> soldSeats = {
    'A1', 'A2', 'A3',
    'B5', 'B6',
    'C3', 'C4',
    'D7', 'D8',
    'E4', 'E5', 'E6',
    'F1', 'F2', 'F8',
  };

  final List<String> rowLabels = ['A', 'B', 'C', 'D', 'E', 'F'];
  final int seatsPerRow = 8;

  @override
  void initState() {
    super.initState();
    final logic = Provider.of<BookingControllerNadhif>(context, listen: false);
    logic.setMovieDataNadhif(
      title: widget.movie.title,
      basePrice: widget.movie.basePrice,
    );
  }

  bool isSeatSold(String seatCode) => soldSeats.contains(seatCode);

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<BookingControllerNadhif>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Kursi"),
      ),
      body: _buildBody(logic),
    );
  }

  Widget _buildBody(BookingControllerNadhif logic) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildMovieInfo(),
          const SizedBox(height: 20),
          _buildSeatGrid(logic),
          const SizedBox(height: 20),
          _buildSelectedSeatsSummary(logic),
          const SizedBox(height: 20),
          _buildActionButtons(logic),
        ],
      ),
    );
  }

  Widget _buildSeatGrid(BookingControllerNadhif logic) {
    return Column(
      children: List.generate(rowLabels.length, (rowIndex) {
        final row = rowLabels[rowIndex];

        return Row(
          children: List.generate(seatsPerRow, (colIndex) {
            final seatNumber = colIndex + 1;
            final seatCode = '$row$seatNumber';

            final isSold = isSeatSold(seatCode);
            final isSelected = logic.selectedSeatsNadhif.contains(seatCode);

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: SeatItemVina(
                  seatCode: seatCode,
                  isSold: isSold,
                  isSelected: isSelected,
                  onTap: () {
                    if (!isSold) {
                      logic.toggleSeatNadhif(seatCode);
                    }
                  },
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildSelectedSeatsSummary(BookingControllerNadhif logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kursi dipilih: ${logic.selectedSeatsNadhif.join(', ')}"),
        Text("Total harga: Rp ${logic.totalPriceNadhif}"),
      ],
    );
  }

  Widget _buildActionButtons(BookingControllerNadhif logic) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              logic.selectedSeatsNadhif.clear();
              logic.calculateFinalPriceNadhif();
              logic.notifyListeners();
            },
            child: const Text("Hapus Semua"),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: logic.selectedSeatsNadhif.isEmpty
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckoutPageNadhif(
                          userId: "USER123", // nanti diisi dari auth
                        ),
                      ),
                    );
                  },
            child: const Text("Lanjutkan"),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.movie.title, style: const TextStyle(fontSize: 18)),
        Text("Harga dasar: Rp ${widget.movie.basePrice}"),
      ],
    );
  }
}
