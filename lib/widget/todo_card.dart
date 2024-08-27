import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;

  const TodoCard({
    super.key,
    required this.index,
    required this.item,
    required this.navigateEdit,
    required this.deleteById,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}
  bool isDone = false;

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    final id = widget.item['_id'];
    final dateTime = widget.item['dateTime'];
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${widget.index + 1}')),
        title: Text(widget.item['title']),
        subtitle: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item['description']),
                  Timefield(),
              const SizedBox(height: 5),
              // Displaying date and time
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                value: isDone,
                onChanged: (value) {
                  setState(() {
                    isDone = !isDone;
                  });
                },
              ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: PopupMenuButton(
                onSelected: (value) {
                  if (value == 'edit') {
                    widget.navigateEdit(widget.item);
                  } else if (value == 'delete') {
                    widget.deleteById(id);
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ];
                },
              ),
            ),
              
          ],
        ),
      ),
    );
  }

  Widget Timefield() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 60,
        height: 28,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 89, 58, 113),
            borderRadius: BorderRadius.circular(18)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Text(
                'Time',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
