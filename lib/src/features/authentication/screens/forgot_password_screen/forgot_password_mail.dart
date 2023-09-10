import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timely_plan/src/features/authentication/screens/forgot_password_screen/forgot_password_otp.dart';
class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
            image: const AssetImage("assets/images/img_1.png"),
            height: size.height * 0.2),
        Text("Forgot Password ", style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center,),
        Text("Verification through E-Mail", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
      ],
    );
  }
}
class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 30.0 * 4),
                const FormHeaderWidget(),
                const SizedBox(height: 30.0),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text("E-Mail"),
                            hintText: "E-Mail",
                            prefixIcon: Icon(Icons.mail_outline_rounded)),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => const OTPScreen());
                              },
                              child: const Text("Next"))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}