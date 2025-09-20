import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_data_manager/views/home_view.dart' as home_view;
import 'package:flutter_data_manager/providers/student_provider.dart' as student_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MyApp(localStorage: localStorage));
}
class MyApp extends StatelessWidget {
  final LocalStorage localStorage;
  const MyApp({Key? key, required this.localStorage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Wrap the MaterialApp with the ChangeNotifierProvider
    return ChangeNotifierProvider<student_provider.StudentProvider>(
      create: (_) => student_provider.StudentProvider(storage: localStorage),
      child: MaterialApp(
        title: 'Student Management App',
        home: home_view.HomeScreen(), // Assuming HomeScreen leads to EditStudentScreen
      ),
    );
  }
}

