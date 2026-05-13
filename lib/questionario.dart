import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatefulWidget {
  final int perguntaSelecionada;
  final List<Map<String, Object>> perguntas;
  final void Function(bool) responder;

  const Questionario({
    required this.perguntaSelecionada,
    required this.perguntas,
    required this.responder,
    super.key,
  });

  @override
  State<Questionario> createState() => _QuestionarioState();
}

class _QuestionarioState extends State<Questionario> {
  int? _respostaSelecionada;

  @override
  void didUpdateWidget(Questionario oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.perguntaSelecionada != widget.perguntaSelecionada) {
      setState(() => _respostaSelecionada = null);
    }
  }

  void _selecionarResposta(int indice) {
    if (_respostaSelecionada != null) return;
    setState(() => _respostaSelecionada = indice);
  }

  @override
  Widget build(BuildContext context) {
    final perguntas = widget.perguntas;
    final idx = widget.perguntaSelecionada;
    final List<Map<String, Object>> respostas =
        (perguntas[idx]['respostas'] as List).cast();

    bool? acertou;
    if (_respostaSelecionada != null) {
      acertou = respostas[_respostaSelecionada!]['correta'] as bool;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Questao(perguntas[idx]['pergunta'].toString(), numero: idx),
          const SizedBox(height: 10),
          ...respostas.asMap().entries.map((entry) {
            final eCorreta = entry.value['correta'] as bool;
            EstadoResposta estado = EstadoResposta.normal;
            if (_respostaSelecionada != null) {
              if (eCorreta) {
                estado = EstadoResposta.correta;
              } else if (entry.key == _respostaSelecionada) {
                estado = EstadoResposta.errada;
              }
            }
            return Resposta(
              entry.value['texto'] as String,
              () => _selecionarResposta(entry.key),
              indice: entry.key,
              estado: estado,
            );
          }),
          if (_respostaSelecionada != null) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: acertou!
                        ? Colors.green.withValues(alpha: 0.3)
                        : Colors.red.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    acertou ? '✓ Correto!' : '✗ Errado!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => widget.responder(acertou!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    idx + 1 < perguntas.length ? 'Próxima Pergunta' : 'Ver Resultado',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
