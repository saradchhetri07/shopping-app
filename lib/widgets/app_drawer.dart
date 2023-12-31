import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:shop/providers/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text("Shop me"),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('shop'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/");
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/orders");
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage your orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/userProduct");
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Log Out'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, "/");
            Provider.of<Auth>(context, listen: false).LogOut();
          },
        ),
      ]),
    );
  }
}
