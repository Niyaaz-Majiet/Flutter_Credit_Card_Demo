import 'package:credit_card_validator_flutter/blocs/Banned_Countries_Bloc/banned_countries_bloc.dart';
import 'package:credit_card_validator_flutter/models/Country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Services/countries_service.dart';
import '../../../blocs/Banned_Countries_Bloc/banned_countries_event.dart';
import '../../../repositories/banned_countries_repo_imp.dart';
import '../../../routes/routes.dart';

class AddBannedCountries extends StatefulWidget {
  final String title;

  const AddBannedCountries({super.key, required this.title});

  @override
  State<AddBannedCountries> createState() => _AddBannedCountriesState();
}

class _AddBannedCountriesState extends State<AddBannedCountries> {
  final _banedCountriesRepo = BannedCountriesRepoImp();
  late List<Country> bannedCountries;

  BannedCountriesBloc? _bannedCountriesBloc;
  Country? dropDownValue;

  Future<List<Country>> getAllCountriesData() async {
    return await getAllCountries();
  }

  bool _checkIfCountryExist(country) {
    var filterListByBannedCountry = bannedCountries.where((element) =>
        element.name.toUpperCase().trim() ==
        country.toString().toUpperCase().trim());

    if (filterListByBannedCountry.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void _addToBanned(context) {
    if (dropDownValue != null) {
      var doesCountryExist = _checkIfCountryExist(dropDownValue?.name);

      if (doesCountryExist) {
        _showSnackBar(context, 'Country already added to banned list');
      } else {
        _bannedCountriesBloc?.add(AddBannedCountryEvent(dropDownValue!));

        _showSnackBar(
            context, '${dropDownValue?.name} added to banned countries list.');
        setState(() {
          dropDownValue = null;
        });

        Navigator.pushNamed(context, bannedCountriesRoute);
      }
    } else {
      _showSnackBar(context, 'Please select an option from the dropdown.');
    }
  }

  void getData() async {
    bannedCountries = await _banedCountriesRepo.getAllBannedCountriesData();
  }

  void _showSnackBar(context, message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    _bannedCountriesBloc = BlocProvider.of(context);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: getAllCountriesData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: const BoxDecoration(
                      color: Colors.white60,
                    ),
                    child: DropdownButton(
                      hint: const Text('Pick country here ...'),
                      isExpanded: true,
                      value: dropDownValue,
                      elevation: 5,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: data.map((Country items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items.name),
                        );
                      }).toList(),
                      onChanged: (Country? value) {
                        setState(() {
                          dropDownValue = value;
                        });
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _addToBanned(context),
          tooltip: 'Go To Banned Countries',
          child: const Icon(Icons.add)),
    );
  }
}
