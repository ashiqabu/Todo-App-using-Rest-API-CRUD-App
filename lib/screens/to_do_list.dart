import 'package:api_data_from_swagger/screens/add_todo.dart';
import 'package:api_data_from_swagger/service/todo_services.dart';
import 'package:api_data_from_swagger/utils/snacksbar_helper.dart';
import 'package:api_data_from_swagger/widget/todo_card.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo List'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: Visibility(
          visible: items.isNotEmpty,
          replacement: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('No Data Found')
              ],
            ),
          ),
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = items[index] as Map;

                return TodoCard(
                    deleteById: deleteById,
                    navigateEdit: navigateToEdit,
                    item: item,
                    index: index);
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToAdd();
          },
          label: const Text('Add')),
    );
  }

  Future<void> navigateToAdd() async {
    final route = MaterialPageRoute(builder: (context) => const AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEdit(Map item) async {
    final route =
        MaterialPageRoute(builder: (context) => AddTodoPage(todo: item));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    final response = await TodoServices.fetchTodos();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      // ignore: use_build_context_synchronously
      showFailedMessage(context, message: 'Something Went Worng');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await TodoServices.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: 'Item Deleted');
    } else {
      // ignore: use_build_context_synchronously
      showFailedMessage(context, message: 'Unable To Delete');
    }
  }
}
