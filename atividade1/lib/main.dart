import 'package:flutter/material.dart';
import 'resultado.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jokenpo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pedra, Papel, Tesoura'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget botao(String imagem, String escolha) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Resultado(escolhaUsuario: escolha),
          ),
        );
      },
      child: ClipOval(
        child: Image.asset(
          imagem,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            Image.asset(
              "assets/images/padrao.png",
              width: 140,
              height: 140,
            ),

            const Text(
              "Escolha do APP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 200),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                botao("assets/images/pedra.png", "pedra"),
                botao("assets/images/papel.png", "papel"),
                botao("assets/images/tesoura.png", "tesoura"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}