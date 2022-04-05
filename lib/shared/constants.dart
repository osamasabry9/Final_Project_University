import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/models/user_model.dart';

// void signOut (context) {
//   CacheHelper.removeData('token').then((value){
//     navigateAndKill(context, LoginScreen());
//     ShopCubit.get(context).currentIndex = 0;
//   });
// }

// bool isEdit = false;
// String editText = 'Edit';
// void editPressed({
//   required context,
//   required email,
//   required name,
//   required phone,
// })
// {
//   isEdit =! isEdit;
//   if(isEdit) {
//     editText = 'Save';
//     ShopCubit.get(context).emit(EditPressedState());
//   } else {
//     editText = 'Edit';
//     ShopCubit.get(context).updateProfileData(
//         email: email,
//         name: name,
//         phone: phone
//     );
//   }

// }

void showSnackBar({String? title, String? message, Color? backgroundColor}) {
  Get.snackbar(title!, message!,
      colorText: Colors.white,
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.BOTTOM);
}

String? token = '';
bool? showOnBoard = true;
//UserModelNew? userModel;
String? std_id = '';
