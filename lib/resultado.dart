import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int nota;
  final void Function () quandoReiniciar;

  Resultado(this.nota, this.quandoReiniciar);
  String get fraseResultado{
    if (nota < 8) {
      return 'Pode Melhorar!';
    } else if (nota < 12){
      return 'bom!';
    } else if (nota < 16) {
      return 'Ótimo!';
    } else {
      return 'Excelente!';
    }
  }

  @override  
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(  
          child: Text(
            fraseResultado,
          style: TextStyle(
            fontSize: 25,
            color: Colors.blue
          ),
          ),
        ),
        TextButton(onPressed: quandoReiniciar, 
        child: Text(
          'Reiniciar?',
          style: TextStyle(fontSize: 18, color: Colors.green),
        ))
      ],
    );
  }
}