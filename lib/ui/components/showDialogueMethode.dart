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
  final List<String> chantierList = ['chlef', 'tipaza', 'oran'];
  final List<String> typeList = [
    'Achat materiaux',
    'Gaz',
    'Nouriture',
    'Payement'
  ];

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  final TransactionsController transactionsController =
      Get.put(TransactionsController());

  var uuid = Uuid();

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      transactionsController.init(transaction);
      return AlertDialog(
        title: Text(title(transaction)),
        content:
            GetX<TransactionsController>(builder: (transactionsController) {
          return SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                transaction.name == ''
                    ? SizedBox()
                    : Form(
                        key: _formKey1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            DescriptionTextField(transactionsController),
                            SizedBox(
                              height: 10,
                            ),
                            MoneyTextField(transactionsController),
                            SizedBox(
                              height: 10,
                            ),
                            ChantierDropDownField(
                                chantierList, transactionsController,transaction),
                            SizedBox(
                              height: 10,
                            ),
                            TypeDropDownField(typeList, transactionsController,transaction),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('Payer un travailleur'),
                                CustomCheckBox(transactionsController),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            transactionsController.checkBoxValue.value
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Selectionner un travailleur'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      StreamBuilder<List<Workerr>>(
                                          stream: DataBaseController().workers,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<Workerr> list =
                                                  snapshot.data;

                                              list.add(
                                                  Workerr(name: '', uid: null));
                                              return WorkersDropDownField(
                                                  transaction,
                                                  transactionsController,
                                                  snapshot,
                                                  list);
                                            } else {
                                              return SizedBox();
                                            }
                                          }),
                                    ],
                                  )
                                : SizedBox()
                          ],
                        ),
                      )
              ],
            ),
          );
        }),
        actions: <Widget>[
          transaction.name == ''
              ? SizedBox()
              : AddEditButton(transaction, transactionsController, chefData,
                  _formKey1, dateFormat, uuid),
          transaction.uid != null
              ? transactionsController.loading.value
                  ? SizedBox()
                  : DeleteButton(transactionsController, chefData, transaction)
              : SizedBox(),
        ],
      );
    },
  );
}

class DescriptionTextField extends StatelessWidget {
  final TransactionsController transactionsController;

  DescriptionTextField(this.transactionsController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: transactionsController.descriptionTextfield,
      decoration: textinputDecoration.copyWith(
        labelText: 'description',
      ),
      validator: (val) => val.isEmpty ? 'entrer une description svp' : null,
      onChanged: (val){
        print(transactionsController.chantier.value);
      },
    );
  }
}

class MoneyTextField extends StatelessWidget {
  final TransactionsController transactionsController;

  MoneyTextField(this.transactionsController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: transactionsController.sommeTextfield,
      keyboardType: TextInputType.number,
      decoration: textinputDecoration.copyWith(
        labelText: 'somme',
      ),
      validator: (val) => val.isEmpty ? 'entrer une somme svp' : null,
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  final TransactionsController transactionsController;

  CustomCheckBox(this.transactionsController);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: transactionsController.checkBoxValue.value,
        activeColor: Colors.green,
        onChanged: (bool newValue) {
          transactionsController.checkBoxValue(newValue);
        });
  }
}

class WorkersDropDownField extends StatelessWidget {
  final TR transaction;
  final TransactionsController transactionsController;
  final AsyncSnapshot<List<Workerr>> snapshot;
  final List<Workerr> list;

  WorkersDropDownField(
      this.transaction, this.transactionsController, this.snapshot, this.list);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: transaction.workerId != null
          ? transaction.workerName
          : transactionsController.selectedWorker.name,
      decoration: textinputDecoration,
      items: snapshot.data.map((worker) {
        return DropdownMenuItem(
          value: worker.name,
          child: Text(
            worker.name,
          ),
        );
      }).toList(),
      onChanged: (val) {
        affectDropDownValueToTransactionController(
            transactionsController, list, val);
      },
    );
  }
}

class TypeDropDownField extends StatelessWidget {
  final TransactionsController transactionsController;
  final List<String> list;
  final TR transaction;

  TypeDropDownField(
    this.list,
    this.transactionsController,
      this.transaction,
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value:transaction.type != null
          ? transaction.type
          :  list[0],
      decoration: textinputDecoration,
      items: list.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (val) {
        transactionsController.type(val);
      },
    );
  }
}

class ChantierDropDownField extends StatelessWidget {
  final TransactionsController transactionsController;
  final List<String> list;
  final TR transaction;

  ChantierDropDownField(this.list, this.transactionsController,this.transaction);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value:transaction.chantier != null
          ? transaction.chantier
          : list[0],
      decoration: textinputDecoration,
      items: list.map((chantier) {
        return DropdownMenuItem(
          value: chantier,
          child: Text(chantier),
        );
      }).toList(),
      onChanged: (val) {
        transactionsController.chantier(val);
      },
    );
  }
}

class AddEditButton extends StatelessWidget {
  final TR transaction;
  final TransactionsController transactionsController;
  final ChefData chefData;
  final GlobalKey<FormState> _formKey1;
  final DateFormat dateFormat;
  final Uuid uuid;

  AddEditButton(this.transaction, this.transactionsController, this.chefData,
      this._formKey1, this.dateFormat, this.uuid);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.green,
        child: transaction.uid == null ? Text('Ajouter') : Text('Modifier'),
        onPressed: () async {
          if (_formKey1.currentState.validate()) {
            transactionsController.loading(true);
            transactionsController.currentMoney(
                (double.parse(transactionsController.sommeTextfield.text) +
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

            if (transaction.workerName !=
                transactionsController.selectedWorker.name) {
              await DataBaseController(uid: transaction.workerId)
                  .deleteWorkersTransaction(transaction.uid);
            }

            await DataBaseController(uid: chefData.uid).updateUserTransaction(
                transaction.uid == null ? uuid.v4() : transaction.uid,
                chefData.name,
                transactionsController.descriptionTextfield.text,
                dateFormat.format(DateTime.now()),
                transactionsController.currentMoney.value.toDouble() ??
                    chefData.argent,
                double.parse(transactionsController.sommeTextfield.text),
                transactionsController.selectedWorker,
                chefData.deleted,
                transactionsController.type.value,
                transactionsController.chantier.value);

            transactionsController.chantier('');
            transactionsController.type('');
            transactionsController.sommeTextfield.text = '0';
            transactionsController.descriptionTextfield.text = '';
            transactionsController.selectedWorker.name = '';
            transactionsController.selectedWorker.uid = null;
            transactionsController.loading(false);
            Get.back();
          }
        });
  }
}

class DeleteButton extends StatelessWidget {
  final TransactionsController transactionsController;
  final ChefData chefData;
  final TR transaction;

  DeleteButton(this.transactionsController, this.chefData, this.transaction);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.red,
        child: Text('Suprimer'),
        onPressed: () async {
          transactionsController.loading(true);
          await DataBaseController(uid: chefData.uid).updateUserData(
              chefData.uid,
              chefData.name,
              chefData.email,
              chefData.numTlf,
              chefData.argent - transaction.somme,
              chefData.deleted);
          await DataBaseController(uid: chefData.uid)
              .deleteTransaction(transaction.uid);
          await DataBaseController(uid: transaction.workerId)
              .deleteWorkersTransaction(transaction.uid);
          transactionsController.loading(false);
          Navigator.of(context).pop();
        });
  }
}

String title(TR transaction) {
  if (transaction.name == '') {
    return 'Supprimer la transaction';
  } else {
    return 'Ajouter une transaction';
  }
}

void affectDropDownValueToTransactionController(
    TransactionsController transactionsController,
    List<Workerr> list,
    dynamic val) {
  for (int i = 0; i < list.length; i++) {
    if (list[i].name == val) {
      transactionsController.selectedWorker.name = val;
      transactionsController.selectedWorker.uid = list[i].uid;
    }
  }
}
