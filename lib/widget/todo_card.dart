import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;

  const TodoCard(
      {super.key,
      required this.deleteById,
      required this.navigateEdit,
      required this.item,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final id = item['_id']as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['title']),
        subtitle: Text(item['description']),
        trailing: PopupMenuButton(onSelected: (value) {
          if (value == 'edit') {
            navigateEdit(item);
          } else if (value == 'delete') {
            deleteById(id);
          }
        }, itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Delete',
                ))
          ];
        }),
      ),
    );
  }
}
