import 'package:covid_19/view/world_casses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String title, image;
  int totalCases,
      totalDeaths,
      todayRecovered,
      active,
      critical,
      test,
      recovered;
  DetailsScreen(
      {Key? key,
      required this.title,
      required this.totalCases,
      required this.totalDeaths,
      required this.active,
      required this.critical,
      required this.test,
      required this.recovered,
      required this.todayRecovered,
      required this.image})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.086),
                      ReusableRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(
                          title: 'Recovered',
                          value: widget.recovered.toString()),
                      ReusableRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: 'Active', value: widget.active.toString()),
                      ReusableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(
                          title: 'Total Recovered',
                          value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
