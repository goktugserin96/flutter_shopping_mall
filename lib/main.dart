import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_mall/views/body.dart';

import 'controllers/MaterialProvider.dart';
import 'controllers/provider_class.dart';
import 'controllers/provider_class_sepet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShoppingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BasketProvider(),
        ),
        ChangeNotifierProvider(create: (context) => MaterialProvider())
      ],
      child: MyAppWithTheme(),
    );
  }
}

//main-> splash->Home
class MyAppWithTheme extends StatelessWidget {
  const MyAppWithTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialProvider themeDataboolean = Provider.of<MaterialProvider>(context);

    return MaterialApp(
      title: 'Splash screen Demo',
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: themeDataboolean.themeDataChoice,
    );
  }
}
