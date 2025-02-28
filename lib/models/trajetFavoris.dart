
class TrajetFavoris {
  final String depart;
  final String arrive;
  final int prix;

  TrajetFavoris({required this.depart, required this.arrive, required this.prix});

  static List<TrajetFavoris> trajets = [
    TrajetFavoris(depart: 'Sacré-Coeur', arrive: 'Place de la Nation', prix: 400),
    TrajetFavoris(depart: 'Place de la Nation', arrive: 'Scat Urbam', prix: 500),
    TrajetFavoris(depart: 'Grande Mosquée', arrive: 'Sacré-Coeur', prix: 500)
  ];
}
