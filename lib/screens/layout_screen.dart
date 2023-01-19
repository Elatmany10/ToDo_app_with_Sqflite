import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:array10_todo/data/cubit.dart';
import 'package:array10_todo/data/states.dart';
import 'package:array10_todo/screens/add_task_form.dart';
import 'package:array10_todo/screens/archive_tasks.dart';
import 'package:array10_todo/screens/done_tasks.dart';
import 'package:array10_todo/screens/new_tasks.dart';

class LayoutScreen extends StatefulWidget {
 LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
 int currentIndex=0;
 List<String> titles=[
   "New","Done","Archive"
 ];
List<Widget> screens=[
  NewTasksScreen(),
  DoneTasksScreen(),
  ArchiveTasksScreen(),
];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title:  Text("${titles[currentIndex]} Tasks"),
            centerTitle: true,
          ),
          body: screens[currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              final value=BlocProvider.of<AppCubit>(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                constraints:BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height*0.75,
                ) ,
                builder:(__) => BlocProvider.value(
                  value: value,
                  child:AddTaskForm(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap:(int value){
              currentIndex=value;
              setState(() {

              });
            } ,
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon:Icon(Icons.task) ,
                  label: "New"

              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.done) ,
                  label: "Done"

              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.archive) ,
                  label: "Archive"
              ),
            ],
          ),

        ),
      ),
    );
  }
}
