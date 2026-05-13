import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

void main() => runApp(const PerguntaApp());

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({super.key});

  @override
  State<PerguntaApp> createState() => _PerguntaAppState();
}

class _PerguntaAppState extends State<PerguntaApp> {
  var perguntaSelecionada = 0;
  var nota_total = 0;
  final perguntas = const [
    {
      'pergunta': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto' : 'Preto', 'nota': 10},
        {'texto' : 'Vermelho', 'nota': 5},
        {'texto' : 'Verde', 'nota': 3},
        {'texto' : 'Branco', 'nota': 1},
      ],
    },

    {
      'pergunta': 'Qual é o seu animal favorito?',
      'respostas': [
        {'texto' : 'Coelho', 'nota': 10},
        {'texto' : 'Tartaruga', 'nota': 5},
        {'texto' : 'Elefante', 'nota': 3},
        {'texto' : 'Leão', 'nota': 1},
      ],
    },

    {
      'pergunta': 'Qual seu tipo de alimento favorito?',
      'respostas': [
        {'texto' : 'Massas', 'nota': 10},
        {'texto' : 'Carnes', 'nota': 5},
        {'texto' : 'Grãos', 'nota': 3},
        {'texto' : 'Vegetais', 'nota': 1},
      ],
    },
    
  ];

  void responder(int nota) {
    if (temPerguntaSelecionada) {
      setState(() {
        perguntaSelecionada++;
        nota_total += nota;
      });
    }
  }

  void reiniciarQuestionario() {
    setState(() {
      perguntaSelecionada = 0;
      nota_total = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) { 

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(120, 0, 0, 255),
        ),
        body: temPerguntaSelecionada
            ? Questionario(perguntaSelecionada: perguntaSelecionada,
            perguntas: perguntas,
            responder: responder)
             : Resultado(nota_total, reiniciarQuestionario),
      ),
                
    );
            
                     
            
         
  }
}
        
    
  
