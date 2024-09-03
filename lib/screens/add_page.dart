import 'package:flutter/material.dart';
import 'package:todo_app/data/firestore.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final title = TextEditingController();
  final subtitle = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  int indexx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 89, 58, 113),
        title: const Text('Add To-Do '),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Add your task details below',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            title_widgets(),
            const SizedBox(height: 20),
            subtite_wedgite(),
            const SizedBox(height: 20),
            button()
          ],
        ),
      ),
    );
  }

Widget button() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(170, 48),
          backgroundColor: const Color.fromARGB(255, 89, 58, 113),
        ),
        onPressed: () {
          if (title.text.isEmpty || subtitle.text.isEmpty) {
            // Show a snackbar with an error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Title and subtitle cannot be empty.'),
                backgroundColor: Colors.red,
              ),
            );

            // Move focus to the empty field
            if (title.text.isEmpty) {
              FocusScope.of(context).requestFocus(_focusNode1);
            } else if (subtitle.text.isEmpty) {
              FocusScope.of(context).requestFocus(_focusNode2);
            }
          } else {
            // Proceed with adding the task
            Firestore_Datasource().AddTodo(subtitle.text, title.text, indexx);
            Navigator.pop(context);
          }
        },
        child: const Text('Add task'),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(170, 48),
          backgroundColor: const Color.fromARGB(255, 89, 58, 113),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
    ],
  );
}

  Widget title_widgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'title',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }

  Padding subtite_wedgite() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3,
          controller: subtitle,
          focusNode: _focusNode2,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'subtitle',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
