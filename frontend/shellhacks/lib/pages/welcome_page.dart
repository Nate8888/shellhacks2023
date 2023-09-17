import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shellhacks/pages/home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Invest with Purpose"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 10),
                child: Text(
                  "Invest\nwith Purpose",
                  style: GoogleFonts.nunito(
                    fontSize: 52.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 13, 76, 128),
                  ),
                ),
              ),
              Center(
                child: Container(
                  // color: Colors.grey[300],
                  width: 300,
                  child: Image.asset("assets/logo.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 229, 208),
                      padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: const Text(
                      'Learn with Koi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255, 244, 121, 49),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
