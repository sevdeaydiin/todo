
import 'package:flutter/material.dart';

import '../constants.dart';
import '../model/todo.dart';
import '../theme.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  
  const TodoItem({super.key,required this.todo,required this.onToDoChanged,required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: (){
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          tileColor: isDark(context) ? Colors.black : Colors.white,
          leading: todo.isDone ? const Icon(Icons.check_box,color: purple,) : const Icon(Icons.check_box_outline_blank,color: purple,),
          title: Text(
            todo.todoText!,
            style: TextStyle(fontSize: 16,color:  isDark(context) ? Colors.white : Colors.black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null),),
            trailing: Container(
              padding: const EdgeInsets.all(0),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: isDark(context) ? darkBackgroundColor : lightBackgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(icon: const Icon(Icons.delete),
              color: purple,
              iconSize: 18,
              onPressed: () {
               onDeleteItem(todo.id);
              },
              ),
            ),
      ),
    );
  }
}