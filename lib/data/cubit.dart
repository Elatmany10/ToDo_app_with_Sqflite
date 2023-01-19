import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:array10_todo/data/states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());



  static AppCubit get(BuildContext context)=>BlocProvider.of(context);

  Database? database;
  List<Map<String, dynamic>> newTasks = [];
  List<Map<String, dynamic>> doneTasks = [];
  List<Map<String, dynamic>> archiveTasks = [];

  void createDatabase() {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (Database database, int version) {
        database
            .execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT) ")
            .then((value) {
          print("database created successfully");
        }).catchError((e) {
          print(e.toString());
        });
      },
      onOpen: (Database database) {
        selectFromDatabase(database);
        print("database opened");
      },
    ).then((value) {
      database = value;
    });
  }


  void insertIntoDatabase({
    required String title,
    required String time,
    required String date,
  }) {
    database?.transaction((txn) {
      return txn
          .rawInsert("INSERT INTO tasks (title,time,date,status)VALUES('$title','$time','$date','new')")
          .then((value) {
        selectFromDatabase(database!);
        print("task $value inserted");
      }).catchError((e) {
        print(e.toString());
      });
    });
  }

  void selectFromDatabase(Database database) {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if(element["status"]=="new")
        {
          newTasks.add(element);
        }else if(element["status"]=="done"){
          doneTasks.add(element);
        }else{
          archiveTasks.add(element);
        }
      });



      emit(GetDataState());
    }).catchError((e) => print(e.toString()));
  }

  void updateDatabase(String status, int id) {
    database?.rawUpdate("UPDATE tasks SET status =? WHERE id =?", [status, '$id']).then((value) {
      emit(UpdateDataState());
      selectFromDatabase(database!);
    }).catchError((e) {
      print(e.toString());
    });
  }

  void deleteFromDatabase(int id){
    database?.rawUpdate("DELETE FROM tasks WHERE id = ?",['$id']).then((value) {
      selectFromDatabase(database!);
    }).catchError((e){
      print(e.toString());
    });
  }

}