import 'package:flutter/material.dart';

getModalCloseApp(context, windowManager, server) {
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          '¿Te gustaría apagar el servidor también?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () async {
              Navigator.of(context).pop();
              await windowManager.destroy();
            },
          ),
          TextButton(
            child: Text('Si'),
            onPressed: () async {
              await server.stopServer();
              Navigator.of(context).pop();
              await windowManager.destroy();
            },
          ),
        ],
      );
    },
  );
}
