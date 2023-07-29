import 'dart:convert';

import 'package:covid_19/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../Model/world_states_model.dart';

class StatesServices {
  Future<AllClassesModel> getState() async {
    final response = await http.get(Uri.parse(AppUrl.worldUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return AllClassesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> getCountries() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countryUrl));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
