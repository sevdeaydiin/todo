import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goole_sign_in/constants.dart';
import 'package:goole_sign_in/screens/todo_add.dart';
import 'package:goole_sign_in/state_controller.dart';
import 'package:goole_sign_in/storage_service_api.dart';

import '../model/todo.dart';
import '../theme.dart';
import '../widgets/todo_item.dart';
import 'account_page.dart';


class SecondPage extends StatefulWidget {
   const SecondPage({super.key});

  @override
  State<SecondPage> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  final String hintText = 'Ara';
  final String text='Tümü';
  final String hintText2 = 'Yeni bir yapılacak iş öğesi ekle';
  final String add = '+';
  final pageController = PageController();

  List<ToDo> todoList = [];
  List<ToDo> _foundToDo = [];
  var todoCollection = FirebaseFirestore.instance.collection('deneme-collection');
  
  @override
  void initState() {
    _fetchToDoList();
    getCategories();
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
  final category = Get.put(StateController());
  List<Widget> categoryWidgets=[];
  List<ToDo> todos=[];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications),),
          IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Account()));
          }, icon: const Icon(Icons.settings),),
        ]),
      body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  searchContainer(context),
                  listView(),
                ],
              ),
            ),
            addButton(context),
          ],
        ),
    );
   // );
  }

  Expanded listView() {
    return Expanded(
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
                          onToDoChanged: handleToDoChange,
                          onDeleteItem: deleteToDoItem,
                          uploadStorage: uploadStorage,
                          ), 
                    ],
                  ),
                );
  }

  Padding addButton(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(right: 30,bottom: 30),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: purple,
                child: const Icon(Icons.add),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoAdd()));
                },
              )
              ),
          );
  }

  void getCategories(){
    getCategoryWidgets();
  }

List<Widget> getCategoryWidgets(){
  for(int i=0;i<category.category.length;i++){
    categoryWidgets.add(getCategoryWidget(category.category[i]));
  }
  return categoryWidgets;
}

  Widget getCategoryWidget(String category) {
    return TextButton(
      child: Text(category),
      onPressed: (){
        setState(() {
          
        });
      },
      
    );
  }

  void uploadStorage(BuildContext context)async {
    final Storage storage = Storage();
    
    final results=await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if(results==null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected'))
      );
    }

    final path = results?.files.single.path;
    final fileName=results?.files.single.name;

    storage.uploadFile(path!, fileName!).then((value) => print('done'));

  }


void handleToDoChange(String state, String id)async{
  
  QuerySnapshot querySnapshot = await todoCollection.where('id' , isEqualTo: id).get();

  try {
    setState(() {
      for(QueryDocumentSnapshot documentSnapshot in querySnapshot.docs){
      todoCollection.doc(documentSnapshot.id).update({'todoState':state});
    }
    });
  } catch (e) {
    print("Error updating todoState in Firestore: $e");
    
  }
}

void deleteToDoItem(String id)async{
  
  setState(() {
    todoList.removeWhere((item) => item.id==id);
  });
  QuerySnapshot querySnapshot = await todoCollection.where('id' , isEqualTo: id).get();
  for(QueryDocumentSnapshot documentSnapshot in querySnapshot.docs){
    todoCollection.doc(documentSnapshot.id).delete();
  }
}

void addToDoItem(String todoText, String person, String dueDate){
  final newToDo = ToDo(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    todoText: todoText,
    todoState: 'Başlandı',
    person: person,
    dueDate: dueDate,
    );
  setState(() {
      todoList.add(newToDo);
  });
  todoCollection.add(newToDo.toMap());
  //_todoController.clear();
}

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

/* class ToDoListView extends StatelessWidget{
  final int selected;
  final Function callback;
  final PageController pageController;
  final ToDo todo;
  SecondPageState secondPageState = SecondPageState();
   ToDoListView(this.selected,this.callback,this.pageController,this.todo);
  
  @override
  Widget build(BuildContext context) {
    final category = todo.todoState;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
        controller: pageController,
        onPageChanged: (index)=> callback(index),
        children: [
          ListView.separated(
            itemBuilder: (context,index){
              TodoItem(
                todo: todo, 
                onToDoChanged: secondPageState.handleToDoChange, 
                onDeleteItem: secondPageState.deleteToDoItem);
            }, 
            separatorBuilder: (_,index) => const SizedBox(height: 15), 
            itemCount: 4)
        ],
      ),
    );
  }

} */

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
