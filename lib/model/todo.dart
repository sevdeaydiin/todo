

class ToDo {
  final String id;
  final String todoText;
  final String person;
  final String dueDate;
  String todoState;


  ToDo({
    required this.id,
    required this.todoText,
    required this.todoState,
    required this.person,
    required this.dueDate,
    
  });
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todoText': todoText,
      'todoState': todoState,
      'person':person,
      'dueDate':dueDate,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    assert(map["todoText"]!=null);
    assert(map["dueDate"]!=null);
    return ToDo(
      id: map['id'],
      todoText: map['todoText'],
      todoState: map['todoState'],
      person: map['person'],
      dueDate: map['dueDate'],
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