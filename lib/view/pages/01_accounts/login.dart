import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/controllers/login_controller.dart';
import 'package:quiz_app_api/resources/cache_helper.dart';
import 'package:quiz_app_api/shared/constants.dart';
import 'package:quiz_app_api/view/pages/01_accounts/fpass.dart';
import 'package:quiz_app_api/view/widgets/input_field.dart';

import '../../../shared/config/app_images.dart';
import '../../../shared/config/app_styles.dart';
import '../../../layouts/main_layout.dart';
import '../../widgets/input_field_label.dart';
import '../../widgets/main_button.dart';
import '../../widgets/sub_title.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBack: false,
      body: Form(
        key: controller.loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: double.maxFinite,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.welcome),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                InputField(
                  textController: controller.emailController,
                  label: "UserName",
                  hint: "Enter User Name",
                  prefix: Icons.person,
                  validate: (value) {
                    return controller.validateEmail(value!.toString());
                  },
                ),
                const SizedBox(height: 15),
                Obx(
                  () => InputField(
                    textController: controller.passwordController,
                    label: "Password",
                    hint: "Enter password",
                    isPassword: controller.isPassword.value,
                    prefix: Icons.lock,
                    suffix: Icons.remove_red_eye,
                    suffixPressed: () {
                      controller.changePasswordVisibility();
                    },
                    validate: (value) {
                      return controller.validatePassword(value!.toString());
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.3),
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const InputFieldLabel("Remember Me"),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => const ForgetPassword()),
                      child: Text(
                        "Forget Password?",
                        style:
                            AppStyles.input_label.copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      footer: [
        MainButton(
          isLoding: controller.isLoding.value,
          title: "Sign in",
          onTap: () {
            //Get.offAll(() => const Authenticate());
            if (controller.loginFormKey.currentState!.validate()) {
              controller.signIn(
                email: controller.emailController.text,
                password: controller.passwordController.text,
              );
              token = CacheHelper.getData('token');
              std_id = CacheHelper.getData('std_id');
            }
          },
        ),
      ],
    );
  }
}
