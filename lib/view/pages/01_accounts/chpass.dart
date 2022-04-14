import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/shared/config/app_images.dart';
import 'package:quiz_app_api/view/pages/01_accounts/login.dart';
import 'package:quiz_app_api/view/widgets/input_field.dart';

import '../../../layouts/main_layout.dart';
import '../../widgets/main_button.dart';
import '../../widgets/sub_title.dart';

TextEditingController passwordController1 = TextEditingController();
TextEditingController passwordController2 = TextEditingController();
bool hidePassword = true;
var passwordFormKey = GlobalKey<FormState>();

class CreatePassword extends StatelessWidget {
  const CreatePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        showBack: false,
        body: Form(
          key: passwordFormKey,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: double.maxFinite,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.PASSWORD),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SubTitle(
                      "Sign in with your email and password to continue"),
                  const SizedBox(height: 20),
                  InputField(
                    textController: passwordController1,
                    label: "Password",
                    hint: "Enter new password",
                    isPassword: true,
                    prefix: Icons.lock,
                    suffix: Icons.remove_red_eye,
                    // isPassword:
                    //     !LoginCubit.get(context).showPassword ? true : false,
                    validate: (value) {
                      if (value!.isEmpty) return 'Password must be filled';
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  InputField(
                    textController: passwordController2,
                    label: "Password",
                    hint: "Enter new password",
                    isPassword: true,
                    prefix: Icons.lock,
                    suffix: Icons.remove_red_eye,
                    // isPassword:
                    //     !LoginCubit.get(context).showPassword ? true : false,
                    validate: (value) {
                      if (value!.isEmpty) return 'Password must be filled';
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        footer: [
          MainButton(
            title: "Continue",
            onTap: () {
              Get.offAll(() => const LoginScreen());
            },
          ),
        ]);
  }
}
