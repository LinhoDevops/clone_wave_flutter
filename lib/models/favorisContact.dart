import 'package:my_wave/models/contact.dart';

class FavorisContact {
  static final List<ContactModel> _favoris = [];

  static List<ContactModel> get favoris => _favoris;

  static void ajouterOuSupprimer(ContactModel contact) {
    if (_favoris.contains(contact)) {
      _favoris.remove(contact);
    } else {
      _favoris.add(contact);
    }
  }

  static bool estFavori(ContactModel contact) {
    return _favoris.contains(contact);
  }
}
