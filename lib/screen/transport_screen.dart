import 'package:flutter/material.dart';
import 'package:my_wave/models/trajetFavoris.dart';
import 'package:my_wave/screen/arret_screen.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({Key? key}) : super(key: key);

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  String? departSelectionne;
  String? arriveSelectionne;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Acheter un billet',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Carte SunuBRT
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset('assets/images/sunubrt.png'),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'SunuBRT',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Sélection du trajet
                    _buildSelectionCard(context),

                    const SizedBox(height: 16),

                    // Texte informatif
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Les tickets sont valables une heure.',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Achetez votre ticket quand vous êtes prêt à partir.',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Bouton d'achat
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Acheter un billet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Section "Acheter à nouveau"
                    const Text(
                      'Acheter à nouveau',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Itinéraires fréquents
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _trajetWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour la sélection du départ et de l'arrivée
  Widget _buildSelectionCard(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sélection du départ
            GestureDetector(
              onTap: () {
                _selectArret(context, "Depart");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    departSelectionne ?? 'Sélectionner le départ',
                    style: TextStyle(
                      color: departSelectionne != null ? Colors.black : Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            Row(
              children: [
                const Expanded(child: Divider(thickness: 2, height: 32)),
                Transform.translate(
                  offset: const Offset(-50, 0),
                  child: GestureDetector(
                    onTap: _swapDepartArrive,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.swap_vert,
                        color: Colors.lightBlue,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Sélection de l'arrivée
            GestureDetector(
              onTap: () {
                _selectArret(context, "Arrive");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    arriveSelectionne ?? 'Sélectionner l\'arrivée',
                    style: TextStyle(
                      color: arriveSelectionne != null ? Colors.black : Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour sélectionner un arrêt
  Future<void> _selectArret(BuildContext context, String type) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => ArretScreen(type: type),
      ),
    );

    if (result != null) {
      setState(() {
        if (type == "Depart") {
          departSelectionne = result;
        } else {
          arriveSelectionne = result;
        }
      });
    }
  }

  // Méthode pour intervertir le départ et l'arrivée
  void _swapDepartArrive() {
    setState(() {
      final temp = departSelectionne;
      departSelectionne = arriveSelectionne;
      arriveSelectionne = temp;
    });
  }

  // Widget pour les itinéraires favoris
  Widget _trajetWidget() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: TrajetFavoris.trajets.length,
      itemBuilder: (context, index) {
        TrajetFavoris t = TrajetFavoris.trajets[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_downward),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.depart),
                        Text(t.arrive),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Text("CFA"),
                        const SizedBox(width: 5),
                        Text(t.prix.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2, color: Colors.grey),
            ],
          ),
        );
      },
    );
  }
}