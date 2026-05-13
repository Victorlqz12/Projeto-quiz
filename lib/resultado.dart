import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int acertos;
  final int total;
  final void Function() quandoReiniciar;

  const Resultado(this.acertos, this.total, this.quandoReiniciar, {super.key});

  String get fraseResultado {
    final p = acertos / total;
    if (p < 0.4) return 'Pode Melhorar!';
    if (p < 0.6) return 'Bom!';
    if (p < 0.8) return 'Ótimo!';
    return 'Excelente!';
  }

  String get emoji {
    final p = acertos / total;
    if (p < 0.4) return '😅';
    if (p < 0.6) return '😊';
    if (p < 0.8) return '🎉';
    return '🏆';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  Text(
                    fraseResultado,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$acertos de $total corretas',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${((acertos / total) * 100).round()}% de aproveitamento',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: quandoReiniciar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6C63FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Tentar Novamente',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
