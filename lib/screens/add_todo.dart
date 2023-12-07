import 'package:api_data_from_swagger/service/todo_services.dart';
import 'package:api_data_from_swagger/utils/snacksbar_helper.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleCntrl = TextEditingController();
  TextEditingController descriptionCntrl = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleCntrl.text = title;
      descriptionCntrl.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField("Title"),
            const SizedBox(height: 16),
            _buildDescriptionField("Description"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Text(isEdit ? 'Update' : 'Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextFormField(
      controller: titleCntrl,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDescriptionField(String label) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: descriptionCntrl,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    final id = todo['_id'];
    final title = titleCntrl.text;
    final description = descriptionCntrl.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    final isSuccess = await TodoServices.updateData(id, body);
    if (isSuccess) {
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: 'Update Success');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, 'todolist/');
    } else {
      // ignore: use_build_context_synchronously
      showFailedMessage(context, message: 'Update Failed');
    }
  }

  Future<void> submitData() async {
    final title = titleCntrl.text;
    final description = descriptionCntrl.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final isSuccess = await TodoServices.addTodo(body);

    if (isSuccess) {
      titleCntrl.text = '';
      descriptionCntrl.text = '';
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: 'Creation Success');

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, 'todolist/');
    } else {
      // ignore: use_build_context_synchronously
      showFailedMessage(context, message: 'Creation Failed');
    }
  }
}
