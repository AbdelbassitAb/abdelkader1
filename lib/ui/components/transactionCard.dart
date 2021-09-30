import 'package:abdelkader1/constants/colors.dart';
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
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              data.name == ''
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.name.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            data.chantier,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
              data.type == ''
                  ? SizedBox()
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Type : ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    '${data.type}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              data.workerId == ''
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Travailleur : ',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          '${data.workerName}',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
              data.workerId == ''
                  ? SizedBox()
                  : SizedBox(
                      height: 5,
                    ),
              Text(
                data.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      double.parse(data.somme.toString()).toString() + ' Da',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      data.time,
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
