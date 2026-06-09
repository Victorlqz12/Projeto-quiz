<h1 align="center">🧠 Quiz App</h1>

<p align="center">
  Aplicativo de quiz interativo desenvolvido em Flutter com feedback imediato de respostas.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=for-the-badge"/>
</p>

---

## ✨ Funcionalidades

- Tela inicial com contagem de perguntas disponíveis
- Barra de progresso durante o quiz
- Seleção e confirmação de respostas antes de revelar o gabarito
- Feedback visual imediato — verde para acerto, vermelho para erro
- Tela de resultado com pontuação, porcentagem e mensagem motivacional
- Botão para reiniciar o quiz

---

## 📱 Telas

| Tela Inicial | Questionário | Resultado |
|---|---|---|
| Apresenta o quiz e o botão de início | Exibe perguntas com opções A, B, C, D | Mostra acertos, percentual e emoji |

---

## 🗂️ Estrutura do Projeto

```
lib/
├── main.dart           # Ponto de entrada e gerenciamento de estado
├── tela_inicial.dart   # Tela de boas-vindas
├── questionario.dart   # Lógica de seleção e confirmação de respostas
├── questao.dart        # Widget do enunciado da pergunta
├── resposta.dart       # Widget de cada opção de resposta
└── resultado.dart      # Tela de resultado final
```

---

## 🚀 Como Executar

**Pré-requisitos:** Flutter instalado ([flutter.dev](https://flutter.dev))

```bash
# Instalar dependências
flutter pub get

# Rodar no dispositivo/emulador
flutter run

# Rodar no navegador
flutter run -d chrome
```

---

## 🛠️ Tecnologias

- **Flutter** — framework de UI multiplataforma
- **Dart** — linguagem de programação
- **Material Design 3** — sistema de design visual
- **StatefulWidget / StatelessWidget** — gerenciamento de estado nativo do Flutter

---

## 👤 Desenvolvido por

**Victor Alves da Silva**
