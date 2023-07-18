
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goole_sign_in/constants.dart';
import 'package:goole_sign_in/state_controller.dart';

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

  //final _state = Get.put(StateController());

  //final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> todoList = [];
  List<ToDo> _foundToDo=[];
  var todoCollection = FirebaseFirestore.instance.collection('deneme-collection');
  
  @override
  void initState() {
   // _foundToDo=todoList;
    _fetchToDoList();
    super.initState();
  }

  Future<void> _fetchToDoList() async {
    final snapshot = await todoCollection.get();
    final List<ToDo> todos = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ToDo.fromMap(data);
    }).toList();

    setState(() {
      todoList = todos;
      _foundToDo = todos;
    });
  }

  var selected = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                searchContainer(context),
                Expanded(
                  child: ListView(
                    children: [
                      TodoCategory(selected, (int index){
                        setState(() {
                          selected=index;
                        });
                      }),
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
                      //addUser(_todoController.text);
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

  void _handleToDoChange(ToDo todo, String id)async{

  setState((){
   
  });
  QuerySnapshot querySnapshot = await todoCollection.where('id' , isEqualTo: id).get();
  // for(QueryDocumentSnapshot documentSnapshot in querySnapshot.docs){
  //   todoCollection.doc(documentSnapshot.id).update({'isDone':todo.isDone});
  // }
}

void _deleteToDoItem(String id)async{
  setState(() {
    todoList.removeWhere((item) => item.id==id);
  });
  QuerySnapshot querySnapshot = await todoCollection.where('id' , isEqualTo: id).get();
  for(QueryDocumentSnapshot documentSnapshot in querySnapshot.docs){
    todoCollection.doc(documentSnapshot.id).delete();
  }
}

void _addToDoItem(String toDo){
  final newToDo = ToDo(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    todoText: toDo,
    todoState: 'Başlandı',
    );
  setState(() {
      todoList.add(newToDo);
  });
  todoCollection.add(newToDo.toMap());
  _todoController.clear();
}

    // Future<void> addUser(String todo) {
    //  // CollectionReference todoCollection2 = FirebaseFirestore.instance.collection('deneme-collection');
    //   // Call the user's CollectionReference to add a new user
    //   return todoCollection
    //       .add({
    //         'id': 'todo',
    //         'todoText': todo,
    //         'isDone': false,
    //       })
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }

void _runFilter(String enteredKeyword){
List<ToDo> result = [];
if(enteredKeyword.isEmpty){
  result=todoList;
} else{
  result = todoList
    .where((item) => item.todoText
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
          prefixIconColor: purple,
          border: InputBorder.none,
          hintText: hintText,
          //hintStyle:  TextStyle(color: isDark(context) ? darkBackgroundColor : textColor),
        ),),
    );
  }

  
}


class TodoCategory extends StatelessWidget{

  final int selected;
  final Function callback;

   TodoCategory(this.selected,this.callback);
   final _category = Get.put(StateController());

  @override
  Widget build(BuildContext context){
    return Container(
      height: 100,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          //padding: EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context,index) => GestureDetector(
            onTap: () => callback(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), 
              color: selected == index ? purple : Colors.white),
              child: Text(_category.category[index],style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
          ), 
          separatorBuilder: (_,index) => const SizedBox(width: 20), 
          itemCount: 4),
    );
  }
  
}
