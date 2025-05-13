import '../models/contact_model.dart';

class ContactService {
  // Lista de contactos de emergencia
  List<ContactModel> _contacts = [];

  // Obtener la lista de contactos
  List<ContactModel> get contacts => _contacts;

  // Establecer los contactos
  void setContacts(List<ContactModel> contacts) {
    _contacts = contacts;
  }

  // Agregar un contacto
  void addContact(ContactModel contact) {
    _contacts.add(contact);
  }

  // Borrar todos los contactos
  void clearContacts() {
    _contacts.clear();
  }
}
