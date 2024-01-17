import 'package:app_book/manage/stores/user_store.dart';
import 'package:flutter/material.dart';

class DefaultInforPage extends StatelessWidget {
  const DefaultInforPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Infor User"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text("User Name: ${UserStore.to.userInfo.userName}"),
          ],
        ),
      ),
    );
  }
}
