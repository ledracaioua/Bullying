import 'package:flutter/material.dart';

class LockInput extends StatefulWidget {
  final VoidCallback onUnlock;

  const LockInput({super.key, required this.onUnlock});

  @override
  State<LockInput> createState() => _LockInputState();
}

class _LockInputState extends State<LockInput> with TickerProviderStateMixin {
  final String _storedPassword = '1234'; // Senha simulada
  String _inputPassword = ''; // Armazenar a senha digitada
  bool _isIncorrectPassword = false; // Indica se a senha está errada
  bool _isUnlocked = false; // Controle de desbloqueio

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _checkPassword() {
    if (_inputPassword == _storedPassword) {
      setState(() {
        _isUnlocked = true;
        _isIncorrectPassword = false;
      });
      widget.onUnlock(); // Desbloqueia a tela automaticamente
    } else {
      setState(() {
        _isIncorrectPassword = true;
      });
      _animationController.forward().then(
        (_) => _animationController.reverse(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Contraseña incorrecta')));
    }
  }

  void _appendToPassword(String digit) {
    setState(() {
      if (_inputPassword.length < 4) {
        _inputPassword += digit; // Adiciona o número ao campo
      }
      if (_inputPassword.length == 4 && _inputPassword == _storedPassword) {
        _checkPassword(); // Se a senha estiver completa e for correta, desbloqueia automaticamente
      }
    });
  }

  void _removeLastDigit() {
    setState(() {
      if (_inputPassword.isNotEmpty) {
        _inputPassword = _inputPassword.substring(0, _inputPassword.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Pega as cores do tema
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza o conteúdo verticalmente
          children: [
            // Texto explicativo no topo
            const SizedBox(height: 16),
            const Text(
              'Ingresa tu contraseña para acceder',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Visualização da senha com asteriscos, centralizado
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centraliza o preview da senha
              children: [
                Text(
                  '*' * _inputPassword.length,
                  style: const TextStyle(fontSize: 30, letterSpacing: 10),
                ),
                GestureDetector(
                  onTap: _removeLastDigit,
                  child: Icon(Icons.backspace, color: Colors.red, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Grid de botões 1 a 9 + 0
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 colunas para os números
                  childAspectRatio: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 11, // Agora são 10 botões (1 a 9 e o 0)
                itemBuilder: (context, index) {
                  if (index == 9) {
                    // Adiciona um separador entre o 9 e o 10
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    );
                  }
                  // Adiciona o botão '0' como o último item
                  return _buildButton(
                    (index == 10) ? '0' : (index + 1).toString(),
                    theme,
                    isDarkMode,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para criar o botão normal com animação
  Widget _buildButton(String label, ThemeData theme, bool isDarkMode) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final color =
            _isIncorrectPassword
                ? Colors.red
                : (isDarkMode ? Colors.teal.shade700 : Colors.teal.shade400);
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            backgroundColor: color,
            textStyle: const TextStyle(fontSize: 22),
          ),
          onPressed: () => _appendToPassword(label),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
        );
      },
    );
  }
}
