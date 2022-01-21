import 'package:flutter/material.dart';
import 'package:ariyogi/models/user.dart';
import 'package:ariyogi/provider/users-provider.dart';
import 'package:ariyogi/routes/app-routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? CircleAvatar(
            radius: 30,
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user.avatarUrl),
            backgroundColor: Colors.white,
          );

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
              color: Colors.amber,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Hapus User'),
                    content: Text('Konfirmasi'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Tidak'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Ya'),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed)
                    Provider.of<UsersProvider>(context, listen: false)
                        .delete(user);
                });
              },
              color: Colors.red.shade600,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
