import 'package:animated_ui/screens/onboding/onboding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'component/side_menu.dart';
import 'entry_point.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) {
    runApp(const MyApp());

  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
      ),
      home:  OnbodingScreen(),
    );
  }
}


