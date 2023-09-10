import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timely_plan/src/features/authentication/controllers/signup_controller.dart';
import 'package:timely_plan/src/features/authentication/screens/login_screen.dart';
class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.2,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  //Variables -- Declared in Constructor
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(image: AssetImage(image), color: imageColor, height: size.height * imageHeight),
        SizedBox(height: heightBetween),
        Text(title, style: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 40.0)),
        Text(subTitle, style: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 15.0)),
      ],
    );
  }
}
class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0 - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text("Full Name"),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: 30.0 - 20),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text("Email ID"), prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 30.0 - 20),
            TextFormField(
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                  label: Text("PhoneNo"), prefixIcon: Icon(Icons.numbers)),
            ),
            const SizedBox(height: 30.0 - 20),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                  label: Text("Password"), prefixIcon: Icon(Icons.fingerprint)),
            ),
            const SizedBox(height: 30.0 - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                  }
                },
                child: Text("SignUp".toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        const SizedBox(height: 10.0,),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Image(
              image: AssetImage("assets/images/img.png"),
              width: 20.0,
            ),
            label: Text("Sign In With Google".toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: ()  => Get.to(() => const LoginScreen()),
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "Already Have An Account?",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextSpan(text: " Login".toUpperCase())
          ])),
        )
      ],
    );
  }
}
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children:  const [
                FormHeaderWidget(
                  image: "assets/images/img_2.png",
                  title: "Get On Board!",
                  subTitle: "Create your profile to start your journey with us!",
                  imageHeight: 0.15,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}