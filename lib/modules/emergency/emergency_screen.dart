import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import './widgets/emergency_confirm.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  int _secondsRemaining = 10;
  late Timer _timer;
  bool _isCancelled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Inicia a contagem regressiva
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0 && !_isCancelled) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        if (!_isCancelled) {
          _triggerEmergency(); // Chama emergência quando o tempo acabar
        }
      }
    });
  }

  // Chama a tela de emergência confirmada
  void _triggerEmergency() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const EmergencyConfirmedScreen()),
    );
  }

  // Cancela a contagem regressiva
  void _cancelTimer() {
    setState(() {
      _isCancelled = true;
    });
    _timer.cancel();
    Navigator.pop(context); // Volta para a tela anterior após o cancelamento
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergência'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animação de contagem regressiva
            Text(
              'Contagem regressiva para emergência',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              '$_secondsRemaining',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: _secondsRemaining > 3 ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 40),
            // Botão para cancelar
            ElevatedButton(
              onPressed: _cancelTimer,
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
              child: const Text(
                'Cancelar Emergência',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
