import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinehouse/screenthree.dart';
import 'package:pinehouse/screentwo.dart';
import 'package:pinehouse/screen_one.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    ScreenOne(),
    DemoScreen(),
    DetailPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.lightBlue,
        child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: GoogleFonts.raleway(),
            backgroundColor: Colors.blue.shade300,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            currentIndex: currentIndex,
            iconSize: 28,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'SCREEN 1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.offline_bolt_sharp),
                label: 'SCREEN 2',
              ),
            ]),
      ),
    );
  }
}
