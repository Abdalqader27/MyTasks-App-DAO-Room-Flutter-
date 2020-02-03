import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moor_database_flutter/data/moor_database.dart';
import 'package:provider/provider.dart';

import 'newInputTasks.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text('مهامي ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildTaskList(context),
            ),
            NewTaskInput(),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapShots) {
        final tasks = snapShots.data ?? List();
        return ListView.builder(
          physics: BouncingScrollPhysics(),
        itemCount: tasks.length,
            itemBuilder: (_, index) {
        final itemTask = tasks[index];
        return _buildListItems(itemTask, database);
        });
      },
    );
  }

  Widget _buildListItems(Task itemTask, AppDatabase database) {
    return Card(
      margin: EdgeInsets.all(2),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => database.deleteTask(itemTask),
            )
          ],
          child: CheckboxListTile(
            title: Text(itemTask.name),
            subtitle: Text(itemTask.dueData?.toString() ?? 'لايوجد تاريخ'),
            value: itemTask.completed,
            onChanged: (newValue) {
              database.updateTask(itemTask.copyWith(completed: newValue));
            },
          ),
        ),
      ),
    );
  }
}
