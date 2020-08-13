import 'package:fb_demo/employee.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  //
  final _formKey = GlobalKey<FormState>();

  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              addEmployee(context);
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            // name
            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(hintText: 'Name'),
              validator: (String namevalue) {
                if (namevalue.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // post
            TextFormField(
              controller: postController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(hintText: 'Post'),
              validator: (String postvalue) {
                if (postvalue.isEmpty) {
                  return 'Post is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // salary
            TextFormField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Salary'),
              validator: (String salaryvalue) {
                if (salaryvalue.isEmpty) {
                  return 'Salary is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void addEmployee(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      String name = nameController.text;
      String post = postController.text;
      int salary = int.parse(salaryController.text);

      Employee e = Employee(name: name, post: post, salary: salary);

      Firestore db = Firestore.instance;

      db.collection('employees').add(e.toMap()).then((result) {
        print('Employee Added');

        // nameController.text = '';
        // postController.text = '';
        // salaryController.text = '';
        _formKey.currentState.reset();

        Navigator.pop(context);
      }).catchError((error) {
        print(error);
      });
    }
  }
}
