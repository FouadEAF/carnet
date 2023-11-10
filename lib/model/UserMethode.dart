
// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:carnet/model/DBHelper.dart';
import 'package:carnet/model/model.dart';
import 'package:sqflite/sqflite.dart';

class ListeMethode{
//=================================variables====================================
  static String nameOfTable ='carnetListeClient';
//==============================================================================

//Cette foncion pour ajouter un nouveau element
  static Future<int?> AddNewData(ListeClient listeClient) async{
    Database? myDb= await DataBAseHelper.getdb();
    myDb!.rawInsert("INSERT INTO ${nameOfTable}('idListe', 'nameList', 'som') "
        "VALUES(?, '${listeClient.listName}', '${listeClient.som}')");
  }

//Cette fonction pour obtenir tous les data de DB
  static Future<List?> GetAllData() async {
    Database? myDb = await DataBAseHelper.getdb();
    List? Info = await myDb?.rawQuery("SELECT * FROM ${nameOfTable}",);
    return Info?.toList();
  }

//Cette fonction pour editer un enregistrement dans DB
  static Future<int?> UpdateData(ListeClient newObjData) async{
    Database? myDb= await DataBAseHelper.getdb();
    Map<String, dynamic> newData= Map();
    newData["idListe"]= newObjData.idListe; // nouveau data
    newData["nameList"]= newObjData.listName;
    newData["som"]= newObjData.som;
    int? res = await myDb?.update(nameOfTable, newData, where: "idListe= ${newObjData.idListe}");
    return res;
  }

//Cette fonction pour supprimer un enregistrement dans DB
  static Future<int?> DeleteData(int idItem) async {
    Database? myDb= await DataBAseHelper.getdb();
    int? res = await myDb?.delete(nameOfTable, where: "idListe= ${idItem}");
    return res;
  }

}

//______________________________________________________________________________

class ProductMethode{
//=================================variables====================================
  static String nameOfTable ='carnetProduct';
//==============================================================================

//Cette foncion pour ajouter un nouveau element
  static Future<int?> AddNewData(ListeProduct product) async{
    Database? myDb= await DataBAseHelper.getdb();
    myDb!.rawInsert("INSERT INTO ${nameOfTable}('idProduct', 'nameList', 'nameProduct', 'price')"
        "VALUES(?, '${product.listName}', '${product.productName}', ${product.price})");
  }

//Cette fonction pour obtenir tous les data de DB
  static Future<List?> GetAllData(String nameList) async {
    Database? myDb = await DataBAseHelper.getdb();
    List? Info = await myDb?.rawQuery("SELECT * FROM ${nameOfTable} WHERE nameList = '$nameList'");
    return Info?.toList();
  }
//Cette fonction pour obtenir tous les data de DB
  static Future<List?> GetAllProducts() async {
    Database? myDb = await DataBAseHelper.getdb();
    List? Info = await myDb?.rawQuery("SELECT * FROM ${nameOfTable}");
    return Info?.toList();
  }

//Cette fonction pour editer un enregistrement dans DB
  static Future<int?> UpdateData(ListeProduct newObjData) async{
    Database? myDb= await DataBAseHelper.getdb();
    Map<String, dynamic> newData= {};
    newData["idProduct"]= newObjData.idProduct; // nouveau data
    newData["listName"]= newObjData.listName;
    newData["productName"]= newObjData.productName;
    newData["price"]= newObjData.price;
    int? res = await myDb?.update(nameOfTable, newData, where: "idProduct= ${newObjData.idProduct}");
    return res;
  }

//Cette fonction pour supprimer un enregistrement seulement dans DB 
  static Future<int?> DeleteData(int IdItem) async {
    Database? myDb= await DataBAseHelper.getdb();
    int? res = await myDb?.delete(nameOfTable, where: "idProduct= ${IdItem}");
    return res;
  }

//Cette fonction pour supprimer un table complet dans DB
  static Future DeleteDataTable(String listName) async {
    Database? myDb= await DataBAseHelper.getdb();
    var res = await myDb?.delete(nameOfTable, where: "nameList= '${listName}'");
    return res;
  }
}

