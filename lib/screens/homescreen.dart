import 'package:doyit/models/Todo.dart';
import 'package:doyit/widgets/todoitem.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final todolist = Todo.todolist();
  List<Todo> _foundtodo = [];
  final _todocontroller = TextEditingController();

  @override
  void initState() {
    _foundtodo = todolist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c5,
      appBar: _appBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                search(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "Do It",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todoo in _foundtodo.reversed)
                        Todoitem(
                          todo: todoo,
                          onchanged: _tochange,
                          ondelete: _delete,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _todocontroller,
                    decoration: InputDecoration(
                      hintText: "Add a new todo item",
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _add(_todocontroller.text);
                    },
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c2,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _tochange(Todo todo) {
    setState(() {
      todo.isdone = !todo.isdone;
    });
  }

  void _delete(String id) {
    setState(() {
      todolist.removeWhere((element) => element.id == id);
    });
  }

  void _add(String todo) {
    setState(() {
      todolist.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todotext: todo));
    });
    _todocontroller.clear();
  }

  void _runfilter(String enteredkeyword) {
    List<Todo> results = [];
    if (enteredkeyword.isEmpty) {
      results = todolist;
    } else {
      results = todolist
          .where((element) => element.todotext!
              .toLowerCase()
              .contains(enteredkeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundtodo = results;
    });
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: c5,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: Colors.black,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset('assets/logo.png'),
          ),
        ),
      ]),
    );
  }

  Container search() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: c3,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: "Search ",
        ),
      ),
    );
  }
}
