import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final int perguntaSelecionada;
  final List<Map<String, Object>> perguntas;
  final void Function(int) responder;

  const Questionario({
    required this.perguntaSelecionada,
    required this.perguntas,
    required this.responder,
    super.key,
  });

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas[perguntaSelecionada].cast()['respostas']
        : [];

    return SingleChildScrollView(
      child: Column(
        children: [
          Questao(
            perguntas[perguntaSelecionada]['pergunta'].toString(),
            numero: perguntaSelecionada,
          ),
          const SizedBox(height: 10),
          ...respostas.asMap().entries.map(
                (entry) => Resposta(
                  entry.value['texto'] as String,
                  () => responder(int.parse(entry.value['nota'].toString())),
                  indice: entry.key,
                ),
              ),
        ],
      ),
    );
  }
}
