import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';
import './tela_inicial.dart';

void main() => runApp(const PerguntaApp());

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({super.key});

  @override
  State<PerguntaApp> createState() => _PerguntaAppState();
}

class _PerguntaAppState extends State<PerguntaApp> {
  var jogoIniciado = false;
  var perguntaSelecionada = 0;
  var acertos = 0;
  final perguntas = const [
    {
      'pergunta': 'Qual é a capital do Brasil?',
      'respostas': [
        {'texto': 'São Paulo', 'correta': false},
        {'texto': 'Brasília', 'correta': true},
        {'texto': 'Rio de Janeiro', 'correta': false},
        {'texto': 'Salvador', 'correta': false},
      ],
    },
    {
      'pergunta': 'Qual é o maior planeta do Sistema Solar?',
      'respostas': [
        {'texto': 'Saturno', 'correta': false},
        {'texto': 'Urano', 'correta': false},
        {'texto': 'Júpiter', 'correta': true},
        {'texto': 'Netuno', 'correta': false},
      ],
    },
    {
      'pergunta': 'Em que ano o Brasil foi descoberto?',
      'respostas': [
        {'texto': '1492', 'correta': false},
        {'texto': '1500', 'correta': true},
        {'texto': '1522', 'correta': false},
        {'texto': '1488', 'correta': false},
      ],
    },
    {
      'pergunta': 'Qual é a fórmula química da água?',
      'respostas': [
        {'texto': 'CO₂', 'correta': false},
        {'texto': 'H₂O₂', 'correta': false},
        {'texto': 'NaCl', 'correta': false},
        {'texto': 'H₂O', 'correta': true},
      ],
    },
    {
      'pergunta': 'Quantos estados tem o Brasil?',
      'respostas': [
        {'texto': '24', 'correta': false},
        {'texto': '25', 'correta': false},
        {'texto': '26', 'correta': true},
        {'texto': '27', 'correta': false},
      ],
    },
    {
      'pergunta': 'Qual é o maior oceano do mundo?',
      'respostas': [
        {'texto': 'Oceano Atlântico', 'correta': false},
        {'texto': 'Oceano Índico', 'correta': false},
        {'texto': 'Oceano Ártico', 'correta': false},
        {'texto': 'Oceano Pacífico', 'correta': true},
      ],
    },
  ];

  void responder(bool correta) {
    if (temPerguntaSelecionada) {
      setState(() {
        perguntaSelecionada++;
        if (correta) acertos++;
      });
    }
  }

  void iniciarJogo() {
    setState(() {
      jogoIniciado = true;
      perguntaSelecionada = 0;
      acertos = 0;
    });
  }

  void reiniciarQuestionario() {
    setState(() {
      jogoIniciado = false;
      perguntaSelecionada = 0;
      acertos = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6C63FF),
                Color(0xFF3B38C9),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quiz',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (jogoIniciado && temPerguntaSelecionada)
                        Text(
                          '${perguntaSelecionada + 1} / ${perguntas.length}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
                ),
                if (jogoIniciado && temPerguntaSelecionada)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: perguntaSelecionada / perguntas.length,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 6,
                      ),
                    ),
                  ),
                Expanded(
                  child: !jogoIniciado
                      ? TelaInicial(
                          totalPerguntas: perguntas.length,
                          aoIniciar: iniciarJogo,
                        )
                      : temPerguntaSelecionada
                          ? Questionario(
                              perguntaSelecionada: perguntaSelecionada,
                              perguntas: perguntas,
                              responder: responder,
                            )
                          : Resultado(acertos, perguntas.length, reiniciarQuestionario),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
