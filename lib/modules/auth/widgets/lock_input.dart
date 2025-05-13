import 'package:flutter/material.dart';

class LockInput extends StatefulWidget {
  final VoidCallback onUnlock;

  const LockInput({super.key, required this.onUnlock});

  @override
  State<LockInput> createState() => _LockInputState();
}

class _LockInputState extends State<LockInput> {
  final _passwordController = TextEditingController();
  final String _storedPassword = '1234'; // Simulado

  void _checkPassword() {
    if (_passwordController.text == _storedPassword) {
      widget.onUnlock();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Contraseña incorrecta')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ingresa tu contraseña para acceder'),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkPassword,
              child: const Text('Desbloquear'),
            ),
          ],
        ),
      ),
    );
  }
}
