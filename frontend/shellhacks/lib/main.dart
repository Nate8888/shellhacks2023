import 'package:flutter/material.dart';
import 'package:shellhacks/pages/home_page.dart';
import 'package:shellhacks/pages/news_page.dart';
import 'package:shellhacks/pages/profile_page.dart';
import 'package:shellhacks/pages/rankings_page.dart';
import 'package:shellhacks/pages/voice_page.dart';
import 'package:shellhacks/pages/welcome_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final SettingsProvider settingsProvider = SettingsProvider();

  @override
  void initState() {
    super.initState();
    // settingsProvider.loadBackendUrl();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(create: (_) => UserProvider()),
        //     ChangeNotifierProvider(create: (_) => NoteListProvider()),
        //   ],
        //   child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'shellhacks',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        // fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/home': (context) => HomePage(),
        '/news': (context) => NewsPage(),
        '/profile': (context) => ProfilePage(),
        '/rankings': (context) => RankingsPage(),
        '/voice': (context) => VoicePage(),
      },
      // ),
    );
  }
}
