import 'package:flutter/material.dart';
import 'package:my_wave/models/bankItem.dart';
import 'package:my_wave/widgets/bank_item_widget.dart';
import 'package:my_wave/widgets/prefix_search_widget.dart';

class BankScreen extends StatefulWidget {
  static String routeName = '/banks';

  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  BankType? selectedType;
  final TextEditingController controller = TextEditingController();
  late List<BankItem> filteredBankItems;

  @override
  void initState() {
    super.initState();
    filteredBankItems = List.from(bankItems);
    controller.addListener(_filterBanks);
  }

  void _filterBanks() {
    final text = controller.text.trim().toLowerCase();
    setState(() {
      filteredBankItems = bankItems
          .where((bank) => bank.name.toLowerCase().contains(text))
          .toList();
    });
  }

  List<BankItem> _filterBanksByType(BankType type) =>
      filteredBankItems.where((bank) => bank.type == type).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        title: const Text('Lier votre banque ou SFD'),
        backgroundColor: const Color(0xfff3f4f6),
        surfaceTintColor: const Color(0xfff3f4f6),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: PrefixSearchField(
              prefix: null,
              controller: controller,
              hintText: 'Rechercher ',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 80,
            child: Row(
              children: [
                _TabSwitcher(
                  onPressed: () {
                    setState(() {
                      selectedType =
                      selectedType == BankType.bank ? null : BankType.bank;
                    });
                  },
                  selected: selectedType == BankType.bank,
                  label: 'Banque',
                  icon: Icons.home_outlined,
                ),
                const SizedBox(width: 12),
                _TabSwitcher(
                  onPressed: () {
                    setState(() {
                      selectedType =
                      selectedType == BankType.sfd ? null : BankType.sfd;
                    });
                  },
                  selected: selectedType == BankType.sfd,
                  label: 'SFD',
                  icon: Icons.attach_money,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                if (selectedType == null || selectedType == BankType.bank)
                  _BankGroup(
                    label: 'Banques',
                    items: _filterBanksByType(BankType.bank),
                  ),
                const SizedBox(height: 32),
                if (selectedType == null || selectedType == BankType.sfd)
                  _BankGroup(
                    label: 'SFD',
                    items: _filterBanksByType(BankType.sfd),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_filterBanks);
    controller.dispose();
    super.dispose();
  }
}

class _TabSwitcher extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  const _TabSwitcher({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
        backgroundColor: WidgetStatePropertyAll(
          Colors.black12.withOpacity(selected ? 0.32 : 0.08),
        ),
      ),
      onPressed: onPressed,
      icon: Row(
        children: [
          Icon(icon),
          Text(label),
        ],
      ),
    );
  }
}

class _BankGroup extends StatelessWidget {
  final String label;
  final List<BankItem> items;

  const _BankGroup({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          color: Colors.white,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ...items.map((bank) => BankItemWidget(bankItem: bank)),
      ],
    );
  }
}
