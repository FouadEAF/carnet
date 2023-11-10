// ignore_for_file: unused_import
class ListeClient{
  int _idListe;
  String _listName;
  String _som;

  ListeClient(this._idListe, this._listName, this._som);

  int get idListe => _idListe;
  String get listName => _listName;
  String get som => _som;
}

////////////////////////////////////////////////////////////////////////////////

class ListeProduct {
  int _idProduct;
  String _listName;
  String _productName;
  String _price;

  ListeProduct(this._idProduct, this._listName, this._productName, this._price);

  int get idProduct => _idProduct;
  String get listName => _listName;
  String get productName => _productName;
  String get price => _price;

}

