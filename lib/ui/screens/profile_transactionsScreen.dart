
import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:flutter/material.dart';

class Profile_Transactions extends StatefulWidget {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final double money;
  final bool deleted;
  final String pic;

  Profile_Transactions(
      {this.uid,
        this.name,
        this.email,
        this.phoneNumber,
        this.money,
        this.deleted,
        this.pic});


  @override
  _Profile_TransactionsState createState() => _Profile_TransactionsState();
}

class _Profile_TransactionsState extends State<Profile_Transactions> {
  int _selectedindex;


  @override
  void initState() {
    _selectedindex = 0;
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Profile(
        uid: this.widget.uid,
        name: this.widget.name,
        email: this.widget.email,
        phoneNumber: this.widget.phoneNumber,
        money: this.widget.money,
        deleted: this.widget.deleted,
        pic: this.widget.pic,
      ),
      Transactions(uid: this.widget.uid,
        name: this.widget.name,
        email: this.widget.email,
        phoneNumber: this.widget.phoneNumber,
        money: this.widget.money,
        deleted: this.widget.deleted,
      ),
    ];

    return Scaffold(

        body: Center(
          child: _widgetOptions.elementAt(_selectedindex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline,color: _selectedindex == 0 ? primaryColor : Colors.grey,),
              title: Text('Profile',style: TextStyle(color:  _selectedindex == 0 ? primaryColor : Colors.grey,),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cached,color:  _selectedindex == 1 ? primaryColor : Colors.grey,),
              title: Text('Transactions',style: TextStyle(color:  _selectedindex == 1 ? primaryColor : Colors.grey,),),
            ),
          ],
          currentIndex: _selectedindex,
          onTap: (value) {
            setState(() {
              _selectedindex = value;
            });
          },
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
        ));
  }
}
