import 'package:credit_card_validator_flutter/blocs/Credit_Card_Bloc/credit_card_bloc.dart';
import 'package:credit_card_validator_flutter/models/Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Services/card_validation_service.dart';
import '../../../blocs/Credit_Card_Bloc/credit_card_event.dart';
import '../../../models/Country.dart';
import '../../../repositories/banned_countries_repo_imp.dart';
import '../../../repositories/credit_card_repo_imp.dart';
import '../../../routes/routes.dart';

class AddCard extends StatefulWidget {
  final String title;

  const AddCard({super.key, required this.title});

  @override
  State<AddCard> createState() => _AddCard();
}

class _AddCard extends State<AddCard> {
  final _banedCountriesRepo = BannedCountriesRepoImp();
  final _creditCardRepo = CreditCardRepoImp();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  dynamic cardResponse;
  late List<Country> bannedCountries;
  late List<CardItem> cards;
  CreditCardBloc? _creditCardBloc;

  final cardNumberController = TextEditingController();
  final cardTypeController = TextEditingController();
  final cardCVVController = TextEditingController();
  final cardIssuedInController = TextEditingController();

  RegExp get _numbersOnlyRegex => RegExp('^[0-9]');

  void _checkCard(number) async {
    cardResponse = await CardValidation.validateCardNumber(number);
    if (cardResponse.ccType.type.toString().toLowerCase() != 'unknown') {
      cardTypeController.text =
          cardResponse.ccType.type.toString().toUpperCase();
    }
  }

  bool _checkIfCountryBanned() {
    String country = cardIssuedInController.text.toUpperCase();
    var filterListByBannedCountry = bannedCountries
        .where((element) => element.name.toUpperCase().contains(country));
    if (filterListByBannedCountry.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkIfCardExists(cardNumber) {
    var filterListByCardNumber = cards
        .where((element) => element.cardNumber.trim() == cardNumber.trim());
    if (filterListByCardNumber.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void _addCard(context) {
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      var isBanned = _checkIfCountryBanned();

      if (isBanned) {
        _showSnackBar(context, 'Cards from issued country has been banned');
      } else {
        if (cardResponse.isValid) {
          var doesCardExist = _checkIfCardExists(cardNumberController.text);

          if (doesCardExist) {
            _showSnackBar(context, 'Card number exists.');
          } else {
            CardItem cardData = CardItem(
                cardNumber: cardNumberController.text,
                type: cardTypeController.text,
                cvv: cardCVVController.text,
                issuedIn: cardIssuedInController.text);

            _creditCardBloc?.add(AddCreditCardDataEvent(cardData));

            _showSnackBar(context, 'Success');
            Navigator.pushNamed(context, homeRoute);
          }
        } else {
          _showSnackBar(context, 'Card number is invalid');
        }
      }
    } else {
      _showSnackBar(context, 'Invalid data');
    }
  }

  void _showSnackBar(context, message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void getData() async {
    bannedCountries = await _banedCountriesRepo.getAllBannedCountriesData();
    cards = await _creditCardRepo.getAllCreditCardData();
  }

  @override
  void initState() {
    _creditCardBloc = BlocProvider.of(context);
    getData();
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardTypeController.dispose();
    cardCVVController.dispose();
    cardIssuedInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cardNumberController,
                      decoration: const InputDecoration(labelText: 'Card Number'),
                      onChanged: (value) {
                        _checkCard(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (!_numbersOnlyRegex.hasMatch(value)) {
                          return 'Numbers only';
                        }
                        if (value.length < 8) {
                          return 'Too short.';
                        }
                        if (value.length > 19) {
                          return '19 digits allowed';
                        }
                        return null;
                      },
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cardTypeController,
                    decoration: const InputDecoration(labelText: 'Card Type'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cardCVVController,
                    decoration: const InputDecoration(labelText: 'CVV'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!_numbersOnlyRegex.hasMatch(value)) {
                        return 'Numbers only';
                      }
                      if (value.length < 3) {
                        return 'Too short.';
                      }
                      if (value.length > 4) {
                        return '4 digits allowed';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: cardIssuedInController,
                    decoration: const InputDecoration(
                        labelText: 'Issued In [Full Name of Country]'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length > 25) {
                        return 'Too Long.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _addCard(context),
          tooltip: 'Go To Banned Countries',
          child: const Icon(Icons.add)),
    );
  }
}
