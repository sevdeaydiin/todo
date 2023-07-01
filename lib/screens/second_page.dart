
import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../theme.dart';
import '../widgets/todo_item.dart';


class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final String hintText = 'Ara';
  final String text='Tümü';
  final String hintText2 = 'Yeni bir yapılacak iş öğesi ekle';
  final String add = '+';

  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo=[];
  
  @override
  void initState() {
    _foundToDo=todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return
    // Scaffold(
    //   appBar: AppBar(
    //     actions: [
    //       IconButton(onPressed: (){}, icon: const Icon(Icons.notifications),),
    //       IconButton(onPressed: (){
    //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Account()));
    //       }, icon: const Icon(Icons.settings),),
    //     ]),
    //   body:
      
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                searchContainer(context),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50,bottom: 20),
                        child: Text(text,
                        style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w500),
                        ),
                      ),

                      for(ToDo todo in _foundToDo)
                         TodoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                         ),
           
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration:  BoxDecoration(
                    color: isDark(context) ? Colors.black : Colors.white,
                  boxShadow: const [ BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0,0.0),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                  ),],
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: hintText2,
                        border: InputBorder.none,
                    ),
                  ),
                ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20,right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);

                    },
                    style: ElevatedButton.styleFrom(elevation: 10,minimumSize: const Size(60,50)),
                    child: Text(add, style: const TextStyle(fontSize: 30),)
                    ),
                )
              ],
            ),
            ),
        ],
      );
   // );
  }

  void _handleToDoChange(ToDo todo){
  setState((){
todo.isDone = !todo.isDone;
  });
}

void _deleteToDoItem(String id){
  setState(() {
    todoList.removeWhere((item) => item.id==id);
  });
}

void _addToDoItem(String toDo){
  setState(() {
      todoList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: toDo));
  });
  _todoController.clear();
}

void _runFilter(String enteredKeyword){
List<ToDo> result = [];
if(enteredKeyword.isEmpty){
  result=todoList;
} else{
  result = todoList
    .where((item) => item.todoText!
    .toLowerCase()
    .contains(enteredKeyword.toLowerCase()))
    .toList();
}
setState(() {
  _foundToDo = result;
});
}

  Widget searchContainer(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
      color: isDark(context) ? Colors.black : Colors.white,
      borderRadius: BorderRadius.circular(20),),
      child: TextField(
        onChanged: ((value) => _runFilter(value)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon:  const Icon(Icons.search,size: 20,),
          prefixIconConstraints: const BoxConstraints(maxHeight: 20,minWidth: 25),
          border: InputBorder.none,
          hintText: hintText,
          //hintStyle:  TextStyle(color: isDark(context) ? darkBackgroundColor : textColor),
        ),),
    );
  }
  
}
