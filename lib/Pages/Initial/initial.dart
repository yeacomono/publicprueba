import 'package:flutter/material.dart';
import 'package:tennis_court_agend/Pages/Home/home.dart';
import 'package:tennis_court_agend/Styles/colors.dart';

class InitialPage extends StatefulWidget {
  static const String routeName = 'InitialPage';
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    initializedServices();
    super.initState();
  }

  void initializedServices() async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );
    if (mounted) Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: StylesColors.backgroundColor,
        child: const Center(
          child:  Text(
            'Reserved-App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 40
            ),
          ),
        ),
      ),
    );
  }
}
