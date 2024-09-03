import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/auth/auth_page.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:todo_app/widget/stream_note.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

bool show = true;

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 89, 58, 113),
        title: const Text('To-Do List '),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Auth_Page(),
              ));
            },
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddTodoPage(),
            ));
          },
          child: const Icon(Icons.add, size: 30),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: Column(
            children: [
              Stream_note(false),
              Text(
                'isDone',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold),
              ),
              Stream_note(true),
            ],
          ),
        ),
      ),
    );
  }
}
