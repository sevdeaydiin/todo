import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goole_sign_in/screens/account_page.dart';
import 'package:goole_sign_in/screens/second_page.dart';

import '../constants.dart';
import '../login_controller.dart';

class LoginPage extends StatelessWidget {

final controller = Get.put(LoginController());

  final String text='Görevlerinizi organize edin ve zamanınızı verimli kullanın!';
  final String text2='Google ile devam et';

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      body: Center(
        child: Obx ((){
          if(controller.googleAccount.value == null){
            return loginButton(context);
          } else{
            return buildSecond(context);
          }
        })
        ),
        
    );
  }

  Widget buildSecond(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications),),
          IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Account()));
          }, icon: const Icon(Icons.settings),),
        ]),
        body: const SecondPage(),
    );
  }
  

  Padding loginButton(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 150),
      child: Column(
        children: [
          Image.asset('assets/pngwing.com.png',height: 250,width: 250,),
            const SizedBox(height: 30),
            Text(text, style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.center,),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () async{
                controller.login();
            },
            style: ElevatedButton.styleFrom(backgroundColor: lightBackgroundColor,maximumSize: const Size(230,50),elevation: 5),
            child: Row(
              children: [
                Container(
                 // margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: Image.asset('assets/google.png',height: 20,width: 20,),
                ),
                Text(text2,style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
                ),
              ],
            ),
            ),
        ],
      ),
    );
  }

  // FloatingActionButton buildLoginButton() {
  //   return FloatingActionButton.extended(onPressed: (){
  //     controller.login();
  //       //GoogleSignIn().signIn();
  //     }, label: Text('Sign in with Google'));
  // }

/*   Column buildProfileView() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: Image.network(controller.googleAccount.value?.photoUrl ?? '').image,
            radius: 100,
          ),
          Text(
            controller.googleAccount.value?.displayName ?? '',
            style: Get.textTheme.headline3,
          ),
          Text(controller.googleAccount.value?.email ?? '',
            style: Get.textTheme.bodyText1,
          ),
          ActionChip(
            avatar: const Icon(Icons.logout_outlined),
            label: Text('Logout'),
            onPressed: (){
              controller.logout();

            },)
          
        ],
      );
  } */
}