// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DataBAseHelper{
//=================================variables====================================
  static Database? _db;
  static String dataBaseName= 'carnetDB.db';
  static String tableProducts = "CREATE TABLE carnetProduct(idProduct INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,nameList TEXT,nameProduct TEXT,price TEXT)";
  static String tableListes = "CREATE TABLE carnetListeClient(idListe INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nameList TEXT, som TEXT)";
//==============================================================================

//Cette fonction pour crée Database premier fois
  static void FirstCreate(Database db, int version) async{
    /* await db.execute(tableListes);
    await db.execute(tableProducts);*/
    Batch batch = db.batch();
    batch.execute(tableListes);
    batch.execute(tableProducts);
    await batch.commit();
  }

//Cette fonction pour ouvrir la basedonnée:
  static Future<Database> createDb() async{
 //  Directory dir = await getApplicationDocumentsDirectory();
    String dir = await getDatabasesPath();
    String path = join(dir, dataBaseName);
    Database myTable = await openDatabase(path, version: 1, onCreate: FirstCreate);
    return myTable;
  }

//Cette fonction pour obtenir les donnees de basedonnée:
  static Future<Database?> getdb() async{
    if (_db != null){
      return _db;
    }
    else{
      _db = await createDb();
      return _db;

    }

  }

//Cette fonction pour redemmarer la basedonnée
  static void DeleteDb() async{

   Directory dir= await getApplicationDocumentsDirectory();
   String dir1= await getDatabasesPath();

   String path = join(dir.path, dataBaseName);
   String path1 = join(dir1, dataBaseName);
   File f = File(path);
    if(!f.existsSync()){
      deleteDatabase(path);
      print("Database has deleted from $path");
   }
   File ff = File(path1);
   if(!ff.existsSync()){
     deleteDatabase(path1);
     print("Database has deleted from $path1");
   }
  }

//Cette fonction pour fermer basedonnée
  static Future<void> CloseDb() async{
    var db = await getdb();
    db?.close();
    _db = null;
  }

}
