import 'package:flutter/material.dart';
import 'package:goole_sign_in/screens/second_page.dart';
import 'package:goole_sign_in/theme.dart';

import '../model/todo.dart';

class TodoAdd extends StatefulWidget {
   TodoAdd({super.key});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  String personHint='Görev atanacak kişi:';
  String dueDateHint='Teslim tarihi:';
  String todoHint='Yeni bir yapılacak iş öğesi ekleyin';
  String add='Ekle';
  final String _selectedDateTime = 'Tarih ve saat seçiniz';
  String time="";
  TextEditingController todoText = TextEditingController();
  TextEditingController person = TextEditingController();
  SecondPageState secondPageState = SecondPageState();
  List<String> missionPerson = ['Kullanıcı1','Kullanıcı2', 'Kullanıcı3','Kullanıcı4'];
  late String selectedValue=missionPerson[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoAdd'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 80),
          child: Column(
            children: [
              AddContainer(todoText: todoText, todoHint: todoHint),
              dropDown(),
              timePicker(),
              const SizedBox(height: 20),
              addButton(context)
            ]),),
      ),
    );
  }

  Container addButton(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width/1.5,
            decoration: BoxDecoration(
            //color: isDark(context) ? Colors.black : Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
                spreadRadius: 0.0,
              )
           ],
      borderRadius: BorderRadius.circular(10),),
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                    final newToDo = ToDo(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      todoText: todoText.text,
                      todoState: 'Başlandı',
                      person: selectedValue.toString(),
                      dueDate: time,
                      );
                    setState(() {
                        secondPageState.todoList.add(newToDo);
                    });
                    secondPageState.todoCollection.add(newToDo.toMap());
                });
                 todoText.clear();
                 person.clear();
                 Navigator.pop(context);
            }, child: Text(add,style: const TextStyle(fontWeight: FontWeight.w700),)),
          );
  }

  Future<DateTime?> myShowDatePicker(BuildContext context, DateTime tarih) {
    return showDatePicker(context: context,
              initialDate: tarih,
              firstDate: DateTime(2022),
              lastDate: DateTime(2050),
              //locale: const Locale('tr', 'TR'),
              );
  }

  Widget dropDown(){
      return Container(
      width: MediaQuery.of(context).size.width/1.3,
      margin: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      decoration: BoxDecoration(
        color: isDark(context) ? Colors.black : Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      
      child: DropdownButton<String>(
          value: selectedValue,
          items: missionPerson.map((String value){
            return DropdownMenuItem(
              value: value,
              child: Text(value));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue=value.toString();
            });
          },
      ),
    );
  }

  Widget timePicker(){
    return Container(
      margin: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      decoration: BoxDecoration(
        color: isDark(context) ? Colors.black : Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onTap: (){
                DateTime tarih=DateTime.now();
                myShowDatePicker(context, tarih).then((value) {
                time="${value!.day}-${value.month}-${value.year}";
                print('zaman: $time');
                });
              },
        controller: TextEditingController(text: time),
        decoration: InputDecoration(
          hintText: _selectedDateTime,
          border: InputBorder.none,
        ),
      ),
    );
  }
  
} 

class AddContainer extends StatelessWidget {
  const AddContainer({
    super.key,
    required this.todoText,
    required this.todoHint,
  });

  final TextEditingController todoText;
  final String todoHint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      decoration: BoxDecoration(
        color: isDark(context) ? Colors.black : Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: todoText,
        decoration: InputDecoration(
          hintText: todoHint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}