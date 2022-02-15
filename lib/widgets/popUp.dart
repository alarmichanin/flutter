import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context, int statusCode) {
  double screenWidth = MediaQuery.of(context).size.width;
  return AlertDialog(
    title: Center(
        child: (statusCode==1)
            ? const Text('YOUR FILE HAS BEEN SUBMITTED')
            : const Text('YOUR FILE HASN\'T BEEN SUBMITTED')),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline,
                size: screenWidth * 0.3,
                color: statusCode == 200 ? Colors.green : Colors.red),
          ],
        ),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Center(child: Text('CLOSE')),
      ),
    ],
  );
}
