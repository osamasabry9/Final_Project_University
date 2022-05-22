import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/models/user_model.dart';
import 'package:quiz_app_api/resources/cache_helper.dart';
import 'package:quiz_app_api/resources/dio_helper.dart';
import 'package:quiz_app_api/resources/end_points.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/constants.dart';
import 'package:quiz_app_api/view/pages/02_home/home.dart';

class LoginController extends GetxController {
  RxBool isLoding = false.obs;

  //late final UserModel loginUserModel;

  late TextEditingController emailController, passwordController;
  var loginFormKey = GlobalKey<FormState>();
  static UserModelNew? userModel;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  signIn({
    required String email,
    required String password,
  }) {
    isLoding(true);
    DioHelper.postData(url: LOGIN, data: {
      'username': email,
      'password': password,
    }).then((value) {
      userModel = UserModelNew.fromJson(value.data);
      if (userModel!.status!) {
        showSnackBar(
            title: ' Login Success',
            message: " ${userModel!.message}",
            backgroundColor: AppColors.kGreenColor);
        CacheHelper.saveData(
                key: 'std_id', value: userModel!.data?.userDetails!.id)
            .then((value) => std_id = userModel!.data?.userDetails!.id);
        CacheHelper.saveData(key: 'token', value: userModel!.data?.token)
            .then((value) {
          token = userModel!.data?.token;
          Get.offAll(() => HomePage());
          emailController.clear();
          passwordController.clear();
        });
      } else {
        showSnackBar(
            title: ' Login ERROR',
            message: " ${userModel!.message}",
            backgroundColor: AppColors.kRedColor);
      }
      isLoding(false);
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      showSnackBar(
          title: ' Login ERROR',
          message: error.toString(),
          backgroundColor: AppColors.kRedColor);
    });
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email Address must be filled';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password must be filled';
    }
    return null;
  }

  Rx<IconData> suffix = Icons.visibility_outlined.obs;
  RxBool isPassword = true.obs;

  void changePasswordVisibility() {
    isPassword.value = !isPassword.value;
    suffix.value =
        isPassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
