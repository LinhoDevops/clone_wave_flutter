import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class OperationScreen extends StatefulWidget {
  final bool isTransfer;

  const OperationScreen({super.key, required this.isTransfer});

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  List<Contact> favorites = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  void loadContacts() {
    contacts = [
      Contact(displayName: "Aliou NDOUR", phones: [Phone("771234567")]),
      Contact(displayName: "Aba FAll", phones: [Phone("765554433")]),
      Contact(displayName: "Bab's Diop", phones: [Phone("701234567")]),
      Contact(displayName: "Aissatou Lo", phones: [Phone("701111111")]),
      Contact(displayName: "Presi Kebe", phones: [Phone("709876543")]),
      Contact(displayName: "Lakh GUI", phones: [Phone("761234567")]),
    ];

    contacts.sort((a, b) => a.displayName.compareTo(b.displayName)); // Trie alphabétique
    filteredContacts.addAll(contacts);
    setState(() {});
  }

  void toggleFavorite(Contact contact) {
    setState(() {
      if (favorites.contains(contact)) {
        favorites.remove(contact);
        contacts.add(contact);
        contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
      } else {
        contacts.remove(contact);
        favorites.add(contact);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isTransfer ? "Envoyer de l'argent" : "Achat de crédit"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "A"),
                onChanged: (value) {
                  setState(() {
                    filteredContacts = contacts
                        .where((c) => c.displayName.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(45)),
                      child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Text(
                        widget.isTransfer ? "Envoyer à un nouveau numéro" : "Achat du crédit pour un nouveau numéro",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              if (favorites.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text("Favoris", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Column(
                  children: favorites.map((contact) => buildContactItem(contact, isFavorite: true)).toList(),
                ),
              ],
              const SizedBox(height: 20),
              const Text("Contacts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Column(
                children: filteredContacts.map((contact) => buildContactItem(contact)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactItem(Contact contact, {bool isFavorite = false}) {
    String number = contact.phones.isNotEmpty
        ? contact.phones[0].normalizedNumber
        : "Numéro inconnu";

    // Retirer le préfixe "+221" uniquement si présent
    if (number.startsWith("+221")) {
      number = number.replaceFirst("+221", "");
    }

    return GestureDetector(
      onDoubleTap: () => toggleFavorite(contact),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // Icône de profil
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Icon(Icons.person, color: Colors.black54, size: 22),
            ),
            const SizedBox(width: 10),

            // Nom et numéro dans une colonne
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom complet
                Text(
                  contact.displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16, // Taille de police ajustée
                  ),
                ),
                const SizedBox(height: 4), // Espace entre le nom et le numéro

                // Numéro de téléphone sans le préfixe +221
                Text(
                  number, // Affichage du numéro sans le préfixe +221
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14, // Taille de police ajustée
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
