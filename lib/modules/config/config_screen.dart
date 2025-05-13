// lib/modules/config/config_screen.dart
import 'package:flutter/material.dart';
import '../../shared/services/contact_service.dart';
import 'widgets/contact_form.dart';
import '../../core/routes/app_routes.dart';

class ConfigScreen extends StatelessWidget {
  final ContactService contactService = ContactService();

  ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuraciones de Emergencia')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Seleccionar Fachada:'),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                _buildFacadeButton(context, 'Finanzas', AppRoutes.home),
                _buildFacadeButton(context, 'Calendario', AppRoutes.calendar),
                _buildFacadeButton(
                  context,
                  'Calculadora',
                  AppRoutes.calculator,
                ),
                _buildFacadeButton(context, 'Notas', AppRoutes.notes),
              ],
            ),
            const SizedBox(height: 20),
            ContactForm(contactService: contactService),
          ],
        ),
      ),
    );
  }

  Widget _buildFacadeButton(BuildContext context, String label, String route) {
    return ElevatedButton(
      onPressed: () {
        AppRoutes.currentFacade = route;
        Navigator.pushNamed(context, route);
      },
      child: Text(label),
    );
  }
}
