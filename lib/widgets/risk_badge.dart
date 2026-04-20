import 'package:flutter/material.dart';

class RiskBadge extends StatelessWidget {
  final String text;
  const RiskBadge(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    switch (text) {
      case '高':
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFEF4444);
        break;
      case '中':
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFF59E0B);
        break;
      default:
        bg = const Color(0xFFD1FAE5);
        fg = const Color(0xFF10B981);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: TextStyle(color: fg, fontWeight: FontWeight.bold)),
    );
  }
}
