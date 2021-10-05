import 'dart:math';

import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/Transaction.dart';
import 'package:abdelkader1/models/chantier.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Task, String>> _seriesPieData2;

  double totalType = 0;
  double totalChantier = 0;

  var data1 = [
    new Pollution(1980, 'USA', 30),
    new Pollution(1980, 'Asia', 40),
    new Pollution(1980, 'Europe', 10),
  ];
  var data2 = [
    new Pollution(1985, 'USA', 100),
    new Pollution(1980, 'Asia', 150),
    new Pollution(1985, 'Europe', 80),
  ];
  var data3 = [
    new Pollution(1985, 'USA', 200),
    new Pollution(1980, 'Asia', 200),
    new Pollution(1985, 'Europe', 180),
  ];

  var piedata = [
    new Task('Achat materiaux', 0.0, Color(0xff3366cc)),
    new Task('Gaz', 0.0, Color(0xff990099)),
    new Task('Nouriture', 0.0, Color(0xff109618)),
    new Task('Payement', 0.0, Color(0xfffdbe19)),
  ];

  List<Task> piedata2 = [];

  _generateData() {
    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => -task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'id',
        data: piedata,
        labelAccessorFn: (Task row, _) => '-${row.taskvalue}',
      ),
    );

    _seriesPieData2.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => -task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'id2',
        data: piedata2,
        labelAccessorFn: (Task row, _) => '-${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesPieData2 = List<charts.Series<Task, String>>();
    piedata2 = [];
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: MainDrawer(),
          appBar: AppBar(
            backgroundColor: primaryColor,
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [

                Tab(icon: Icon(FontAwesomeIcons.chartPie,),text: 'Types',),
                Tab(icon: Icon(FontAwesomeIcons.chartPie),text: 'Chantier',),
              ],
            ),
            centerTitle: true,
            title: Text('Statistics'),
          ),
          body: TabBarView(
            children: [

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                      child: StreamBuilder<List<TR>>(
                          stream: DataBaseController().allTransactions,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (!(piedata[0].taskvalue != 0 ||
                                  piedata[1].taskvalue != 0 ||
                                  piedata[2].taskvalue != 0 ||
                                  piedata[3].taskvalue != 0)) {
                                for (TR element in snapshot.data) {
                                  if (element.type == 'Achat materiaux')
                                    piedata[0].taskvalue += element.somme;
                                  if (element.type == 'Gaz')
                                    piedata[1].taskvalue += element.somme;
                                  if (element.type == 'Nouriture')
                                    piedata[2].taskvalue += element.somme;
                                  if (element.type == 'Payement')
                                    piedata[3].taskvalue += element.somme;
                                  if (element.type != '')
                                    totalType += element.somme;
                                }
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Statistics des depenses par type',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Totales:  $totalType  Da',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: charts.PieChart(_seriesPieData,
                                        animate: true,
                                        animationDuration: Duration(seconds: 1),
                                        behaviors: [
                                          new charts.DatumLegend(
                                            outsideJustification: charts
                                                .OutsideJustification
                                                .startDrawArea,
                                            horizontalFirst: false,
                                            desiredMaxRows: 2,
                                            cellPadding: new EdgeInsets.only(
                                                left: 4.0, bottom: 4.0),
                                            entryTextStyle:
                                                charts.TextStyleSpec(
                                                    color: charts
                                                        .MaterialPalette.black,
                                                    fontSize: 14),
                                          )
                                        ],
                                        defaultRenderer:
                                            new charts.ArcRendererConfig(
                                                arcWidth: 100,
                                                arcRendererDecorators: [
                                              new charts.ArcLabelDecorator(
                                                  labelPosition: charts
                                                      .ArcLabelPosition.inside)
                                            ])),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: Text('No data found'),
                              );
                            }
                          })),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                      child: StreamBuilder<List<Chantier>>(
                          stream: DataBaseController().chantiers,
                          builder: (context, snapshot1) {
                            if (snapshot1.hasData) {
                              return StreamBuilder<List<TR>>(
                                  stream: DataBaseController().allTransactions,
                                  builder: (context, snapshot) {
                                    if (piedata2.isEmpty) {
                                      for (Chantier chantier
                                          in snapshot1.data) {
                                        piedata2.add(Task(
                                            chantier.name,
                                            0.0,
                                            Colors.primaries[Random().nextInt(
                                                Colors.primaries.length)]));
                                      }
                                    }

                                    if (snapshot.hasData) {
                                      if (totalChantier == 0) {
                                        for (TR element in snapshot.data) {
                                          for (Task chantier in piedata2) {
                                            if (chantier.task ==
                                                element.chantier) {
                                              chantier.taskvalue +=
                                                  element.somme;
                                              totalChantier += element.somme;
                                            }
                                          }
                                        }
                                      }

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              'Statistics des depenses par chantier',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              'Totales:  $totalChantier  Da',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: charts.PieChart(
                                                _seriesPieData2,
                                                animate: true,
                                                animationDuration:
                                                    Duration(seconds: 1),
                                                behaviors: [
                                                  new charts.DatumLegend(
                                                    outsideJustification: charts
                                                        .OutsideJustification
                                                        .startDrawArea,
                                                    horizontalFirst: false,
                                                    desiredMaxRows: 2,
                                                    cellPadding:
                                                        new EdgeInsets.only(
                                                            left: 4.0,
                                                            bottom: 4.0),
                                                    entryTextStyle:
                                                        charts.TextStyleSpec(
                                                            color: charts
                                                                .MaterialPalette
                                                                .black,
                                                            fontSize: 14),
                                                  )
                                                ],
                                                defaultRenderer: new charts
                                                        .ArcRendererConfig(
                                                    arcWidth: 100,
                                                    arcRendererDecorators: [
                                                      new charts
                                                              .ArcLabelDecorator(
                                                          labelPosition: charts
                                                              .ArcLabelPosition
                                                              .inside)
                                                    ])),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: Text('No data found'),
                                      );
                                    }
                                  });
                            } else {
                              return Center(
                                child: Text('No data found'),
                              );
                            }
                          })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
