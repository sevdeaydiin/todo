import 'package:flutter/material.dart';
import 'package:goole_sign_in/screens/second_page.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;

  const RoundedButton({Key? key, required this.text, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondPage()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 40),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}