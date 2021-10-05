import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/ui/screens/statistics.dart';
import 'package:abdelkader1/ui/screens/screens.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: double.infinity,
          color: primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Text(
                  'A',
                  style: TextStyle(fontSize: 50, color: primaryColor),
                ),
                backgroundColor: Colors.white,
                radius: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Abdelkader Belabdi',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        DrawerCard(
          text: 'Home',
          icon: Icon(
            Icons.home,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        DrawerCard(
          text: 'Travailleurs',
          icon: Icon(
            Icons.people,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Workers()));
          },
        ),
        DrawerCard(
          text: 'Chefs chantier',
          icon: Icon(
            Icons.groups,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Users()));
          },
        ),
        DrawerCard(
          text: 'Achat materiaux',
          icon: Icon(
            Icons.construction,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AchatMateriaux()));
          },
        ),
        DrawerCard(
          text: 'Gaz',
          icon: Icon(
            Icons.car_repair,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Gaz()));
          },
        ),
        DrawerCard(
          text: 'Nouriture',
          icon: Icon(
            Icons.fastfood,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Nouriture()));
          },
        ),
        DrawerCard(
          text: 'Payement',
          icon: Icon(
            Icons.money,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Payement()));
          },
        ),
        DrawerCard(
          text: 'Chantiers',
          icon: Icon(
            Icons.place,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Chantiers()));
          },
        ),
        DrawerCard(
          text: 'Statistics',
          icon: Icon(
            Icons.query_stats,
            color: primaryColor,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ],
    ));
  }
}

class DrawerCard extends StatelessWidget {
  final Function onTap;
  final Icon icon;
  final String text;

  const DrawerCard({
    this.onTap,
    this.icon,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: icon,
        title: Text(text),
      ),
    );
  }
}
