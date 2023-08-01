import 'package:flutter/material.dart';
import 'package:goole_sign_in/components/text_field_container.dart';


class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    super.key,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Parola:',
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(Icons.lock,color: Colors.white,),
          suffixIcon: Icon(Icons.visibility,color: Colors.white,),
          border: InputBorder.none,
        ),
      ));
  }
}
