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
  bool _confirmada = false;

  @override
  void didUpdateWidget(Questionario oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.perguntaSelecionada != widget.perguntaSelecionada) {
      setState(() {
        _respostaSelecionada = null;
        _confirmada = false;
      });
    }
  }

  void _selecionarResposta(int indice) {
    if (_confirmada) return;
    setState(() => _respostaSelecionada = indice);
  }

  void _confirmar() {
    if (_respostaSelecionada == null) return;
    setState(() => _confirmada = true);
  }

  @override
  Widget build(BuildContext context) {
    final perguntas = widget.perguntas;
    final idx = widget.perguntaSelecionada;
    final List<Map<String, Object>> respostas =
        (perguntas[idx]['respostas'] as List).cast();

    bool? acertou;
    if (_confirmada && _respostaSelecionada != null) {
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
            if (_confirmada) {
              if (eCorreta) {
                estado = EstadoResposta.correta;
              } else if (entry.key == _respostaSelecionada) {
                estado = EstadoResposta.errada;
              }
            } else if (entry.key == _respostaSelecionada) {
              estado = EstadoResposta.selecionada;
            }
            return Resposta(
              entry.value['texto'] as String,
              () => _selecionarResposta(entry.key),
              indice: entry.key,
              estado: estado,
            );
          }),
          const SizedBox(height: 12),
          if (!_confirmada && _respostaSelecionada != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _confirmar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Confirmar Resposta',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          if (_confirmada) ...[
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
