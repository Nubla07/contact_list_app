
import '../models/contact.dart';

class ContactController {
  final List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  void addContact(String name, String number) {
    if (name.isNotEmpty && number.isNotEmpty) {
      _contacts.add(Contact(name, number));
    }
  }

  void deleteContact(int index) {
    _contacts.removeAt(index);
  }
}
