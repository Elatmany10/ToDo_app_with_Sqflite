import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:array10_todo/component/components.dart';
import 'package:array10_todo/data/cubit.dart';
import 'package:array10_todo/data/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
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
      builder:(context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>buildTaskItem(AppCubit.get(context).doneTasks[index],context) ,
              itemCount: AppCubit.get(context).doneTasks.length,
            ),
          ),
        ],
      ) ,
    );
  }
}
