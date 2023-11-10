// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, non_constant_identifier_names, no_logic_in_create_state, use_key_in_widget_constructors, unnecessary_string_interpolations, must_be_immutable

import 'package:carnet/model/UserMethode.dart';
import 'package:carnet/model/model.dart';
import 'package:carnet/model/lang.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatefulWidget {
  String nameList;
  int idListe;
  bool lang;
  ListProduct(this.nameList, this.idListe, this.lang);
  @override
  State<ListProduct> createState() => _ListProducteState(nameList, idListe, lang);
}

class _ListProducteState extends State<ListProduct> {
  _ListProducteState(this.nameList, this.idListe, this.lang);
//=================================variables====================================
  bool lang;
  String nameList;
  int idListe;
  TextEditingController txtProductName = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  List ListeProducts = [];
//==============================================================================
//=================================Fonctions====================================
  void RefreshScreen() {
    ProductMethode.GetAllData(nameList).then((val) {
      setState(() {
        ListeProducts = val!;
        somListe();
        ListeMethode.UpdateData(ListeClient(idListe, nameList, '${somListe()}'));
      });
    });
  }
  double somListe(){
    int i = 0;
    double somm=0;
    for(i = 0; i < ListeProducts.length; i++){
      somm += double.parse(ListeProducts[i]['price']);
   }
    return somm;
  }
//==============================================================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RefreshScreen();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 216, 217, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 51, 56, 1.0),
        title: lang?Text('${fr.titreAppbar}'):Text('${en.titreAppbar}'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/img/LogoCarnet.png')),
      /*  actions: [
          Image.asset('assets/img/LogoCarnet.png'),
        ],*/
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 211, 87, 87),
        onPressed: () {
          AddProduct();
        },
        child: Icon(Icons.add),
      ),
      body: WillPopScope( onWillPop: () async {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Center(child: lang?Text('${fr.txtError}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12.0),):Text('${en.txtError}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12.0),)),
              ),
          );
          return false;},
          child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(child: lang?Text('${fr.txtNomFacture} $nameList',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 18.0),):Text('${en.txtNomFacture} $nameList',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 18.0),)),
            Center(child: Container(margin: EdgeInsets.all(5.0),width:MediaQuery.of(context).size.width * 0.3,decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(25.0)),child: MaterialButton(onPressed: (){Navigator.pushReplacementNamed(context, 'Home');},child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.arrow_back_ios, color: Colors.redAccent), lang?Text(fr.txtbtnRetour,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent,fontSize: 15.0),):Text(en.txtbtnRetour,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent,fontSize: 15.0),)],),))),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: ListeProducts.isEmpty
                    ?lang?Text('${fr.txtNoData}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 20.0),):Text('${en.txtNoData}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 20.0))
                    :ListView.builder(
                  itemCount: ListeProducts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: index%2 == 0?Colors.white:Colors.white70,
                      child: ListTile(
                          title: Text('${ListeProducts[index]['nameProduct']}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87,fontSize: 16.0),),
                          leading: Text('${ListeProducts[index]['price']} MAD',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87,fontSize: 15.0),),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red,),
                            onPressed: () {
                              ProductMethode.DeleteData(ListeProducts[index]['idProduct']);
                              RefreshScreen();
                            },
                          )),
                    );
                  },
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            lang?Text('${fr.txtSom} : ${somListe()} MAD',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 17.0),):Text('${en.txtSom} : ${somListe()} MAD',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 17.0),),
            Padding(padding: EdgeInsets.only(top: 50.0)),
          ],
        ),)
    );
  }

  Future AddProduct() async {
    // TODO: implement build

    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.egg, color: Colors.red,),
                  SizedBox(
                    width: 5.0,
                  ),
                  lang?Text('${fr.txtAddItem}',style:TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red),):Text('${en.txtAddItem}',style:TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red),)
                ],
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  children: [
                    SizedBox(
                      height: 45.0,
                      width: 200.0,
                      child: TextFormField(
                        controller: txtProductName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: lang?Text('${fr.txtFieldproduct}', style:TextStyle(fontWeight: FontWeight.bold,),):Text('${en.txtFieldproduct}', style:TextStyle(fontWeight: FontWeight.bold,),),
                          hintText: lang?fr.txtFieldCaption:en.txtFieldCaption,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    SizedBox(
                      height: 45.0,
                      width: 200.0,
                      child: TextFormField(
                        controller: txtPrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: lang?Text('${fr.txtprice}', style:TextStyle(fontWeight: FontWeight.bold,),):Text('${en.txtprice}', style:TextStyle(fontWeight: FontWeight.bold,),),
                          hintText: lang?fr.txtCaptinPrice:en.txtCaptinPrice,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton.icon(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => const Color.fromARGB(255, 211, 87, 87))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.undo),
                    label: lang?Text('${fr.txtUndoCaption}',style: TextStyle(fontSize: 14.0),):Text('${en.txtUndoCaption}',style: TextStyle(fontSize: 14.0),)
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => const Color.fromARGB(255, 211, 87, 87))),
                    onPressed: () {
                      if (txtProductName.text.isNotEmpty && txtPrice.text.isNotEmpty) {
                        setState(() {
                          ProductMethode.AddNewData(ListeProduct(0, nameList, txtProductName.text, txtPrice.text));
                          txtProductName.text = "";
                          txtPrice.text = "";
                        });
                        Navigator.pop(context);
                        RefreshScreen();
                      }
                    },
                    icon: Icon(Icons.save),
                    label: lang?Text('${fr.txtAddCaption}',style: TextStyle(fontSize: 14.0),):Text('${en.txtAddItem}',style: TextStyle(fontSize: 14.0),)
                ),
              ],
            ));
  }
}
