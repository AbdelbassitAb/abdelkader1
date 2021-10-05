import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final double money;
  final bool deleted;
  final String pic;

  Profile(
      {this.uid,
      this.name,
      this.email,
      this.phoneNumber,
      this.money,
      this.deleted,
      this.pic});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  String errorMsg;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  var uuid = Uuid();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  String img;
  String _currentName;
  String _currentEmail;
  String _currentPhoneNumber;
  String somme;
  double _currentMoney;
  String url;

  Future<void> GetImage() async {
    final ref =
        FirebaseStorage.instance.ref().child('uploads/${this.widget.pic}');
// no need of the file extension, the name will do fine.
    var url1 = await ref.getDownloadURL();
    setState(() {
      url = url1.toString();
    });
  }

  @override
  void initState() {
    if (this.widget.pic != null) {
      GetImage();
    }
    _currentPhoneNumber = this.widget.phoneNumber;
    _currentName = this.widget.name;
    _currentEmail = this.widget.email;
    _currentMoney = this.widget.money;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<void> _deleteMsg() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Voulez vous vraiment supprimer cet utilisateur ?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Oui',style: TextStyle(color: primaryColor),),
                onPressed: () {
                  DataBaseController().updateUserData(
                      this.widget.uid,
                      this.widget.name,
                      this.widget.email,
                      this.widget.phoneNumber,
                      this.widget.money,
                      true);
                  Get.back();
                  Get.back();
                },
              ),
              TextButton(
                child: Text('Non',style: TextStyle(color: primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Entrer une somme'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey1,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: textinputDecoration,
                  validator: (val) => val.isEmpty ? 'entrer un numero' : null,
                  onChanged: (val) => setState(() => somme = val),
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
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
                  onPressed: () {
                    if (_formKey1.currentState.validate()) {
                      setState(() {
                        _currentMoney = double.parse(somme) + _currentMoney;
                      });
                      Navigator.of(context).pop();
                    }
                  }),
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'Soustraire',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _currentMoney = _currentMoney - double.parse(somme);
                      });

                      Navigator.of(context).pop();
                    }
                  })
            ],
          );
        },
      );
    }

    return StreamProvider<CollectionReference>.value(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            title: Text('Profile'),
            elevation: 0,
            centerTitle: true,
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    //DatabaseService().deleteChef(this.widget.uid);
                    _deleteMsg();
                  },
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: url != null
                      ? Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(url), fit: BoxFit.cover),
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Column(children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20,),
                            TextFormField(
                              initialValue: this.widget.name,
                              decoration: textinputDecoration.copyWith(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: primaryColor,
                                ),
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'entrer un nom' : null,
                              onChanged: (val) =>
                                  setState(() => _currentName = val),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              initialValue: this.widget.email,
                              decoration: textinputDecoration.copyWith(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: primaryColor,
                                ),
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'entrer un email' : null,
                              onChanged: (val) =>
                                  setState(() => _currentEmail = val),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: this.widget.phoneNumber,
                              decoration: textinputDecoration.copyWith(
                                prefixIcon: Icon(
                                  Icons.phone_outlined,
                                  color: primaryColor,
                                ),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'entrer un numero de telephone'
                                  : null,
                              onChanged: (val) =>
                                  setState(() => _currentPhoneNumber = val),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              //  height: 47,
                              width: size.width * 0.9,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  )),
                              child: Row(children: <Widget>[
                                Icon(
                                  Icons.attach_money,
                                  size: 25,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  _currentMoney.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '   DA',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 25,
                                      color: primaryColor,
                                    ),
                                    onPressed: _showMyDialog),
                              ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: RaisedButton(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    color: (_currentPhoneNumber !=
                                                this.widget.phoneNumber ||
                                            _currentEmail !=
                                                this.widget.email ||
                                            _currentName != this.widget.name ||
                                            _currentMoney != this.widget.money)
                                        ? primaryColor
                                        : Colors.grey,
                                    child: Text(
                                      'Modifier',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: (_currentPhoneNumber !=
                                                this.widget.phoneNumber ||
                                            _currentEmail !=
                                                this.widget.email ||
                                            _currentName != this.widget.name ||
                                            _currentMoney != this.widget.money)
                                        ? () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              await DataBaseController(
                                                      uid: this.widget.uid)
                                                  .updateUserData(
                                                      this.widget.uid,
                                                      _currentName ??
                                                          this.widget.name,
                                                      _currentEmail ??
                                                          this.widget.email,
                                                      _currentPhoneNumber ??
                                                          this
                                                              .widget
                                                              .phoneNumber,
                                                      _currentMoney ??
                                                          this.widget.money,
                                                      this.widget.deleted);

                                              if (_currentMoney <
                                                  this.widget.money) {
                                                await DataBaseController(
                                                        uid: this.widget.uid)
                                                    .updateUserTransaction(
                                                        uuid.v4(),
                                                        this.widget.name,
                                                        'Abdelkader a payé ${this.widget.name}',
                                                        dateFormat.format(
                                                            DateTime.now()),
                                                        _currentMoney ??
                                                            this.widget.money,
                                                        -double.parse(somme),
                                                        Workerr(),
                                                        false,
                                                        '',
                                                        '');
                                              }
                                              if (_currentMoney >
                                                  this.widget.money) {
                                                await DataBaseController(
                                                        uid: this.widget.uid)
                                                    .updateUserTransaction(
                                                        uuid.v4(),
                                                        this.widget.name,
                                                        'Abdelkader a payé ${this.widget.name}',
                                                        dateFormat.format(
                                                            DateTime.now()),
                                                        _currentMoney ??
                                                            this.widget.money,
                                                        double.parse(somme),
                                                        Workerr(),
                                                        false,
                                                        '',
                                                        '');
                                              }

                                              Navigator.pop(context);
                                            }
                                          }
                                        : null),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      )
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
