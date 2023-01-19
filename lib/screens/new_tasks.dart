import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:array10_todo/component/components.dart';
import 'package:array10_todo/data/cubit.dart';
import 'package:array10_todo/data/states.dart';
import 'package:array10_todo/screens/add_task_form.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder:(context, state) =>Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>buildTaskItem(AppCubit.get(context).newTasks[index],context) ,
              itemCount: AppCubit.get(context).newTasks.length,
            ),
          ),
        ],
      ) ,
      listener: (context, state) {
          if(state is UpdateDataState){
            Flushbar(
              title:  "success",
              message:  "task status updated successfully",
              duration:  const Duration(seconds: 3),
              backgroundColor: Colors.green,
            ).show(context);
          }
      },

    );
  }

}
