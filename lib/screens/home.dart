
import 'package:carnet/model/UserMethode.dart';
import 'package:carnet/model/model.dart';
import 'package:carnet/model/lang.dart';
import 'package:carnet/model/prefShared.dart';
import 'package:carnet/screens/listProduct.dart';
import 'package:flutter/material.dart';
//import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//=================================variables====================================
  TextEditingController txtListName = TextEditingController();
  List ListeClients = [], ListProducts = [];
  //List ListProducts = [];
  bool lang = false;
  //String _sysLng = ui.window.locale.languageCode; //get device language

//==============================================================================
//==================================fonctions===================================

  void RefreshScreen() {
    prefSh.getBoolValuesSF('langue');
    ListeMethode.GetAllData().then((val) {
      setState(() {
        ListeClients = val!;
      });
    });
    ProductMethode.GetAllProducts().then((val) {
      setState(() {
        ListProducts = val!;
      });
    });

  }

  Widget listeDropDown() {
    return PopupMenuButton<String>(
      onSelected: (String logha) {
        switch (logha) {
          /*  case 'ar':
            langue = 'ar';
            setState(() {print('use $langue');});
            break;*/
          case 'fr':
            lang = true;
            setState(() {
              prefSh.addBoolToSF('langue', lang);
              print(lang);
            });
            break;
          case 'en':
            lang = false;
            setState(() {
              prefSh.addBoolToSF('langue', lang);
              print(lang);
            });
            break;
          default:
          //langue = _sysLng;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        /*   PopupMenuItem<String>(
          value: 'ar',
          child: Text(
            'العربية',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),*/
        const PopupMenuItem<String>(
          value: 'fr',
          child: Text(
            'Français',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'en',
          child: Text(
            'English',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
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
        backgroundColor: Color.fromRGBO(238, 51, 56, 1),
        title: lang ? Text(fr.titreAppbar) : Text(en.titreAppbar),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/img/LogoCarnet.png'),
        ),
        actions: [listeDropDown()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 211, 87, 87),
        onPressed: () async {
          await AddList();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          lang
              ? Text(
                  '${fr.txtSalut} Developer EAF',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 14.0),
                )
              : Text(
                  '${en.txtSalut} Developer EAF',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 14.0),
                ),
          //MaterialButton(onPressed: (){DataBAseHelper.DeleteDb(); RefreshScreen();print('i was delete DB, think');},child: Text('Delete DB'),),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: ListeClients.isEmpty
                  ? Center(
                      child: lang
                          ? Text(
                              fr.txtNoData,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 16.0),
                            )
                          : Text(
                              en.txtNoData,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 16.0),
                            ))
                  : ListView.builder(
                      itemCount: ListeClients.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListProduct(
                                        '${ListeClients[index]['nameList']}',
                                        ListeClients[index]['idListe'],
                                        lang)));
                          },
                          child: Card(
                            color: index % 2 == 0
                                ? Colors.white60
                                : Colors.white30,
                            child: ListTile(
                              title: Text(
                                '${ListeClients[index]['nameList']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: 16.0),
                              ),
                              leading: Text(
                                '${ListeClients[index]['som']} MAD',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 14.0),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  ConfirmDelete(index);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }

  Future AddList() async {
    // TODO: implement build
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  lang
                      ? Text(
                          fr.txtListName,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )
                      : Text(
                          en.txtListName,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )
                ],
              ),
              content: SizedBox(
                height: 45.0,
                width: 200.0,
                child: TextFormField(
                  controller: txtListName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: lang
                        ? Text(
                            fr.txtFieldName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            en.txtFieldName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    hintText: lang ? fr.txtFieldCaption : en.txtFieldCaption,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              actions: [
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                const Color.fromARGB(255, 211, 87, 87))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.undo),
                    label: lang
                        ? Text(
                            fr.txtUndoCaption,
                            style: TextStyle(fontSize: 14.0),
                          )
                        : Text(
                            en.txtUndoCaption,
                            style: TextStyle(fontSize: 14.0),
                          )),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                const Color.fromARGB(255, 211, 87, 87))),
                    onPressed: () {
                      if (txtListName.text != "") {
                        setState(() {
                          ListeMethode.AddNewData(
                              ListeClient(0, txtListName.text, "0"));
                          txtListName.text = "";
                        });
                        Navigator.pop(context);
                      }
                      RefreshScreen();
                    },
                    icon: Icon(Icons.save),
                    label: lang
                        ? Text(
                            fr.txtAddCaption,
                            style: TextStyle(fontSize: 14.0),
                          )
                        : Text(
                            en.txtAddCaption,
                            style: TextStyle(fontSize: 14.0),
                          )),
              ],
            ));
  }

//============Delete data
  Future ConfirmDelete(int id) async {
    // TODO: implement build
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  lang
                      ? Text(
                          'Confirmation de la suppression',
                          style: TextStyle(fontSize: 14.0),
                        )
                      : Text(
                          'Confirm Delete',
                          style: TextStyle(fontSize: 14.0),
                        ),
                ],
              ),
              content: lang
                  ? Text(
                      'Vous voulez vraiment supprimer cette liste?',
                      style: TextStyle(fontSize: 14.0),
                    )
                  : Text(
                      'Are you sure you want to delete this List?',
                      style: TextStyle(fontSize: 14.0),
                    ),
              actions: [
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                const Color.fromARGB(255, 211, 87, 87))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    label: lang
                        ? Text(
                            'Non',
                            style: TextStyle(fontSize: 14.0),
                          )
                        : Text(
                            'No',
                            style: TextStyle(fontSize: 14.0),
                          )),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                const Color.fromARGB(255, 211, 87, 87))),
                    onPressed: () {
                      setState(() {
                        for (int i = 0; i < ListProducts.length; i++) {
                          if (ListeClients[id]['nameList'] ==
                              ListProducts[i]['nameList']) {
                            ProductMethode.DeleteDataTable(
                                ListProducts[i]['nameList']);
                          }
                        }
                        ListeMethode.DeleteData(ListeClients[id]['idListe']);
                      });
                      Navigator.pop(context);
                      RefreshScreen();
                    },
                    icon: Icon(Icons.check),
                    label: lang
                        ? Text(
                            'Oui',
                            style: TextStyle(fontSize: 14.0),
                          )
                        : Text(
                            'Yes',
                            style: TextStyle(fontSize: 14.0),
                          )),
              ],
            ));
  }
}
