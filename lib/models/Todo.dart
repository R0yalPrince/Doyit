class Todo {
  String? id;
  String? todotext;
  bool isdone;

  Todo({required this.id, required this.todotext, this.isdone = false});

  static List<Todo> todolist() {
    return [];
  }
}
