import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:array10_todo/component/components.dart';
import 'package:array10_todo/data/cubit.dart';



class AddTaskForm extends StatefulWidget {
  AddTaskForm({Key? key}) : super(key: key);

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  TextEditingController titleController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 2,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            myTextField(
              label: "task title",
              icon: Icons.title,
              controller: titleController,
            ),
            const SizedBox(height: 10),
            myTextField(
              readOnly: true,
              label: "task time",
              onTab: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((TimeOfDay? value) {
                  if (value != null) {
                    timeController.text = value.format(context);
                  }
                });
              },
              icon: Icons.timer_outlined,
              controller: timeController,
            ),
            const SizedBox(height: 10),
            myTextField(
              readOnly: true,
              onTab: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                ).then((value) {
                  if (value != null) {
                    dateController.text = DateFormat.yMEd().format(value);
                  }
                });
              },
              label: "task date",
              icon: Icons.date_range,
              controller: dateController,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                onPressed: () {
                  AppCubit.get(context).insertIntoDatabase(
                      title: titleController.text, time: timeController.text, date: dateController.text);
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text("Save Task", style: TextStyle(fontSize: 20)),
                ))
          ],
        ),
      ),
    );
  }

}
