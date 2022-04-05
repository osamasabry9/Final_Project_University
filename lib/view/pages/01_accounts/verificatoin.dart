import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/view/pages/01_accounts/chpass.dart';

import '../../../layouts/main_layout.dart';

class Verificatoin extends StatefulWidget {
  const Verificatoin({Key? key}) : super(key: key);

  @override
  State<Verificatoin> createState() => _VerificatoinState();
}

class _VerificatoinState extends State<Verificatoin> {
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  String _code = '';

  // ignore: unused_field
  late Timer _timer;
  int _start = 60;
  int _currentIndex = 0;

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  verify() {
    setState(() {
      _isLoading = true;
    });

    const oneSec = Duration(milliseconds: 2000);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
    });
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;

        if (_currentIndex == 3) _currentIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBack: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: _currentIndex == 0 ? 1 : 0,
                      duration: const Duration(
                        seconds: 1,
                      ),
                      curve: Curves.linear,
                      child: Image.network(
                        'https://ouch-cdn2.icons8.com/eza3-Rq5rqbcGs4EkHTolm43ZXQPGH_R4GugNLGJzuo/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjk3/L2YzMDAzMWUzLTcz/MjYtNDg0ZS05MzA3/LTNkYmQ0ZGQ0ODhj/MS5zdmc.png',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: _currentIndex == 1 ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear,
                      child: Image.network(
                        'https://ouch-cdn2.icons8.com/pi1hTsTcrgVklEBNOJe2TLKO2LhU6OlMoub6FCRCQ5M/rs:fit:784:666/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMzAv/MzA3NzBlMGUtZTgx/YS00MTZkLWI0ZTYt/NDU1MWEzNjk4MTlh/LnN2Zw.png',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: _currentIndex == 2 ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear,
                      child: Image.network(
                        'https://ouch-cdn2.icons8.com/ElwUPINwMmnzk4s2_9O31AWJhH-eRHnP9z8rHUSS5JQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNzkw/Lzg2NDVlNDllLTcx/ZDItNDM1NC04YjM5/LWI0MjZkZWI4M2Zk/MS5zdmc.png',
                      ),
                    ),
                  )
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    "Verification",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 20,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Please enter the 4 digit code sent to ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          height: 1.5),
                    ),
                    const Text(
                      "+93 706-399-999",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: AppColors.MAIN, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // Verification Code Input
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 500),
                child: VerificationCode(
                  length: 4,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  underlineColor: Colors.black,
                  keyboardType: TextInputType.number,
                  underlineUnfocusedColor: Colors.black,
                  onCompleted: (value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (value) {},
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't resive the OTP?",
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    ),
                    TextButton(
                        onPressed: () {
                          if (_isResendAgain) return;
                          resend();
                        },
                        child: Text(
                          _isResendAgain
                              ? "Try again in " + _start.toString()
                              : "Resend",
                          style: const TextStyle(color: AppColors.MAIN),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      footer: [
        FadeInDown(
          delay: const Duration(milliseconds: 800),
          duration: const Duration(milliseconds: 500),
          child: MaterialButton(
            elevation: 0,
            onPressed: _code.length < 4
                ? () => { Get.to(()=> const CreatePassword())}
                : () {
                    verify();
                  },
            color: AppColors.MAIN,
            minWidth: MediaQuery.of(context).size.width,
            height: 50,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 3,
                      color: Colors.black,
                    ),
                  )
                : _isVerified
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 30,
                      )
                    : const Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ),
          ),
        ),
      ],
    );
  }
}
