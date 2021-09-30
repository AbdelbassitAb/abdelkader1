import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transactions extends StatefulWidget {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final double money;
  final bool deleted;

  Transactions({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.money,
    this.deleted,
  });

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final TransactionsController transactionsController =
      Get.put(TransactionsController());
  ChefData chefData = ChefData();

  @override
  void initState() {
    print(this.widget.uid);

    chefData = ChefData(
        uid: this.widget.uid,
        argent: this.widget.money,
        name: this.widget.name,
        email: this.widget.email,
        numTlf: this.widget.phoneNumber,
        deleted: this.widget.deleted);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Transactions'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<List<TR>>(
          stream: DataBaseController(uid: this.widget.uid).transactions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('Pas de transaction trouvé'),
                );
              } else {
                snapshot.data.sort((a, b) {
                  return b.time.compareTo(a.time);
                });
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () async {
                         //showMyDialog(snapshot.data[index], context, chefData);
                          transactionsController.loading(false);
                          await showModalBottomSheet<dynamic>(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                          return Container(
                          decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0))),
                          child: Wrap(children: [AddTransaction(transaction: snapshot.data[index],context: context,chefData: chefData,)]),
                          );
                          });
                        },
                        child: Transaction_Card(data: snapshot.data[index]));
                  },
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        onPressed: ()async {


            await showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0))),
                    child: Wrap(children: [AddTransaction(transaction: TR(somme: 0, argent: this.widget.money),context: context,chefData: chefData,)]),
                  );
                });

         /* showMyDialog(
              TR(somme: 0, argent: this.widget.money), context, chefData);*/
        },
      ),
    );
  }
}
