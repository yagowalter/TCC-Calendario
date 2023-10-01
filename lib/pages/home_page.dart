import 'package:calendario/pages/perfil_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'calendar_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

void logout() {
  FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [CalendarScreen(), Perfil()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      home: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 65, vertical: 10),
            child: GNav(
                duration: Duration(milliseconds: 800),
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(13),
                tabBackgroundColor: Color(0xFF202C39),
                activeColor: Colors.white,
                gap: 8,
                selectedIndex: currentIndex,
                onTabChange: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                tabs: const [
                  GButton(
                      text: 'Calendário',
                      icon: Icons.calendar_month_outlined,
                      iconColor: Color(0xffa6a6a6)),
                  GButton(
                      text: 'Perfil',
                      icon: Icons.person,
                      iconColor: Color(0xffa6a6a6))
                ]),
          ),
        ),
      ),
    );
  }
}
