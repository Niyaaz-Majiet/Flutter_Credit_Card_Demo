import 'package:credit_card_validator_flutter/blocs/Banned_Countries_Bloc/banned_countries_bloc.dart';
import 'package:credit_card_validator_flutter/blocs/Banned_Countries_Bloc/banned_countries_event.dart';
import 'package:credit_card_validator_flutter/blocs/Banned_Countries_Bloc/banned_countries_state.dart';
import 'package:credit_card_validator_flutter/models/Country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/routes.dart';
import '../../widgets/Menu/menu.dart';

class BannedCountries extends StatefulWidget {
  final String title;

  const BannedCountries({super.key, required this.title});

  @override
  State<BannedCountries> createState() => _BannedCountriesState();
}

class _BannedCountriesState extends State<BannedCountries> {
  BannedCountriesBloc? _bannedCountriesBloc;
  List<Country> data = [];

  void _goToAddBannedCountries(context) {
    Navigator.pushNamed(context, addBannedCountriesRoute);
  }

  @override
  void initState() {
    _bannedCountriesBloc = BlocProvider.of(context);
    _bannedCountriesBloc?.add(FetchAllBannedCountriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body: BlocBuilder<BannedCountriesBloc, BannedCountriesState>(
          builder: (context, state) {
        if (state is BannedCountriesLoading) {
          return const Text('Loading');
        } else if (state is BannedCountriesLoaded) {
          data = state.data;

          if (data.isEmpty) {
            return const Center(child: Text('No Banned Countries Saved'));
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];

                return ListTile(
                    trailing: const Icon(Icons.delete),
                    title: Text(item.name),
                  onTap: () {
                    _bannedCountriesBloc?.add(RemoveBannedCountryEvent(index));
                  },
                );
              },
            );
          }
        } else if (state is BannedCountriesError) {
          return Text(state.errorMessage);
        } else {
          return const Text('Unable to load data');
        }
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _goToAddBannedCountries(context),
          tooltip: 'Add Banned Countries',
          child: const Icon(Icons.add)),
    );
  }
}
