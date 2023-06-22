import 'dart:async';
import 'package:credit_card_validator/credit_card_validator.dart';

class CardValidation {
  static Future<dynamic> validateCardNumber(cardNumber) async {
    CreditCardValidator ccValidator = CreditCardValidator();

    try {
      var ccNumResults = ccValidator.validateCCNum(cardNumber);
      return ccNumResults;
    } catch (e) {
      return false;
    }
  }
}
