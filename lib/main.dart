import 'package:flutter/material.dart';
import 'package:invitation/application/send_invitation.dart';
import 'package:invitation/screen/home_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SendInvitation.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invitation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

