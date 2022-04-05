// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/config/app_images.dart';
import 'package:quiz_app_api/view/widgets/hdr_widget.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final Widget? smoth;
  final List<Widget> footer;
  final String title;
  final Widget? skip;
  final bool showBack;
  final bool showSkip;
  final bool isFooter;
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  MainLayout({
    Key? key,
    required this.body,
    this.smoth,
    required this.footer,
    this.title = "",
    this.showBack = true,
    this.showSkip = false,
    this.isFooter = true,
    scaffoldKey,
    this.skip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: Stack(
          children: [
            /* < --------------- Background Image -----------> */
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: AppColors.MAIN),
              child: Image.asset(
                AppImages.BACKGROUND,
                //color: Colors.white,
                fit: BoxFit.fill,
              ),
            )
            /* < ---------------- onBoarding ----------------> */
            ,
            SafeArea(
                bottom: false,
                child: Container(
                  child: Column(
                    children: [
                      Header(
                        showBack: showBack,
                        showSkip: showSkip,
                        title: title,
                        skip: skip,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xfff4f5f7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            image: DecorationImage(
                                image: AssetImage(AppImages.BACKGROUND_LOGN),
                                opacity: 0.8,
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            children: [
                              /* < ---------------- OnBoarding ----------------> */
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: body),
                              ),
                              const SizedBox(
                                height: 5,
                              ),

                              /* < ---------------- Get Started Button ----------------> */

                              isFooter == true
                                  ? Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          )),
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      child: Column(children: footer),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
