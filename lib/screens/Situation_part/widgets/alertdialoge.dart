import 'package:flutter/material.dart';

customAlertDialoge(
    BuildContext context, String? title, String content, String button) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title!,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              content,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Colors.green,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(button),
            ),
          ],
        ),
      );
    },
  );
}
