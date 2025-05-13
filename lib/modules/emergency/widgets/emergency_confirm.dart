import 'package:flutter/material.dart';

class EmergencyConfirmedScreen extends StatelessWidget {
  const EmergencyConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergência Confirmada'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mensagem de emergência confirmada
            const Text(
              'Emergência Confirmada!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'A emergência foi acionada com sucesso.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Botão para voltar para a tela anterior
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Retorna para a tela anterior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('OK', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
