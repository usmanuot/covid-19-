import 'package:covid_19/Services/state_services.dart';
import 'package:covid_19/view/country_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  // String title;
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices services = StatesServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                    });
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with country name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          // const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: services.getCountries(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data?[index]['country'];
                        if (searchController.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailsScreen(
                                    title: snapshot.data?[index]['country'],
                                    image: snapshot.data?[index]['countryInfo']
                                        ['flag'],
                                    active: snapshot.data?[index]['active'],
                                    critical: snapshot.data?[index]['critical'],
                                    test: snapshot.data?[index]['tests'],
                                    recovered: snapshot.data?[index]
                                        ['recovered'],
                                    todayRecovered: snapshot.data?[index]
                                        ['todayRecovered'],
                                    totalCases: snapshot.data?[index]['cases'],
                                    totalDeaths: snapshot.data?[index]
                                        ['deaths'],
                                  );
                                },
                              ));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data?[index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data?[index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                                const Divider(color: Colors.white),
                              ],
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailsScreen(
                                    title: snapshot.data?[index]['country'],
                                    image: snapshot.data?[index]['countryInfo']
                                        ['flag'],
                                    active: snapshot.data?[index]['active'],
                                    critical: snapshot.data?[index]['critical'],
                                    test: snapshot.data?[index]['tests'],
                                    recovered: snapshot.data?[index]
                                        ['recovered'],
                                    todayRecovered: snapshot.data?[index]
                                        ['todayRecovered'],
                                    totalCases: snapshot.data?[index]['cases'],
                                    totalDeaths: snapshot.data?[index]
                                        ['deaths'],
                                  );
                                },
                              ));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data?[index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data?[index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                                const Divider(color: Colors.white)
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade700,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                                height: 10, width: 59, color: Colors.white),
                            subtitle: Container(
                                height: 10, width: 59, color: Colors.white),
                            leading: Container(
                                height: 50, width: 50, color: Colors.white),
                          );
                        },
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
