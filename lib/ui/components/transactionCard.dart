import 'package:abdelkader1/models/models.dart';
import 'package:flutter/material.dart';

class Transaction_Card extends StatelessWidget {
  final TR data;

  Transaction_Card({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.name.toString(),style: TextStyle(color: Colors.grey,fontSize: 16),),
                    Text(
                      data.chantier,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),




              Text(
                '${data.type}',
                style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
              ) ,

              data.workerId == '' ?
              SizedBox() : Text(
                'Travailleur:${data.workerName}',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ) ,



              SizedBox(
                height: 5,
              ),

              Text(
                data.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),


              Padding(
                padding:
                const EdgeInsets.symmetric( horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(double.parse(data.somme.toString()).toString() + ' Da',style: TextStyle(color: Colors.grey,fontSize: 16),),
                    Text(
                      data.time,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}