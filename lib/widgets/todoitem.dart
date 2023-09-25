import '../models/Todo.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Todoitem extends StatelessWidget {
  final Todo todo;
  final onchanged;
  final ondelete;

  const Todoitem(
      {required this.todo, required this.onchanged, required this.ondelete});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            onchanged(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: Icon(
            todo.isdone ? Icons.check_box : Icons.check_box_outline_blank,
            color: c2,
          ),
          title: Text(
            todo.todotext!,
            style: TextStyle(
              fontSize: 16,
              color: c3,
              decoration: todo.isdone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: c1, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
                onPressed: () {
                  ondelete(todo.id);
                },
                icon: Icon(
                  Icons.delete,
                  size: 18,
                  color: Colors.white,
                )),
          ),
        ));
  }
}
