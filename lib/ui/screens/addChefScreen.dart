import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/ui/screens/loadingScreen.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddChefScreen extends StatefulWidget {
  @override
  _AddChefScreenState createState() => _AddChefScreenState();
}

class _AddChefScreenState extends State<AddChefScreen> {
  final _auth = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController email = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController money = new TextEditingController();

  String error = '';

  @override
  void initState() {
    error = '';
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    password.dispose();
    phoneNumber.dispose();
    money.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return error == ''
        ? loading
            ? Center(
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.7,
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(

                decoration: BoxDecoration(
                 // color: secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ajouter un chef',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: textinputDecoration.copyWith(
                          hintText: 'Nom',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: primaryColor,
                          ),
                        ),
                        controller: name,
                        validator: (val) =>
                            val.isEmpty ? 'Entrer un nom' : null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: textinputDecoration.copyWith(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: primaryColor,
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Entrer un email' : null,
                        controller: email,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: textinputDecoration.copyWith(
                          hintText: 'Mot de passe',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: primaryColor,
                          ),
                        ),
                        validator: (val) => val.length < 6
                            ? 'Entrer un mot de passe 6+ caracteres'
                            : null,
                        controller: password,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: textinputDecoration.copyWith(
                          hintText: 'Numero de telephone',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: primaryColor,
                          ),
                        ),
                        validator: (val) => val.isEmpty
                            ? 'Entrer Un numero de telephone'
                            : null,
                        controller: phoneNumber,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: textinputDecoration.copyWith(
                          hintText: 'Argent',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Entrer une somme d\'argent ' : null,
                        controller: money,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Container(
                          width: size.width * 0.6,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                            child: Text(
                              'Ajouter',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email.text,
                                        password.text,
                                        name.text,
                                        phoneNumber.text,
                                        double.parse(money.text));

                                if (result is String) {
                                  setState(() {
                                    error = result;
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                                setState(() => loading = false);
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
        : Container(
            height: size.height * 0.5,
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: Text(
                          'Essayer à nouveau',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          setState(() {
                            error = '';
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
