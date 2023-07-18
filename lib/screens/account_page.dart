import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../login_controller.dart';
import '../theme.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 50),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: Image.network(controller.googleAccount.value?.photoUrl ?? '').image,
                radius: 70,
              ),
              const SizedBox(height: 50),
              textContainer(context, '${controller.googleAccount.value?.displayName}', Get.textTheme.headlineMedium,50),
              const SizedBox(height: 13),
              textContainer(context, '${controller.googleAccount.value?.email}', Get.textTheme.bodyMedium,30),
              const SizedBox(height: 40),
              /* ActionChip(
                avatar: const Icon(Icons.logout_outlined),
                label: const Text('Logout'),
                onPressed: ()async{
                  Navigator.pop(context);
                  await controller.logout();
                },) */
            ElevatedButton(
              onPressed: ()async{
                await controller.logout();
                  Navigator.pop(context);
                  
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white,maximumSize: const Size(130,50),elevation: 5),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: const Icon(Icons.logout_outlined, color: purple),
                ),
                const Text('Çıkış',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
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

  Container textContainer(BuildContext context, String? text, TextStyle? style, double height) {
    return Container(
              height: height,
              width: 300,
              decoration:  BoxDecoration(
              color: isDark(context) ? grey : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
              ),
              child: Center(
                child: Text(
                  text ?? ' ',
                  style: style,
                ),
              ),
            );
  }
}