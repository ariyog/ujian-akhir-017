import 'package:flutter/material.dart';
import 'package:ariyogi/provider/users-provider.dart';
import 'package:ariyogi/routes/app-routes.dart';
import 'package:ariyogi/views/user-form.dart';
import 'package:ariyogi/views/user-list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsersProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UAS CRUD ARI',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          AppRoutes.HOME: (_) => UserList(),
          AppRoutes.USER_FORM: (_) => UserForm(),
        },
      ),
    );
  }
}
