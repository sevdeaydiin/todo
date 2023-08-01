import 'package:flutter/material.dart';
import 'package:goole_sign_in/screens/second_page.dart';

import '../theme.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final String text='Görevlerinizi organize edin ve zamanınızı verimli kullanın!';
  TextEditingController userNameController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  String hintPassword='Parola:';
  String hintUserName='Kullanıcı Adı:';
  String loginText='Giriş Yap';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/purple.png'),
              fit: BoxFit.cover)
            ),
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
             child: Column(
               children: [
                 Image.asset('assets/pngwing.com.png',height: 250,width: 250,),
                 Text(text,style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),textAlign: TextAlign.center, ),
                 const SizedBox(height: 50),
                 loginTextField(userNameController,hintUserName),
                 const SizedBox(height: 15),
                 loginTextField(passwordController, hintPassword),
                 const SizedBox(height: 30),
                 loginButton(),
             ]),),
          ),
        ],
      ),
    );
  }
  
  loginTextField(TextEditingController controller,String hintText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
      width: MediaQuery.of(context).size.width/1.5,
            decoration: BoxDecoration(
            color: isDark(context) ? Colors.black : Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
                spreadRadius: 0.0,
              )
           ],
      borderRadius: BorderRadius.circular(10),),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
  
  loginButton() {
    return Container(
      width: MediaQuery.of(context).size.width/1.5,
      //color: isDark(context) ? Colors.black : Colors.white,
      decoration: BoxDecoration(
        //color: isDark(context) ? Colors.black : Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
                spreadRadius: 0.0,
              )
           ],
      borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SecondPage()));
        },
        child: Text(loginText),
      ),
    );
  }
}

/* class LoginPage extends StatelessWidget {

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
} */