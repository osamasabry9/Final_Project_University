import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/view/pages/01_accounts/verificatoin.dart';
import 'package:quiz_app_api/view/widgets/input_field.dart';

import '../../../shared/config/app_images.dart';
import '../../../layouts/main_layout.dart';
import '../../widgets/main_button.dart';
import '../../widgets/main_title.dart';
import '../../widgets/sub_title.dart';

TextEditingController emailController = TextEditingController();
var forgetFormKey = GlobalKey<FormState>();

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        showBack: true,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const MainTitle("Password Recovery"),
                const SizedBox(height: 10),
                Container(
                  //width: double.maxFinite,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.Forgot),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: forgetFormKey,
                  child: const SubTitle(
                      "Enter your email address or phone number to recover your password"),
                ),
                const SizedBox(height: 30),
                InputField(
                  textController: emailController,
                  label: "Email / Phone number",
                  hint: "Enter email or phone number",
                  prefix: Icons.email_outlined,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Email Address must be filled';
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        footer: [
          MainButton(
            title: "Continue",
            onTap: () => Get.to(() => const Verificatoin()),
          ),
        ]);
  }
}
