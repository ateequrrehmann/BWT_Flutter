import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        """CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT, priority TEXT, completionDate TEXT, time TEXT, status TEXT)""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('dbtodo.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print('....creating a table....');
      await createTables(database);
    });
  }

  static Future<int> createTasks(String title, String? description, String? createdDate,
      String? time, String? priority, String? status) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'priority': priority,
      'completionDate': createdDate,
      'time': time,
      'status': status
    };
    final id = await db.insert('tasks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await SQLHelper.db();
    return db.query('tasks', orderBy: "priority");
  }//when our app start all the items will fetch and shown

  static Future<List<Map<String, dynamic>>> getCompletedTasks() async {
    final db = await SQLHelper.db();
    return db.query('tasks', where: "status!=""Pending""",orderBy: "priority");
  }//when our app start all the items will fetch and shown

  static Future<List<Map<String, dynamic>>> getNotCompletedTasks() async {
    final db = await SQLHelper.db();
    return db.query('tasks', where: "status==""Pending""",orderBy: "priority");
  }//when our app start all the items will fetch and shown


  static Future<List<Map<String, dynamic>>> getTask(int id) async{
    final db= await SQLHelper.db();
    return db.query('tasks', where: "id=?",whereArgs: [id], limit: 1);
  }//getting the details of particular data

  static Future<int> updateTasks(int id, String title, String? description, String? createdDate,
      String? time, String? priority, String? status) async{
    final db=await SQLHelper.db();
    print(title);
    print(description);
    print(createdDate);

    final data = {
      'title': title,
      'description': description,
      'priority': priority,
      'completionDate': createdDate,
      'time': time,
      'status': status
    };
    final result=await db.update('tasks', data,  where: 'id=?', whereArgs:[id]);
    return result;
  }

  static Future<void> deleteTasks(int id) async{
    final db=await SQLHelper.db();
    try {
      await db.delete('tasks', where:"id=?", whereArgs: [id]);
    }catch(err){
      print("Something went wrong when deleting an item: $err");
    }
  }
}
