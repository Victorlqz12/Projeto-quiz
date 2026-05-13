import 'package:flutter/material.dart';
import'./questao.dart';
import'./resposta.dart';

class Questionario extends StatelessWidget {

  final int perguntaSelecionada;
  final List<Map<String, Object>> perguntas;
  final void Function(int) responder;

  Questionario({
    required this.perguntaSelecionada,
    required this.perguntas,
    required this.responder,
  });

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada
    ? perguntas[perguntaSelecionada].cast()['respostas']
    : [];

    
    return Column(
      children: [
        Questao(perguntas[perguntaSelecionada]['pergunta'].toString()),
        ...respostas.map((resp) => Resposta(resp['texto'] as String,()=> responder(int.parse(resp['nota'].toString())))),
      ],
    );             
  }
}
