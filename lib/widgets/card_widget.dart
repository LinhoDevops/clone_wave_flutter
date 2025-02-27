import 'package:flutter/material.dart';
import 'package:my_wave/screen/scan_screen.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CardWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final bool? isClickable;

  const CardWidget({
    Key? key,
    this.width,
    this.height,
    this.isClickable = false,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isClickable!) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanScreen(),
            ),
          );
        }
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: widget.width ?? 400,
          height: widget.height ?? 200,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: const AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(.3),
                BlendMode.srcIn,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Conteneur blanc au centre (QR code)
              Container(
                width: 110,
                height: 122,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(8.0),
                      child: PrettyQrView.data(
                        data: 'https://google.com',
                      ),
                    ),
                    widget.isClickable!
                        ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text("Scanner"),
                      ],
                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Image.asset(
                  'assets/images/launcher.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
