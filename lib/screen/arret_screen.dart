import 'package:flutter/material.dart';
import 'package:my_wave/models/arrets.dart';

class ArretScreen extends StatefulWidget {
  final String type; // "Depart" ou "Arrive"

  const ArretScreen({
    Key? key,
    required this.type
  }) : super(key: key);

  @override
  State<ArretScreen> createState() => _ArretScreenState();
}

class _ArretScreenState extends State<ArretScreen> {
  @override
  Widget build(BuildContext context) {
    String title = widget.type == "Depart" ? "Sélectionner le départ" : "Sélectionner l'arrivée";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Retourne sans résultat
          },
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: Zone.zones.length,
              itemBuilder: (context, index) {
                return buildZoneSection(Zone.zones[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildZoneSection(Zone zone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  zone.name,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: zone.arrets.length,
          itemBuilder: (context, index) {
            return buildArretItem(zone.arrets[index]);
          },
        ),
      ],
    );
  }

  Widget buildArretItem(Arret arret) {
    return InkWell(
      onTap: () {
        print("Sélection: ${arret.name}"); // Pour débogage
        // Retourner le nom de l'arrêt sélectionné
        Navigator.of(context).pop(arret.name);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                arret.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}