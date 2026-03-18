import 'dart:math';
import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {
  final String escolhaUsuario;

  const Resultado({super.key, required this.escolhaUsuario});

  @override
  State<Resultado> createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  String escolhaApp = '';
  String resultadoTexto = '';
  String resultadoImagem = '';

  @override
  void initState() {
    super.initState();
    jogar();
  }

  void jogar() {
    final opcoes = ['pedra', 'papel', 'tesoura'];
    escolhaApp = opcoes[Random().nextInt(3)];

    if (widget.escolhaUsuario == escolhaApp) {
      resultadoTexto = "Empate";
      resultadoImagem = "assets/images/icons8-aperto-de-maos-100.png";
    } else if (
    (widget.escolhaUsuario == 'pedra' && escolhaApp == 'tesoura') ||
        (widget.escolhaUsuario == 'papel' && escolhaApp == 'pedra') ||
        (widget.escolhaUsuario == 'tesoura' && escolhaApp == 'papel')) {
      resultadoTexto = "Você ganhou!";
      resultadoImagem = "assets/images/icons8-vitoria-48.png";
    } else {
      resultadoTexto = "Você perdeu!";
      resultadoImagem = "assets/images/icons8-perder-48.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedra, Papel, Tesoura", style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/$escolhaApp.png",
              width: 120,
            ),
            const SizedBox(height: 10),
            const Text("Escolha do APP",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              ),
            ),
            const SizedBox(height: 40),
            Image.asset(
              "assets/images/${widget.escolhaUsuario}.png",
              width: 120,
            ),
            const SizedBox(height: 10),
            const Text("Sua escolha", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24)
            ),

            const SizedBox(height: 40),

            Image.asset(
              resultadoImagem,
              width: 80,
            ),

            const SizedBox(height: 10),
            Text(
              resultadoTexto,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Jogar novamente"),
            ),
          ],
        ),
      ),
    );
  }
}