import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moor_database_flutter/data/moor_database.dart';
import 'package:moor_database_flutter/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provider(
      create: (_) => AppDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GE_s',
        primarySwatch: Colors.blue,
      ),
        home: HomePage(),
      ),
    );
  }
}
