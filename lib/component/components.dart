import 'package:flutter/material.dart';
import 'package:array10_todo/data/cubit.dart';

Widget myTextField({
  required String label,
  required IconData icon,
  bool readOnly=false,
  String? validator,
  required TextEditingController controller,
  void Function()? onTab,
})=>  TextFormField(
  readOnly:readOnly ,
  decoration: InputDecoration(
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    label: Text(label),
  ),
  onTap:onTab,

  validator: (value) {
    return validator??"";
  },
   controller: controller,
);

Widget buildTaskItem(
    Map<String,dynamic> task,
    BuildContext context,
    ){
  return Dismissible(
    key: Key("${task["id"]}"),
    onDismissed: (direction){
      AppCubit.get(context).deleteFromDatabase(task["id"]);
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20)
      ),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:  [
            CircleAvatar(
              child: Text(task["id"].toString()),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task["title"],style:const  TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(task["time"],style:const TextStyle(fontSize: 12,color: Colors.grey)),
                    Text(task["date"],style:const TextStyle(fontSize: 12,color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Spacer(),
            if(task["status"]!="done")
            TextButton(onPressed: (){
              AppCubit.get(context).updateDatabase("done", task["id"]);
            }, child: const Text("done")),
            if(task["status"]!="archive")
            TextButton(onPressed: (){
              AppCubit.get(context).updateDatabase("archive", task["id"]);

            }, child: const Text("archive"))
          ],
        ),
      ),
    ),
  );
}