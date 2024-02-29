import 'package:flutter/material.dart';

class QuickAlert extends StatelessWidget {
  final String text;
  final QuickAlertType type;

  const QuickAlert({
    required this.text,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color? color;
    switch (type) {
      case QuickAlertType.error:
        color = Colors.red;
        break;
      case QuickAlertType.success:
        color = Colors.green;
        break;
      case QuickAlertType.loading:
        color = Colors.blue;
      default:
        color = Colors.blue;
        break;
    }

    return Container(
      height: 100, // Adjust height as needed
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

enum QuickAlertType { error, success, info, loading }
