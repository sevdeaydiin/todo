
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:goole_sign_in/state_controller.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../model/todo.dart';
import '../theme.dart';

// ignore: must_be_immutable
class TodoItem extends StatefulWidget {
  ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  final uploadStorage;
   TodoItem({super.key,required this.todo,required this.onToDoChanged, required this.onDeleteItem,required this.uploadStorage});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final _category = Get.put(StateController());
  var textField=TextEditingController();

  var time;
  @override
  void initState() {
    time=DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: isDark(context) ? Colors.black : Colors.white,),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: 'Sil',
                  onPressed: (context){
                    showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Silmek istediğinize emin misiniz?'),
                          actions: [
                            TextButton(onPressed: (){
                              widget.onDeleteItem(widget.todo.id);
                              Navigator.pop(context);
                            }, child: Text('Evet',style: TextStyle(color: isDark(context) ? Colors.white : Colors.black))),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('Hayır',style: TextStyle(color: isDark(context) ? Colors.white : Colors.black))),
                          ],
                        );
                    });
                  }
                  ),
              ],
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                tileColor: isDark(context) ? Colors.black : Colors.white,
                leading: popupMenuButton(context),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Görev: ${widget.todo.todoText}",
                      style: TextStyle(fontSize: 18,color:  isDark(context) ? Colors.white : Colors.black,
                      decoration: widget.todo.isDone() ? TextDecoration.lineThrough : null),),
                      Text(
                      "Kişi: ${widget.todo.person}",
                      style: const TextStyle(fontSize: 15,color: Colors.grey,
                      ),),
                      Text(
                      "Teslim Tarihi: ${widget.todo.dueDate}",
                      style: const TextStyle(fontSize: 15,color: Colors.grey,
                      ),
                      ),
                  ],
                ),
                  trailing: uploadButton(context),
            ),
          ),
        ),
      ],
    );
  }

  Container uploadButton(BuildContext context) {
    return Container(
                  height: 45,
                  width: 40,
                  decoration: BoxDecoration(
                    color: isDark(context) ? darkBackgroundColor : lightBackgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                  icon: const Icon(Icons.document_scanner),
                  color: purple,
                  iconSize: 18,
                  onPressed: () {
                  widget.uploadStorage(context);
                  },
                  ),
                );
  }

  PopupMenuButton<String> popupMenuButton(BuildContext context) {
    return PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(value: _category.category[1],child: Text(_category.category[1]),),
                  PopupMenuItem(value: _category.category[2],child: Text(_category.category[2]),),
                  PopupMenuItem(value: _category.category[3],child: Text(_category.category[3]),),
                ],
                onSelected: (value){
                  widget.todo.todoState=value;
                  widget.onToDoChanged(widget.todo.todoState,widget.todo.id);
                  
                  if(widget.todo.todoState=='Bitti'){
                    String date=widget.todo.dueDate;
                    //String tm = '${date.substring(0,2)}T${date.substring(3,4)}T${date.substring(5,9)}';
                    var dt1=DateFormat('dd/MM/yyyy').parse(date);
                    int result = time.compareTo(dt1); 
                    if(result>0){
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:  Radius.circular(20.0))),
                        builder: (context) => Padding(
                        padding: EdgeInsets.only(
                          top: 30,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              const Text('Geç teslim edilme nedeni',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                              const SizedBox(height: 10),
                              myTextField(),
                              ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                              }, 
                              child: const Text('Gönder'))
                            ]
                          ),
                ),
                );  
                  }
                  }
                }
              );
  }
  
  myTextField() {
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
        borderRadius: BorderRadius.circular(10),),
        child:TextField(
        
        controller: textField,decoration: const InputDecoration(
          //hintText: _selectedDateTime,
          border: InputBorder.none,
        ),
        
        
      ),
    );
  }
  

    
      
}