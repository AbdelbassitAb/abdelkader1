import 'package:abdelkader1/constants/constants.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class Workers extends StatefulWidget {
  @override
  _WorkersState createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  String name;
  var uuid = Uuid();

  final _formKey1 = GlobalKey<FormState>();

  final TransactionsController transactionsController =
      Get.put(TransactionsController());

  @override
  void initState() {
    name = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              'Ajouter un travailleur',
              style: TextStyle(color: primaryColor),
            ),
            content:
                GetX<TransactionsController>(builder: (transactionsController) {
              return SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    transactionsController.loading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Form(
                            key: _formKey1,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: textinputDecoration.copyWith(
                                    hintText: 'Nom',
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: primaryColor,
                                    ),
                                  ),
                                  validator: (val) =>
                                      val.isEmpty ? 'Entrer un nom svp' : null,
                                  onChanged: (val) =>
                                      setState(() => name = val),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              );
            }),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'Ajouter',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey1.currentState.validate()) {
                      transactionsController.loading(true);
                      Navigator.pop(context);
                      await DataBaseController().updateWorkerData(
                        uuid.v4(),
                        name,
                      );
                      transactionsController.loading(false);
                    }
                  }),
            ],
          );
        },
      );
    }

    return Scaffold(
     // backgroundColor: secondaryColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Travailleurs'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<List<Workerr>>(
          stream: DataBaseController().workers,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.data.length == 0
                    ? Center(
                        child: Text('Pas de travailleur trouvé'),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Worker_card(data: snapshot.data[index]);
                        },
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
        onPressed: () {
          _showMyDialog();
        },
      ),
    );
  }
}
