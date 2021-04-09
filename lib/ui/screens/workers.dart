
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
            title: Text('Ajouter un travailleur'),
            content:
            GetX<TransactionsController>(builder: (transactionsController) {
              return   SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    transactionsController.loading.value ? Center(child: CircularProgressIndicator(),) :Form(
                      key: _formKey1,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: textinputDecoration.copyWith(
                              hintText: 'Nom',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (val) => val.isEmpty
                                ? 'Entrer un nom svp'
                                : null,
                            onChanged: (val) => setState(() => name = val),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
            actions: <Widget>[
              RaisedButton(
                  color: Colors.green,
                  child: Text('Ajouter'),
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
      appBar: AppBar(
        title: Text('Travailleurs'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Workerr>>(
          stream: DataBaseController().workers,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Stack(
              children: <Widget>[
                snapshot.data.length == 0
                    ? Center(
                  child: Text('Pas de travailleur trouvé'),
                )
                    : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Worker_card(data: snapshot.data[index]);
                  },
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _showMyDialog();
                    },
                  ),
                ),
              ],
            )
                : Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}