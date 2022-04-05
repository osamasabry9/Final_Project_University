import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/view/widgets/main_button.dart';

import '../../../controllers/face_finger_controller.dart';

class Authenticate extends GetView<FaceAndFingerController> {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Local Authentication',
      showBack: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Obx(
                    () => controller.hasFingerPrintLock.value
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Finger Print Authentication',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Obx(
                  () => controller.hasFaceLock.value
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'Face Authentication',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
      footer: [
        MainButton(
          title: 'Authenticate',
          onTap: () => controller.authenticateUser(),
        )
      ],
    );
  }
}
