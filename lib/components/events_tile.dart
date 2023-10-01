import 'package:flutter/material.dart';

class CustomColoredImageContainer extends StatefulWidget {
  final String imagePath;
  final Function(bool) onImageTap;
  final Color defaultImageColor;
  final Color tappedImageColor;

  const CustomColoredImageContainer({
    Key? key,
    required this.imagePath,
    required this.onImageTap,
    required this.defaultImageColor,
    required this.tappedImageColor,
  }) : super(key: key);

  @override
  CustomColoredImageContainerState createState() =>
      CustomColoredImageContainerState();
}

class CustomColoredImageContainerState
    extends State<CustomColoredImageContainer> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
        widget.onImageTap(isTapped);
      },
      child: Container(
        height: 60,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.defaultImageColor, // Cor da borda vermelha
            width: 5,
          ),
          color: isTapped ? widget.defaultImageColor : Colors.transparent,
        ),
        child: Image.asset(
          widget.imagePath,
          height: 30,
          color: isTapped
              ? Colors.white
              : widget.defaultImageColor, // Aplicar cor branca quando clicado
        ),
      ),
    );
  }
}
