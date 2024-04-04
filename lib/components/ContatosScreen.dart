import 'package:flutter/material.dart';
import '../databases/ContatosDatabase.dart';

class ContatosScreen extends StatefulWidget {
  @override
  _ContatosScreenState createState() => _ContatosScreenState();
}

class _ContatosScreenState extends State<ContatosScreen> {
  late Future<List<Map<String, dynamic>>> _contacts;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _contacts = ContatosDatabase.getAllContacts(); // Mova a chamada para dentro do método build

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adicionar Contato',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _saveContact(context);
                    },
                    child: const Text('Salvar Contato'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Contatos Salvos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _contacts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar contatos: ${snapshot.error}');
                  } else {
                    final contacts = snapshot.data!;
                    return Column(
                      children: contacts.map((contact) {
                        return ListTile(
                          title: Text(contact['nome']),
                          subtitle: Text(contact['telefone']),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveContact(BuildContext context) async {
    final String name = _nameController.text;
    final String phone = _phoneController.text;

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    try {
      await ContatosDatabase.saveContact(name, phone);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contato salvo com sucesso')),
      );
      _nameController.clear();
      _phoneController.clear();
      setState(() {
        // Atualiza a lista de contatos após salvar um novo contato
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar contato: $error')),
      );
    }
  }
}
