import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timely_plan/src/features/authentication/screens/login_screen.dart';
import 'package:timely_plan/src/features/authentication/screens/signup_screen.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;



    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children:  [
                Text("Welcome to the ultimate \n Time Management App!",
                  style: GoogleFonts.sortsMillGoudy(fontWeight: FontWeight.bold, fontSize: 30.0),
                  textAlign: TextAlign.center,),
                Image(image: const AssetImage("assets/images/icon.png"), height: height * 0.6),
                Text("Manage Time like a Pro!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sortsMillGoudy(fontWeight: FontWeight.bold, fontSize: 30.0),),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.deepPurple, width: 5)),
                    child: Text("Login".toUpperCase(),
                      style: const TextStyle(color: Colors.deepPurple),
                    )),
                  ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                    ),
                    onPressed: ()  => Get.to(() => const SignUpScreen()),
                    child: Text("Signup".toUpperCase()),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}