import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final VoidCallback? onTap; // Makes the tap action customizable
  final double horizontalMargin;
  final double verticalPadding;
  const MyCard({
    super.key,
    required this.title,
    required this.icon,
    this.backgroundColor = const Color.fromARGB(255, 75, 58, 183),
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.onTap,
    this.horizontalMargin = 40,
    this.verticalPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        borderOnForeground: true,
        color: const Color.fromARGB(255, 75, 58, 183),
        surfaceTintColor: Colors.black12,
        child: Padding(
          padding: EdgeInsets.all(verticalPadding),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              SizedBox(width: 10),
              Text(title, style: TextStyle(color: textColor, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
