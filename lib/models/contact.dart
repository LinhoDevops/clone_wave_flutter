// Le modèle Contact
class ContactModel {
  String displayName;
  String phoneNumber;

  ContactModel({required this.displayName, required this.phoneNumber});
}

// Liste statique des contacts
class ContactList {
  static final List<ContactModel> contacts = [
    ContactModel(displayName: "Aliou NDOUR", phoneNumber: "771234567"),
    ContactModel(displayName: "Aba FAll", phoneNumber: "765554433"),
    ContactModel(displayName: "Bab's Diop", phoneNumber: "701234567"),
    ContactModel(displayName: "Aissatou Lo", phoneNumber: "701111111"),
    ContactModel(displayName: "Presi Kebe", phoneNumber: "709876543"),
    ContactModel(displayName: "Lakh GUI", phoneNumber: "761234567"),
  ];
}
