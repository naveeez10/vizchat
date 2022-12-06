import 'package:flutter/material.dart';
import 'package:vizchat/pages/search_page.dart';
import 'package:vizchat/service/auth_service.dart';

import '../shared/constants.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(onPressed: () {
            nextScreen(context, SearchPage());
          }, icon: Icon(Icons.search))
        ],
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        centerTitle: true,
        title: Text("Groups",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(Icons.account_circle,size: 150,color: Colors.grey[700],)
          ],
        ),
      ),
    );
  }
}
