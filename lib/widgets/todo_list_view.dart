 

/*  class TodoListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  ToDo todo;
  //final ToDo todo;
   TodoListView(this.selected,this.callback,this.pageController,this.todo);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
        controller: pageController,
        onPageChanged: (index)=>callback(index),
        children: 
      ),
    );
  }
}   */


/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goole_sign_in/state_controller.dart';

class TodoListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;

  TodoListView(this.selected, this.callback, this.pageController);

  @override
  Widget build(BuildContext context) {
    final category = Get.put(StateController());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
        controller: pageController,
        onPageChanged: (index) => callback(index),
        children: category.category.map((e) => buildListView(e)).toList(),
      ),
    );
  }

  Widget buildListView(String categoryText) {
    // Burada categoryText parametresini kullanarak sayfa içeriğini oluşturun.
    // Her bir sayfanın içeriği burada belirtilmelidir.
    // Örneğin, ToDo öğelerini bu kategorilere göre filtreleyip listeleyebilirsiniz.
    // ListView.builder gibi uygun bir widget kullanarak ToDo öğelerini gösterebilirsiniz.
    // Eğer ListView kullanacaksanız, itemBuilder ve separatorBuilder fonksiyonları da tanımlamanız gerekir.
    // Daha sonra bu içerikleri döndürerek her bir kategorinin bir sayfa olarak gösterilmesini sağlayabilirsiniz.
    return ListView.separated(
      itemBuilder: (context, index) {
        // Burada ToDo öğelerini filtreleyerek ve kategoriye göre göstererek liste oluşturabilirsiniz.
        // Örnek olarak:
        // final todos = filterTodosByCategory(categoryText);
        // return TodoItem(todo: todos[index], onToDoChanged: onToDoChanged, onDeleteItem: onDeleteItem);
      },
      separatorBuilder: (_, index) => SizedBox(height: 15),
      itemCount: 10, // ToDo öğesi sayısı yerine burada gerçek öğe sayısını kullanın.
    );
  }
} */


/* class TodoListView extends StatefulWidget {
  var todo;
   TodoListView({super.key,this.todo});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {

  SecondPageState secondPageState = SecondPageState();
  @override
  Widget build(BuildContext context) {
    return buildTodoList(context);
  }
  
  Widget buildTodoList(BuildContext context) {
    List<ToDo> _foundToDo=[];
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context,index){
          return TodoItem(
                    todo: widget.todo,
                    onToDoChanged: secondPageState.handleToDoChange,
                    onDeleteItem: secondPageState.deleteToDoItem,
                  );
        },
        itemCount: 4
        ),
    );
  }
} */