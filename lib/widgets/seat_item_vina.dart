import 'package:flutter/material.dart';

class SeatItemVina extends StatefulWidget {
  final String seatCode;      // Format: "A1", "B2", dst
  final bool isSold;          // true jika kursi sudah terjual
  final bool isSelected;      // true jika kursi dipilih user
  final VoidCallback onTap;   // Fungsi saat kursi diklik

  const SeatItemVina({
    Key? key,
    required this.seatCode,
    required this.isSold,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SeatItemVina> createState() => _SeatItemVinaState();
}

class _SeatItemVinaState extends State<SeatItemVina> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isSold ? null : widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: _getSeatColor(),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _getBorderColor(),
              width: widget.isSelected ? 2 : 1,
            ),
            boxShadow: _getBoxShadows(),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon berdasarkan status
                Icon(
                  _getSeatIcon(),
                  size: widget.isSelected ? 18 : 14,
                  color: _getTextColor(),
                ),
                
                const SizedBox(height: 2),
                
                // Kode kursi
                Text(
                  widget.seatCode,
                  style: TextStyle(
                    fontSize: widget.isSelected ? 11 : 9,
                    fontWeight: widget.isSelected 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                    color: _getTextColor(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== HELPER METHODS ==========

  Color _getSeatColor() {
    if (widget.isSold) {
      return Colors.red;               // MERAH: sudah terjual
    } else if (widget.isSelected) {
      return Colors.blue;              // BIRU: dipilih user
    } else {
      return Colors.grey;              // ABU-ABU: kosong
    }
  }

  Color _getBorderColor() {
    if (widget.isSold) {
      return Colors.red[800]!;
    } else if (widget.isSelected) {
      return Colors.blue[800]!;
    } else {
      return Colors.grey[600]!;
    }
  }

  List<BoxShadow> _getBoxShadows() {
    if (_isHovered && !widget.isSold && !widget.isSelected) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];
    }
    return [];
  }

  Color _getTextColor() {
    if (widget.isSold || widget.isSelected) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  IconData _getSeatIcon() {
    if (widget.isSold) {
      return Icons.block;                // Ikon X untuk sold
    } else if (widget.isSelected) {
      return Icons.event_seat;           // Ikon terisi
    } else {
      return Icons.event_seat_outlined;  // Ikon kosong
    }
  }
}