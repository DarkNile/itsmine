import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:itsmine/auth/controllers/auth_controller.dart';
import 'package:itsmine/auth/view/forget_password_screen.dart';
import 'package:itsmine/auth/view/register_screen.dart';
import 'package:itsmine/constants/colors.dart';
import 'package:itsmine/home/view/home_screen.dart';
import 'package:itsmine/utils/app_util.dart';
import 'package:itsmine/widgets/custom_button.dart';
import 'package:itsmine/widgets/custom_card.dart';
import 'package:itsmine/widgets/custom_text.dart';
import 'package:itsmine/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 28,
          right: 28,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        left: AppUtil.rtlDirection(context) ? 80 : 0,
                        right: AppUtil.rtlDirection(context) ? 0 : 80,
                      ),
                      child: SvgPicture.asset('assets/icons/background.svg')),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'signIn'.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: AppUtil.rtlDirection(context)
                              ? SvgPicture.asset('assets/icons/left_arrow.svg')
                              : SvgPicture.asset(
                                  'assets/icons/right_arrow.svg'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              SvgPicture.asset('assets/icons/logo_icon.svg'),
              const SizedBox(
                height: 50,
              ),
              CustomText(
                text: 'emailAddress'.tr,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                controller: _emailController,
                hintText: 'emailAddress'.tr,
                textInputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.alternate_email),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomText(
                text: 'password'.tr,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: 'password'.tr,
                obscureText: _isPasswordHidden,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const ForgetPasswordScreen());
                },
                child: CustomText(
                  text: 'forgetPassword'.tr,
                  color: vermillion,
                  textDecoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Obx(() {
                if (_authController.isLoginLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(
                  radius: 4,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final user = await _authController.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                      if (user != null) {
                        Get.offAll(() => const HomePage());
                      }
                    }
                  },
                  title: 'signIn'.tr,
                );
              }),
              const SizedBox(
                height: 29,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.grey,
                    height: 1,
                    width: 99,
                  ),
                  CustomText(
                    text: 'loginThrough'.tr,
                    fontWeight: FontWeight.w400,
                    color: warmGrey,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 1,
                    width: 99,
                  ),
                ],
              ),
              const SizedBox(
                height: 29,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.ltr,
                  children: [
                    Expanded(
                      child: CustomCard(
                        onTap: () {},
                        icon: 'facebook_icon',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CustomCard(
                        onTap: () {},
                        icon: 'apple_icon',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CustomCard(
                        onTap: () {},
                        icon: 'google_icon',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const RegisterScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'dontHaveAccount'.tr,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500]!,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CustomText(
                      text: 'joinUs'.tr,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
