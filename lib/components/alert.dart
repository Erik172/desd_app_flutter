import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget infoAlert(BuildContext context, String title, String content) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).secondaryHeaderColor,
    ),
    width: MediaQuery.of(context).size.width * 0.8,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.info, color: Theme.of(context).primaryColor),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true,
              ),
              
              const SizedBox(height: 10),
              
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: content));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Identificador copiado al portapapeles.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  content,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
