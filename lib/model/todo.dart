class ToDo {
  final String id;
  final String todoText;
  final String todoState;

  ToDo({
    required this.id,
    required this.todoText,
    required this.todoState,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todoText': todoText,
      'todoState': todoState,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      todoText: map['todoText'],
      todoState: map['todoState'],
    );
  }

   isDone(){
    if(todoState=='Bitti'){
      return true;
    } else{
      return false;
    }
  }
}

// class ToDo{
//   String? id;
//   String? todoText;
//   bool isDone;

//   ToDo({
//     required this.id,
//     required this.todoText,
//     this.isDone=false,
//   });
  

//   static List<ToDo> todoList(){
//     return [
//         // ToDo(id: '1', todoText: 'Morning',isDone: true),
//         // ToDo(id: '2', todoText: 'Selam'),
//         // ToDo(id: '3', todoText: 'todo',isDone: true),
//         // ToDo(id: '4', todoText: 'Toplantı'),
//         // ToDo(id: '5', todoText: 'Mailleri kontrol et'),
//     ];
//   }

// }