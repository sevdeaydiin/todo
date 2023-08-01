import 'package:flutter/material.dart';
import 'package:goole_sign_in/components/rounded_button.dart';
import 'package:goole_sign_in/components/rounded_password_field.dart';
import 'package:goole_sign_in/screens/login/components/background.dart';

import '../../../components/rounded_input_field.dart';

class Body extends StatelessWidget {  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        //Text('Giriş Yap',style: TextStyle(fontWeight: FontWeight.bold),),
        //SvgPicture.asset('assets/login.svg',height: size.height * 0.35,),
        Image.asset('assets/pngwing.com.png',height: size.height*0.4,width: size.width*0.8),
        //SizedBox(height: size.height * 0.04),
        RoundedInputField(
            hintText: 'Kullanıcı Adı:',
            onChanged: (value){
            },
        ),
        SizedBox(height: size.height * 0.02),
        RoundedPasswordField(
          onChanged: (value){},
        ),
        SizedBox(height: size.height * 0.03),
        RoundedButton(text: 'Giriş Yap', press: (){
        },),
      ]),
    );
  }
}
