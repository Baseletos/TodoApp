import 'package:flutter/material.dart';
import 'package:todo_app/data/firestore.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/screens/edit_page.dart';

class Task_Widget extends StatefulWidget {
  final Todo _todo;
  final int index;
  const Task_Widget(this._todo, {super.key, required this.index});

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}

class _Task_WidgetState extends State<Task_Widget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._todo.isDon;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: const Color.fromARGB(
                  255, 89, 58, 113), // Set a background color
              child: Text(
                '${widget.index + 1}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Task title
                      Expanded(
                        child: Text(
                          widget._todo.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Checkbox(
                        value: isDone,
                        onChanged: (value) {
                          setState(() {
                            isDone = !isDone;
                          });
                          Firestore_Datasource()
                              .isdone(widget._todo.id, isDone);
                        },
                      ),
                    ],
                  ),
                  Text(
                    widget._todo.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    widget._todo.time,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Edit_Screen(widget._todo),
                              ));
                            },
                            child: Container(
                              width: 90,
                              height: 28,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 89, 58, 113),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      'edit',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Are you sure you want to delete this task?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Firestore_Datasource()
                                          .delet_Todo(widget._todo.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
