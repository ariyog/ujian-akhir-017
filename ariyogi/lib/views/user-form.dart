import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ariyogi/models/user.dart';
import 'package:ariyogi/provider/users-provider.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    final userRoute = ModalRoute.of(context)!.settings.arguments as User;

    _loadFormData(userRoute);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Form'),
        actions: [
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                    id: _formData['id'].toString(),
                    name: _formData['name'].toString(),
                    email: _formData['email'].toString(),
                    avatarUrl: _formData['avatarUrl'].toString(),
                  ),
                );

                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                keyboardType: TextInputType.name,
                maxLength: 50,
                validator: (keyName) {
                  if (keyName == null || keyName.trim().isEmpty)
                    return 'Masukkan Nama';
                  if (keyName.trim().length < 3)
                    return 'Nama minimal 3 kata';
                  return null;
                },
                onSaved: (value) => _formData['name'] = value.toString(),
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                maxLength: 50,
                validator: (keyEmail) {
                  if (keyEmail == null || keyEmail.trim().isEmpty)
                    return 'Informasikan Email';
                  RegExp regExp = new RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                  if (!regExp.hasMatch(keyEmail)) return "Email tidak valid";
                  return null;
                },
                onSaved: (value) => _formData['email'] = value.toString(),
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'URL'),
                keyboardType: TextInputType.url,
                maxLength: 100,
                validator: null,
                onSaved: (value) => _formData['avatarUrl'] = value.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
