import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/modals/modal_close_app.dart';
import 'package:frontend/providers/general_provider.dart';
import 'package:frontend/routes/get_routes.dart';
import 'package:frontend/server/server.dart';
import 'package:frontend/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

late SharedPreferences? sharedPreferencesGeneral;
Server server = Server();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(900, 700),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  sharedPreferencesGeneral = await SharedPreferences.getInstance();
  server.startServer();

  runApp(MultiProvider(
    providers: [
      ListenableProvider<GeneralProvider>(
        create: (_) => GeneralProvider(),
      ),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fonles for Restaurants',
        theme: getLightThemeApp(),
        home: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fonles for Restaurants',
      theme: getLightThemeApp(),
      initialRoute: '/login',
      routes: getRoutes(),
    );
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    var status = await Server().getBackendStatus();

    if (_isPreventClose) {
      if (status) {
        getModalCloseApp(context, windowManager, server);
      } else {
        await windowManager.destroy();
      }
    }
  }
}
