import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timely_plan/src/features/authentication/controllers/login_controller.dart';
import 'package:timely_plan/src/features/authentication/screens/forgot_password_screen/forgot_password_mail.dart';
import 'package:timely_plan/src/features/authentication/screens/signup_screen.dart';
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage("assets/images/img_2.png"),
            height: size.height * 0.2),
        Text("Welcome Back, ", style: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 40.0)),
        Text("Make it work, make it right, make it fast.", style: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 19.0))

      ],
    );
  }
}
class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    final controller = Get.put(LoginController());

    return Form(
      key: _formkey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0 - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator:  (value) {
             if (value == null || value.isEmpty) {
             return 'Please enter your E-Mail';
             }
            return null;
            },
              controller: controller.email,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: "Email id",
                  hintText: "Enter your Email ID",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30.0 - 20),
                  TextFormField(
                    validator:  (value) {
                   if (value == null || value.isEmpty) {
                   return 'Please enter your password';
                   }
                   return null;
                   },
                  controller: controller.password,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "Enter your password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
            ),
            const SizedBox(height: 30.0 - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(context: context,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Make Selection!", style: Theme.of(context).textTheme.displaySmall),
                              Text("Select one of the options given below to reset your password", style: Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 30.0,),
                              GestureDetector(
                                onTap: (){
                                Navigator.pop(context);
                                Get.to(() => const ForgetPasswordMailScreen());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey.shade200
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.mail_outline_rounded, size: 60.0,),
                                      const SizedBox(width: 10.0,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("E-Mail",style: Theme.of(context).textTheme.titleMedium,),
                                          Text("Reset via Mail Verification", style: Theme.of(context).textTheme.bodyLarge,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.shade200
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.mobile_friendly_rounded, size: 60.0,),
                                      const SizedBox(width: 10.0,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Phone No.",style: Theme.of(context).textTheme.titleMedium,),
                                          Text("Reset via Phone Verification", style: Theme.of(context).textTheme.bodyLarge,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                        ));
                  }, child: const Text("Forgot Password?")),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(_formkey.currentState!.validate()) {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: controller.email.text.trim(),
                  password: controller.password.text.trim());
                }
                },
                child: Text("Login".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: 30.0 - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage("assets/images/img.png"), width: 20.0),
            onPressed: () {},
            label: const Text("Sign In With Google"),
          ),
        ),
        const SizedBox(height: 30.0 - 20),
        TextButton(
          onPressed: ()  => Get.to(() => const SignUpScreen()),
          child: Text.rich(
            TextSpan(
                text: "Don't Have An Account?",
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(text: " SignUp", style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoginHeaderWidget(),
                LoginForm(),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}