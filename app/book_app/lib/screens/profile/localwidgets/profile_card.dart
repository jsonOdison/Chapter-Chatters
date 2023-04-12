import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          color: const Color.fromARGB(255, 189, 186, 186),
          child: SizedBox(
            height: 200.0,
            width: 358,
            child: Column(
              children: [
                const SizedBox(height: 90),
                const Text(
                  'Card Title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Card description goes here',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        FractionalTranslation(
          translation: const Offset(0.0, -0.4),
          child: Align(
            alignment: const FractionalOffset(0.5, 0.0),
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: const Color(0xffFAF5E8),
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/group_image.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
