import 'package:covid_19/Model/world_states_model.dart';
import 'package:covid_19/Services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'counries_list.dart';

class WorldCasses extends StatefulWidget {
  const WorldCasses({Key? key}) : super(key: key);

  @override
  State<WorldCasses> createState() => _WorldCassesState();
}

class _WorldCassesState extends State<WorldCasses>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices services = StatesServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid-19 Updates'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            FutureBuilder(
              future: services.getState(),
              builder: (context, AsyncSnapshot<AllClassesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: controller,
                      ));
                } else {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      PieChart(
                        dataMap: {
                          'Total':
                              double.parse(snapshot!.data!.cases.toString()),
                          'Recover': double.parse(
                              snapshot!.data!.recovered.toString()),
                          'Deaths':
                              double.parse(snapshot!.data!.deaths.toString())
                        },
                        animationDuration: const Duration(microseconds: 1200),
                        chartType: ChartType.ring,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: colorList,
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                      ),
                      SizedBox(height: 20),
                      Card(
                        child: Column(
                          children: [
                            ReusableRow(
                                title: 'Total',
                                value: snapshot.data!.cases.toString()),
                            ReusableRow(
                                title: 'Death',
                                value: snapshot.data!.deaths.toString()),
                            ReusableRow(
                                title: 'Recovered',
                                value: snapshot.data!.recovered.toString()),
                            ReusableRow(
                                title: 'Active',
                                value: snapshot.data!.active.toString()),
                            ReusableRow(
                                title: 'Critical',
                                value: snapshot.data!.critical.toString()),
                            ReusableRow(
                                title: 'Today Death',
                                value: snapshot.data!.todayDeaths.toString()),
                            ReusableRow(
                                title: 'Today Recovered',
                                value: snapshot.data!.todayRecovered.toString())
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesList(),
                              ));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider()
        ],
      ),
    );
  }
}
