import 'package:flutter/material.dart';

import '../../../apps/helper/showToast.dart';
import '../../../manage/services/auth_service.dart';
import '../../../widgets/button_custom.dart';
import '../../../widgets/text_form_custom.dart';

class PersonalChangePasswordPage extends StatefulWidget {
  const PersonalChangePasswordPage({super.key});

  @override
  State<PersonalChangePasswordPage> createState() =>
      _PersonalChangePasswordPageState();
}

class _PersonalChangePasswordPageState
    extends State<PersonalChangePasswordPage> {
  final TextEditingController currientPassword = TextEditingController();
  final TextEditingController newsPassword = TextEditingController();
  final TextEditingController againNewsPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Change Password",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password Current",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    TextFormCustom(
                      controller: currientPassword,
                      isPassword: true,
                      hintText: "Type your current password",
                      iconPrefix: Icons.password,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "New Password",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    TextFormCustom(
                      controller: newsPassword,
                      hintText: "Type your new password",
                      isPassword: true,
                      iconPrefix: Icons.password_outlined,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Type again new password",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    TextFormCustom(
                      controller: againNewsPassword,
                      isPassword: true,
                      hintText: "Type again new password",
                      iconPrefix: Icons.password_outlined,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: ButtonCustom(
            backgroundColor: Theme.of(context).cardColor,
            textButton: "Change",
            textStyle: Theme.of(context).textTheme.bodyMedium,
            onTap: () {
              try {
                if (newsPassword.text == againNewsPassword.text &&
                    newsPassword.text.isNotEmpty &&
                    againNewsPassword.text.isNotEmpty &&
                    currientPassword.text.isNotEmpty) {
                  AuthService().changePassword(newsPassword.text);
                  currientPassword.clear();
                  newsPassword.clear();
                  againNewsPassword.clear();
                } else if (currientPassword.text.isEmpty &&
                    newsPassword.text.isEmpty &&
                    againNewsPassword.text.isEmpty) {
                  showToastError("Chưa nhập đủ thông tin !");
                } else {
                  showToastError("Mật khẩu mới không trùng nhau !");
                }
              } catch (e) {
                showToastError('Đổi mật khẩu thất bại do $e');
              }
            },
          ),
        ),
      ),
    );
  }
}
