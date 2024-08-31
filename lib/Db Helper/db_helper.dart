// import 'package:database_quotes_app/view/screens/home_page.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DbHelper
// {
//   static DbHelper dbHelper = DbHelper._();
//
//   DbHelper._();
//
//   Database? _db;
//
//   Future<Database?> get database async => _db ?? await initDatabase();
//
//
//   Future<Database?> initDatabase()
//   async {
//     final path =await getDatabasesPath();
//     final dbPath =join(path,'favourite.db');
//
//     _db = await openDatabase(dbPath , version: 1 , onCreate: (db, version) async {
//
//       String sql = '''CREATE TABLE favourite(
//       quote TEXT,
//       author TEXT,
//       category TEXT,
//       isLiked TEXT,
//        );''';
//       await db.execute(sql);
//     },);
//     return _db;
//   }
//
//   Future insertData(String quote, String author, String category, String isLiked)
//   async {
//     Database? db = await database;
//
//     String sql ='''
//     INSERT INTO favourite (quote,author,category,isLiked)
//     VALUES (?,?,?,?);
//     ''';
//     List args = [quote, author, category, isLiked];
//     await db!.rawInsert(sql,args);
//   }
//
//   Future<List<Map<String, Object?>>> readData()
//   async {
//     Database? db = await database;
//     String sql = '''SELECT * FROM favourite''';
//     return await db!.rawQuery(sql);
//   }
// }

import 'package:database_quotes_app/modal/quotes_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper dbHelper = DbHelper._();

  DbHelper._();


  Database? _db;


  Future<Database?> get database async => _db ??= await initDatabase();


  Future<Database> initDatabase() async {

    final path = await getDatabasesPath();
    final dbPath = join(path, 'favourite.db');


    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {

        String sql = '''
          CREATE TABLE favourite(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
            quote TEXT,
            author TEXT,
            category TEXT,
            isLiked TEXT
          );
        ''';

        await db.execute(sql);
      },
    );
  }


  Future<void> insertData(
      String quote, String author, String category, String isLiked) async {

    final db = await database;


    String sql = '''
      INSERT INTO favourite (quote, author, category, isLiked)
      VALUES (?, ?, ?, ?);
    ''';
    List args = [quote, author, category, isLiked];
    await db!.rawInsert(sql, args);
  }


  Future<List<QuoteModal>> readData() async {
    final db = await database;
    String sql = '''
      SELECT * FROM favourite
    ''';
    final map =  await db!.rawQuery(sql);

    return List.generate(map.length, (index) => QuoteModal.fromJson(map[index]),);
  }

  Future<int> deleteQuotes(int id) async {
    Database? db = await database;
    String sql = '''
    DELETE FROM favourite WHERE id = ?
    ''';
    List args = [id];
    return await db!.rawDelete(sql, args);
  }
}
