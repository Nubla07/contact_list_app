import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/contact_controller.dart';
import '../models/contact.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final ContactController _controller = ContactController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  void _addContact() {
    setState(() {
      _controller.addContact(_nameController.text, _numberController.text);
    });
    _nameController.clear();
    _numberController.clear();
  }

  void _deleteContact(int index) {
    setState(() {
      _controller.deleteContact(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Contact List',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 4),
            child: TextField(
              
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _addContact,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(double.infinity, 45),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        5.0), // Adjust the radius as needed
                  ),
                ),
              ),
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _controller.contacts.length,
              itemBuilder: (context, index) {
                final Contact contact = _controller.contacts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.grey.shade300,
                    leading: const Icon(
                      Icons.person,
                      color: Colors.brown,
                    ),
                    title: Text(
                      contact.name,
                      style: const TextStyle(color: Colors.red),
                    ),
                    subtitle: Text(contact.number),
                    trailing: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.blue),
                      onPressed: () {
                    
                      },
                    ),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text('Are you sure for Delete?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                'assets/file-slash.svg',
                                width: 24,
                                height: 24,
                                color: Colors.cyan,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteContact(index);
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                'assets/delete.svg',
                                width: 24,
                                height: 24,
                                color: Colors.cyan,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey, // Divider color
                  thickness: 1,
                  height: 0, // Divider thickness
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
