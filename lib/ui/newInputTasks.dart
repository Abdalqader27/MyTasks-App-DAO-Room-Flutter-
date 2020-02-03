import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moor_database_flutter/data/moor_database.dart';
import 'package:provider/provider.dart';

class NewTaskInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewTaskInputState();
  }
}

class NewTaskInputState extends State<NewTaskInput> {
  DateTime newTaskDate;
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTextField(context),
          _iconDateButton(context),
          RaisedButton(
            child: Text('إدخال '),
            onPressed: () {
              final database = Provider.of<AppDatabase>(context, listen: false);
              final task = new Task(
                  name: _controller.text,
                  dueData: newTaskDate,
                  completed: false);
              database.insertTask(task);
              restValueAfterSubmit();
            },
          )
        ],
      ),
    );
  }

  Expanded _buildTextField(context) {
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'اسم المهمة'),
          onSubmitted: (input) {},
        ),
      ),
    );
  }

  IconButton _iconDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.date_range),
      onPressed: () async {
        newTaskDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2050));
      },
    );
  }

  void restValueAfterSubmit() {
    setState(() {
      newTaskDate = null;
      _controller.clear();
    });
  }
}
