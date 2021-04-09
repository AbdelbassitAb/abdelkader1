import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';


Future<void> showMyDialog(
    TR transaction, BuildContext context, ChefData chefData) async {
  final _formKey1 = GlobalKey<FormState>();

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  final TransactionsController transactionsController =
  Get.put(TransactionsController());

  var uuid = Uuid();
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      transactionsController.currentMoney(transaction.argent.toInt());
      transactionsController.descriptionTextfield.text =
          transaction.description ?? '';
      transactionsController.sommeTextfield.text =
          transaction.somme.toInt().toString() ?? 0.toString();
      return AlertDialog(
        title: transaction.name == '' ? Text('Supprimer la transaction')  :  Text('Ajouter une transaction'),
        content:
        GetX<TransactionsController>(builder: (transactionsController) {
          return SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                transactionsController.loading.value ? Center(child: CircularProgressIndicator())  : transaction.name == '' ? SizedBox() : Form(
                  key: _formKey1,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: transactionsController.descriptionTextfield,
                        decoration: textinputDecoration.copyWith(
                          hintText: 'descripton',
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
                        validator: (val) =>
                        val.isEmpty ? 'entrer une description svp' : null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: transactionsController.sommeTextfield,
                        keyboardType: TextInputType.number,
                        decoration: textinputDecoration.copyWith(
                          hintText: '0',
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
                        validator: (val) =>
                        val.isEmpty ? 'entrer une somme svp' : null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Payer un travailleur'),
                          Checkbox(
                              value: transactionsController.checkBoxValue.value,
                              activeColor: Colors.green,
                              onChanged: (bool newValue) {
                                transactionsController.checkBoxValue(newValue);
                                print(transactionsController.checkBoxValue.value);
                              }),
                        ],
                      ),
                      transactionsController.checkBoxValue.value ? Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selectionner un travailleur'),
                          SizedBox(height: 5,),
                          StreamBuilder<List<Workerr>>(
                              stream: DataBaseController().workers,
                              builder: (context, snapshot) {
                                if(snapshot.hasData)
                                {



                                  List<Workerr> list = snapshot.data;
                                  transactionsController.selectedWorker.name = '';

                                  transactionsController.selectedWorker.uid = null;




                                  list.add(transactionsController.selectedWorker);
                                  return  DropdownButtonFormField(
                                    value: transaction.workerId != null ? transaction.workerName : transactionsController.selectedWorker.name ,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(4.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.attach_money,
                                        color: Colors.blue,
                                      ),
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
                                    items: snapshot.data.map((worker) {
                                      return DropdownMenuItem(
                                        value: worker.name,
                                        child: Text(
                                          worker.name,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      print(val);

                                      for(int i=0;i<list.length;i++)
                                      {
                                        if(list[i].name==val)
                                        {

                                          print('true');
                                          transactionsController.selectedWorker.name = val;
                                          transactionsController.selectedWorker.uid = list[i].uid;
                                        }
                                      }


                                    },
                                  );


                                }else
                                {
                                  return SizedBox();
                                }

                              }),
                        ],
                      ) : SizedBox()
                    ],
                  ),
                )
              ],
            ),
          );
        }),
        actions: <Widget>[
          transactionsController.loading.value ? SizedBox() : transaction.name == '' ? SizedBox() : RaisedButton(
              color: Colors.green,
              child:
              transaction.uid == null ? Text('Ajouter') : Text('Modifier'),
              onPressed: () async {
                if (_formKey1.currentState.validate()) {
                  transactionsController.loading(true);
                  transactionsController.currentMoney((double.parse(
                      transactionsController.sommeTextfield.text) +
                      transactionsController.currentMoney.value -
                      transaction.somme)
                      .toInt());

                  await DataBaseController(uid: chefData.uid).updateUserData(
                      chefData.uid,
                      chefData.name,
                      chefData.email,
                      chefData.numTlf,
                      transactionsController.currentMoney.value.toDouble() ??
                          chefData.argent,
                      chefData.deleted);


                  if(transaction.workerName != transactionsController.selectedWorker.name)
                  {
                    await DataBaseController(uid: transaction.workerId)
                        .deleteWorkersTransaction(transaction.uid);
                  }


                  await DataBaseController(uid: chefData.uid)
                      .updateUserTransaction(
                    transaction.uid == null ? uuid.v4() : transaction.uid,
                    chefData.name,
                    transactionsController.descriptionTextfield.text,
                    dateFormat.format(DateTime.now()),
                    transactionsController.currentMoney.value.toDouble() ??
                        chefData.argent,
                    double.parse(transactionsController.sommeTextfield.text),
                    transactionsController.selectedWorker,
                    chefData.deleted,
                  );





                  transactionsController.sommeTextfield.text = '0';
                  transactionsController.descriptionTextfield.text = '';
                  transactionsController.selectedWorker.name = '';
                  transactionsController.selectedWorker.uid = null;
                  transactionsController.loading(false);
                  Get.back();
                }
              }),
          transaction.uid != null
              ?  transactionsController.loading.value ? SizedBox() :  RaisedButton(
              color: Colors.red,
              child: Text('Suprimer'),
              onPressed: () async {
                transactionsController.loading(true);
                await DataBaseController(uid: chefData.uid).updateUserData(chefData.uid, chefData.name, chefData.email, chefData.numTlf, chefData.argent-transaction.somme, chefData.deleted);
                await DataBaseController(uid: chefData.uid)
                    .deleteTransaction(transaction.uid);
                await DataBaseController(uid: transaction.workerId)
                    .deleteWorkersTransaction(transaction.uid);
                transactionsController.loading(false);
                Navigator.of(context).pop();
              })
              : SizedBox(),
        ],
      );
    },
  );
}
