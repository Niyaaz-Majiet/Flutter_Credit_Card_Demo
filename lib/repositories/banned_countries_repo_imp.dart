import 'dart:async';
import 'dart:convert';

import 'package:credit_card_validator_flutter/Services/shared_preferences_service.dart';
import 'package:credit_card_validator_flutter/models/Country.dart';

import 'classes/banned_countries_repo.dart';

class BannedCountriesRepoImp extends BannedCountriesRepo {
  @override
  Future<dynamic> getAllBannedCountriesData() async {
    try {
      var bannedCountriesAsString = await SharedPref.getItem(BANNED);
      if (bannedCountriesAsString.length < 1) {
        bannedCountriesAsString = '[]';
      }

      List<Country> list = List.from(json
          .decode(bannedCountriesAsString!)
          .map((data) => Country.fromJson(data)));

      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<dynamic> addBannedCountry(Country item) async {
    try {
      var list = await getAllBannedCountriesData();
      list.add(item);

      var newData = jsonEncode(list);

      var isSet = await SharedPref.setItem(BANNED, newData);

      return isSet;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<dynamic> removeBannedCountry(int index) async {
    try {
      var list = await getAllBannedCountriesData();
      list.removeAt(index);

      var newData = jsonEncode(list);

      var isSet = await SharedPref.setItem(BANNED, newData);

      return isSet;
    } catch (e) {
      return false;
    }
  }
}
