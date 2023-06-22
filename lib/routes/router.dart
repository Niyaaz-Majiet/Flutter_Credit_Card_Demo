import 'package:credit_card_validator_flutter/blocs/Banned_Countries_Bloc/banned_countries_bloc.dart';
import 'package:credit_card_validator_flutter/routes/routes.dart';
import 'package:credit_card_validator_flutter/ui/pages/BannedCountries/bannedCountries.dart';
import 'package:credit_card_validator_flutter/ui/pages/NoRoute/noRoute.dart';
import 'package:credit_card_validator_flutter/ui/pages/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/Credit_Card_Bloc/credit_card_bloc.dart';
import '../ui/pages/AddBannedCountry/addBannedCountry.dart';
import '../ui/pages/AddCard/addCard.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<CreditCardBloc>.value(
          value: CreditCardBloc(),
          child: const HomePage(title: 'Credit Cards'),
        ),
      );
    case addCreditCardRoute:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<CreditCardBloc>.value(
                value: CreditCardBloc(),
                child: const AddCard(title: 'Add Credit Card'),
              ));
    case bannedCountriesRoute:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<BannedCountriesBloc>.value(
                value: BannedCountriesBloc(),
                child: const BannedCountries(title: 'Banned Countries'),
              ));
    case addBannedCountriesRoute:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<BannedCountriesBloc>.value(
                value: BannedCountriesBloc(),
                child: const AddBannedCountries(title: 'Add Banned Countries'),
              ));
    default:
      return MaterialPageRoute(
          builder: (_) => const NoRoute(title: 'No Route Defined.'));
  }
}
