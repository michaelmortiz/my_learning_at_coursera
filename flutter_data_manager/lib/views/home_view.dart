import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_data_manager/models/student_model.dart' as student_model;
import 'package:flutter_data_manager/providers/student_provider.dart' as student_provider;
import 'package:flutter_data_manager/views/edit_student_view.dart' as edit_student_view;



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student List'),
        ),
        body: Consumer<student_provider.StudentProvider>(
            builder: (context, provider, child) {
              return ListView.builder(
                  itemCount: provider.students.length,
                  itemBuilder: (context, index) {
                    final student = provider.students[index];
                    return ListTile(
                      title: Text('${student.firstName} ${student.lastName}'),
                      subtitle: Text('Age: ${student.age} - Major: ${student.major}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  edit_student_view.EditStudentView(student: student),
                          ),
                        );
                      },
                    );
                  }
              );
            }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => edit_student_view.EditStudentView(),
              ),
            );
          },
          child: Icon(Icons.add),
          tooltip: 'Add Student',
        ),
      ),
    );
  }
}

