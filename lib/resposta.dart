import 'package:flutter/material.dart';

enum EstadoResposta { normal, correta, errada }

class Resposta extends StatelessWidget {
  final String texto;
  final void Function() quandoRespondido;
  final int indice;
  final EstadoResposta estado;

  const Resposta(
    this.texto,
    this.quandoRespondido, {
    this.indice = 0,
    this.estado = EstadoResposta.normal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final letras = ['A', 'B', 'C', 'D'];
    final letra = indice < letras.length ? letras[indice] : '';

    final Color bgColor;
    final Color borderColor;
    final Color textColor;
    final Color circleBg;

    switch (estado) {
      case EstadoResposta.correta:
        bgColor = Colors.green.withValues(alpha: 0.3);
        borderColor = Colors.greenAccent;
        textColor = Colors.white;
        circleBg = Colors.green.withValues(alpha: 0.5);
      case EstadoResposta.errada:
        bgColor = Colors.red.withValues(alpha: 0.2);
        borderColor = Colors.redAccent;
        textColor = Colors.white70;
        circleBg = Colors.red.withValues(alpha: 0.4);
      case EstadoResposta.normal:
        bgColor = Colors.white.withValues(alpha: 0.15);
        borderColor = Colors.white.withValues(alpha: 0.38);
        textColor = Colors.white;
        circleBg = Colors.white.withValues(alpha: 0.2);
    }

    Widget circuloConteudo;
    if (estado == EstadoResposta.correta) {
      circuloConteudo = const Icon(Icons.check, color: Colors.white, size: 20);
    } else if (estado == EstadoResposta.errada) {
      circuloConteudo = const Icon(Icons.close, color: Colors.white, size: 20);
    } else {
      circuloConteudo = Text(
        letra,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: estado == EstadoResposta.normal ? quandoRespondido : null,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: circleBg, shape: BoxShape.circle),
                  child: Center(child: circuloConteudo),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    texto,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
