import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chantiers extends StatefulWidget {
  @override
  _ChantiersState createState() => _ChantiersState();
}

class _ChantiersState extends State<Chantiers> {
  String name;
  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Ajouter un chantier',
              style: TextStyle(color: primaryColor),
            ),
            content: Form(
              key: _formKey1,
              child: TextFormField(
                decoration: textinputDecoration.copyWith(
                    hintText: 'Nom',
                    prefixIcon: Icon(
                      Icons.place,
                      color: primaryColor,
                    )),
                validator: (val) => val.isEmpty ? 'Entrer un nom svp' : null,
                onChanged: (val) => setState(() => name = val),
              ),
            ),
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
                      Navigator.pop(context);
                      await DataBaseController().updateChantier(
                        name,
                      );
                    }
                  }),
            ],
          );
        },
      );
    }

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Chantiers'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<List<Chantier>>(
          stream: DataBaseController().chantiers,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.data.length == 0
                    ? Center(
                        child: Text('Pas de chantier trouvé'),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Chantier_card(data: snapshot.data[index]);
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
