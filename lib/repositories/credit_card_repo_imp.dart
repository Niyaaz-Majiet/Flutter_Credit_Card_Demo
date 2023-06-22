import 'dart:convert';

import '../Services/shared_preferences_service.dart';
import '../models/Card.dart';
import 'classes/credit_card_repo.dart';

class CreditCardRepoImp extends CreditCardRepo {
  @override
  Future<dynamic> getAllCreditCardData() async {
    try {
      var creditCardDataAsString = await SharedPref.getItem(CARDS);
      if (creditCardDataAsString.length < 1) {
        creditCardDataAsString = '[]';
      }

      List<CardItem> list = List.from(json
          .decode(creditCardDataAsString!)
          .map((data) => CardItem.fromJson(data)));

      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<dynamic> addCreditCardData(CardItem item) async {
    try {
      var list = await getAllCreditCardData();
      list.add(item);

      var newData = jsonEncode(list);

      var isSet = await SharedPref.setItem(CARDS, newData);

      return isSet;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<dynamic> removeCreditCardData(int index) async {
    try {
      var list = await getAllCreditCardData();
      list.removeAt(index);

      var newData = jsonEncode(list);

      var isSet = await SharedPref.setItem(CARDS, newData);

      return isSet;
    } catch (e) {
      return false;
    }
  }
}
