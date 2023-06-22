import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Country.dart';

Future<List<Country>> getAllCountries() async {
  final response =
      await http.get(Uri.parse('http://restcountries.com/v3.1/all'));
  List<Country> countries = [];

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body) as List<dynamic>;

    for (var country in data) {
      countries.add(Country(
          flagUrl: country['flags']['png'],
          name: country['name']['official'],
          code: country['cca3']));
    }

    return countries;
  } else {
    throw Exception('Failed to load album');
  }
}
