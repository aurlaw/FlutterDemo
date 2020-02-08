import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SuggestionsRepository {

  Database _database;

  SuggestionsRepository();

  // initializes and opens database
  Future _init() async {
    String path = await _getDb();
    _database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
      // When creating the db, create the table
        await db.execute(
          'CREATE TABLE IF NOT EXISTS SavedSuggestions (id INTEGER PRIMARY KEY, name TEXT)');
      },
      onOpen: (Database db) async {
        // Database is open, print its version
        print('db version ${await db.getVersion()}');
      });

  }

// Saves a record
  Future save(name) async {
    if(_database == null) {
      await _init();
    }
      //database
    var map = <String, dynamic>{
      'name': name
    };      
    var id = await _database.insert("SavedSuggestions", map);
    print('inserted: $id');
  }
// Delete a record
  Future delete(name) async {
    if(_database == null) {
      await _init();
    }

    var count = await _database.delete("SavedSuggestions", where: "name = ?", whereArgs: [name]);
    print('deleted: $count');
  }
  // Retrieves all items
  Future<List<String>> getAll() async {
    if(_database == null) {
      await _init();
    }

    List<String> list = List<String> ();
    List<Map> map = await _database.query("SavedSuggestions", columns: ["name"]);
    if(map.length > 0) {
        map.forEach((f) => list.add(f['name']));
    }
    print('returned ${list.length} items');
    return list;
  }
  // Closes the database
  Future close() async {
    if(_database == null) {
      await _init();
    }
    await _database.close();
  } 


  Future<String> _getDb() async {
    var databasesPath = await getDatabasesPath();
    return  join(databasesPath, 'demo.db');
  }
}
