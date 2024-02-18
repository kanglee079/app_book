import 'package:app_book/manage/controllers/register_controller.dart'; // Giả sử bạn đã tạo RegisterController
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/button_custom.dart';
import '../../widgets/text_form_custom.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade200],
            ),
          ),
          child: Column(
            children: [
              const Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Kang Book",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Theme.of(context).canvasColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Account",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 25),
                          Form(
                            key: controller.keyRegisterForm,
                            child: Column(
                              children: [
                                TextFormCustom(
                                  controller: controller.userNameController,
                                  hintText: 'Your Name',
                                  errorCheck: 'name',
                                ),
                                const SizedBox(height: 20),
                                TextFormCustom(
                                  controller: controller.emailController,
                                  hintText: 'Your Email',
                                  iconPrefix: Icons.email,
                                  errorCheck: 'email',
                                ),
                                const SizedBox(height: 20),
                                TextFormCustom(
                                  controller: controller.passwordController,
                                  hintText: 'Your Password',
                                  iconPrefix: Icons.lock,
                                  isPassword: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Obx(
                            () => ButtonCustom(
                              onloading: controller.loading,
                              onTap: controller.register,
                              backgroundColor: Theme.of(context).cardColor,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              textButton: 'REGISTER',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => ButtonCustom(
                              onloading: controller.loading,
                              onTap: controller.transToLoginPage,
                              backgroundColor: Theme.of(context).cardColor,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              textButton: 'Back to Login',
                            ),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
