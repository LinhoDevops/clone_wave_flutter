import 'package:flutter/material.dart';
import 'package:my_wave/models/bankItem.dart';
import 'package:my_wave/screen/activation_screen.dart';


class BankItemWidget extends StatelessWidget {
  final BankItem bankItem;

  const BankItemWidget({super.key, required this.bankItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivationScreen(bankItem: bankItem),
          ),
        );
      },
      child: Container(
        color: Colors.white, // Arrière-plan blanc
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding réduit
        child: Row(
          children: [
            Container(
              height: 36, // Taille réduite
              width: 36, // Taille réduite
              child: bankItem.img,
            ),
            const SizedBox(width: 16),
            Text(
              bankItem.name,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}