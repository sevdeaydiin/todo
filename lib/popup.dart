import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goole_sign_in/state_controller.dart';

class Popup extends StatefulWidget {
   Popup({super.key});

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  final _category = Get.put(StateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 10),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Delete',
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 10),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
            onSelected: ( value){
              if(value=='Edit'){
                  print('yes');
              } else if(value=='Delete'){
                print('sil');
              } else{
                print('heşşp');
              }
            }
          ),
        ),
     );
  }

}