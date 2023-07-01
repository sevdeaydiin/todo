class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone=false,
  });
  

  static List<ToDo> todoList(){
    return [
        // ToDo(id: '1', todoText: 'Morning',isDone: true),
        // ToDo(id: '2', todoText: 'Selam'),
        // ToDo(id: '3', todoText: 'todo',isDone: true),
        // ToDo(id: '4', todoText: 'Toplantı'),
        // ToDo(id: '5', todoText: 'Mailleri kontrol et'),
    ];
  }

}