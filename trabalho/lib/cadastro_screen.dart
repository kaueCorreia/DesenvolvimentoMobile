import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'confirmacao_screen.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FocusNode nomeFocus = FocusNode();
  final FocusNode idadeFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  String? sexoSelecionado;
  bool aceitouTermos = false;

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void cadastrar() {
    String nome = nomeController.text.trim();
    String idadeTexto = idadeController.text.trim();
    String email = emailController.text.trim();

    if (nome.isEmpty) {
      mostrarMensagem("O nome não pode estar vazio.");
      return;
    }

    if (idadeTexto.isEmpty) {
      mostrarMensagem("A idade não pode estar vazia.");
      return;
    }

    int? idade;
    try {
      idade = int.parse(idadeTexto);
    } catch (e) {
      mostrarMensagem("A idade deve ser um número válido.");
      return;
    }

    if (idade < 18) {
      mostrarMensagem("A idade deve ser maior ou igual a 18.");
      return;
    }

    if (email.isEmpty) {
      mostrarMensagem("O email não pode estar vazio.");
      return;
    }

    if (!email.contains("@") || !email.contains(".")) {
      mostrarMensagem("Digite um email válido.");
      return;
    }

    if (sexoSelecionado == null) {
      mostrarMensagem("Selecione o sexo.");
      return;
    }

    if (!aceitouTermos) {
      mostrarMensagem("Você precisa aceitar os termos de uso.");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmacaoScreen(
          nome: nome,
          idade: idade!,
          email: email,
          sexo: sexoSelecionado!,
          termosAceitos: aceitouTermos,
        ),
      ),
    );
  }

  InputDecoration campoDecoracao({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.deepPurple.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.deepPurple.shade100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    emailController.dispose();

    nomeFocus.dispose();
    idadeFocus.dispose();
    emailFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Usuário"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 8,
                shadowColor: Colors.deepPurple.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 70,
                        color: Colors.deepPurple,
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Crie sua conta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Preencha os campos abaixo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 30),

                      TextField(
                        controller: nomeController,
                        focusNode: nomeFocus,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) {
                          FocusScope.of(context).requestFocus(idadeFocus);
                        },
                        decoration: campoDecoracao(
                          label: "Nome",
                          hint: "Digite seu nome completo",
                          icon: Icons.person_outline,
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: idadeController,
                        focusNode: idadeFocus,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) {
                          FocusScope.of(context).requestFocus(emailFocus);
                        },
                        decoration: campoDecoracao(
                          label: "Idade",
                          hint: "Digite sua idade",
                          icon: Icons.cake_outlined,
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: emailController,
                        focusNode: emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: campoDecoracao(
                          label: "Email",
                          hint: "Digite seu email",
                          icon: Icons.email_outlined,
                        ),
                      ),

                      const SizedBox(height: 18),

                      DropdownButtonFormField<String>(
                        value: sexoSelecionado,
                        decoration: campoDecoracao(
                          label: "Sexo",
                          hint: "Selecione uma opção",
                          icon: Icons.people_outline,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Masculino",
                            child: Text("Masculino"),
                          ),
                          DropdownMenuItem(
                            value: "Feminino",
                            child: Text("Feminino"),
                          ),
                          DropdownMenuItem(
                            value: "Outro",
                            child: Text("Outro"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            sexoSelecionado = value;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.deepPurple.shade100),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.deepPurple,
                              value: aceitouTermos,
                              onChanged: (value) {
                                setState(() {
                                  aceitouTermos = value!;
                                });
                              },
                            ),
                            const Expanded(
                              child: Text(
                                "Aceito os termos de uso",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          onPressed: cadastrar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Cadastrar",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}