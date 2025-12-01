import 'package:flutter/material.dart';
import '../models/movie_model_azka.dart';
import '../widgets/seat_item_vina.dart';

class SeatSelectionVina extends StatefulWidget {
  final MovieModelAzka movie;

  const SeatSelectionVina({Key? key, required this.movie}) : super(key: key);

  @override
  State<SeatSelectionVina> createState() => _SeatSelectionVinaState();
}

class _SeatSelectionVinaState extends State<SeatSelectionVina> {
  // State untuk kursi yang dipilih
  List<String> selectedSeats = [];
  
  // Data kursi yang sudah terjual (hardcoded untuk sekarang)
  // Nanti akan diganti dengan data dari Firebase
  final Set<String> soldSeats = {
    'A1', 'A2', 'A3',      // Row A: 1-3 terjual
    'B5', 'B6',            // Row B: 5-6 terjual
    'C3', 'C4',            // Row C: 3-4 terjual
    'D7', 'D8',            // Row D: 7-8 terjual
    'E4', 'E5', 'E6',      // Row E: 4-6 terjual
    'F1', 'F2', 'F8',      // Row F: 1,2,8 terjual
  };
  
  // Konfigurasi grid 6x8 sesuai spesifikasi
  final List<String> rowLabels = ['A', 'B', 'C', 'D', 'E', 'F'];
  final int seatsPerRow = 8;

  // Fungsi untuk toggle seat selection
  void toggleSeat(String seatCode) {
    setState(() {
      if (selectedSeats.contains(seatCode)) {
        selectedSeats.remove(seatCode);  // Unselect
      } else {
        selectedSeats.add(seatCode);     // Select
      }
    });
  }

  // Fungsi untuk clear semua seat yang dipilih
  void clearAllSeats() {
    setState(() {
      selectedSeats.clear();
    });
  }

  // Fungsi untuk mengecek apakah kursi sudah terjual
  bool isSeatSold(String seatCode) {
    return soldSeats.contains(seatCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Kursi"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
            tooltip: 'Info',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Film
            _buildMovieInfo(),
            
            const SizedBox(height: 24),
            
            // Layar Bioskop
            _buildScreenDisplay(),
            
            const SizedBox(height: 32),
            
            // Grid Kursi 6x8
            _buildSeatGrid(),
            
            const SizedBox(height: 24),
            
            // Legend Keterangan
            _buildLegend(),
            
            const SizedBox(height: 32),
            
            // Selected Seats Summary
            _buildSelectedSeatsSummary(),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          // Poster Film
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.movie.posterUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Detail Film
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),
                
                // Rating dan Durasi
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(widget.movie.rating.toString()),
                      ],
                    ),
                    
                    const SizedBox(width: 16),
                    
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text("${widget.movie.duration} min"),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Harga
                Text(
                  "Harga: Rp ${widget.movie.basePrice} / kursi",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[200]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: const Center(
        child: Text(
          "LAYAR BIOSKOP",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }

  Widget _buildSeatGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Row labels (A-F) di atas grid
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, left: 40),
            child: Row(
              children: rowLabels.map((label) {
                return Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Grid kursi 6 baris x 8 kolom
          Column(
            children: List.generate(rowLabels.length, (rowIndex) {
              final rowLabel = rowLabels[rowIndex];
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    // Label baris di sisi kiri
                    SizedBox(
                      width: 32,
                      child: Center(
                        child: Text(
                          rowLabel,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    
                    // 8 kursi dalam satu baris
                    Expanded(
                      child: Row(
                        children: List.generate(seatsPerRow, (colIndex) {
                          final seatNumber = colIndex + 1;
                          final seatCode = '$rowLabel$seatNumber';
                          final isSold = isSeatSold(seatCode);
                          final isSelected = selectedSeats.contains(seatCode);
                          
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: SeatItemVina(
                                seatCode: seatCode,
                                isSold: isSold,
                                isSelected: isSelected,
                                onTap: () => toggleSeat(seatCode),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          
          // Column numbers (1-8) di bawah grid
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 40),
            child: Row(
              children: List.generate(seatsPerRow, (index) {
                return Expanded(
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Keterangan:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildLegendItem(
              color: Colors.grey,
              text: "Kosong",
            ),
            _buildLegendItem(
              color: Colors.blue,
              text: "Dipilih",
            ),
            _buildLegendItem(
              color: Colors.red,
              text: "Terjual",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSelectedSeatsSummary() {
    final selectedCount = selectedSeats.length;
    final totalPrice = selectedCount * widget.movie.basePrice;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          // Kursi yang dipilih
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Kursi Terpilih:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                selectedCount == 0 
                    ? "Belum ada" 
                    : selectedSeats.join(", "),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Jumlah kursi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Jumlah Kursi:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "$selectedCount kursi",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Total harga sementara
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Sementara:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "Rp $totalPrice",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Tombol Hapus Semua
        Expanded(
          child: OutlinedButton(
            onPressed: selectedSeats.isNotEmpty ? clearAllSeats : null,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Colors.orange),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.clear_all, color: Colors.orange, size: 20),
                SizedBox(width: 8),
                Text(
                  "Hapus Semua",
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Tombol Lanjutkan
        Expanded(
          child: ElevatedButton(
            onPressed: selectedSeats.isNotEmpty
                ? () {
                    // Akan diintegrasikan dengan checkout screen
                    _showProceedDialog();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.blue,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Lanjutkan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cara Memilih Kursi"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("1. Klik kursi abu-abu untuk memilih"),
            Text("2. Klik kursi biru untuk membatalkan"),
            Text("3. Kursi merah sudah terjual"),
            Text("4. Pilih beberapa kursi untuk teman/keluarga"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showProceedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: Text(
          "Anda akan melanjutkan dengan ${selectedSeats.length} kursi:\n"
          "${selectedSeats.join(", ")}\n\n"
          "Total: Rp ${selectedSeats.length * widget.movie.basePrice}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Akan diarahkan ke checkout screen oleh Anggota 4
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Menuju checkout dengan ${selectedSeats.length} kursi",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Lanjut"),
          ),
        ],
      ),
    );
  }
}