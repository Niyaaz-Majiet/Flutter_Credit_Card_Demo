import 'package:credit_card_validator_flutter/models/Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/Credit_Card_Bloc/credit_card_bloc.dart';
import '../../../blocs/Credit_Card_Bloc/credit_card_event.dart';
import '../../../blocs/Credit_Card_Bloc/credit_card_state.dart';
import '../../../routes/routes.dart';
import '../../widgets/Menu/menu.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CreditCardBloc? _creditCardBloc;
  List<CardItem> data = [];

  void _goToAddCard(context) {
    Navigator.pushNamed(context, addCreditCardRoute);
  }

  @override
  void initState() {
    _creditCardBloc = BlocProvider.of(context);
    _creditCardBloc?.add(FetchAllCreditCardDataEvent());
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
      body: BlocBuilder<CreditCardBloc, CreditCardState>(
          builder: (context, state) {
        if (state is CreditCardDataLoading) {
          return const Text('Loading');
        } else if (state is CreditCardDataLoaded) {
          data = state.data;

          if (data.isEmpty) {
            return const Center(child: Text('No Credit Cards Saved'));
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];

                return ListTile(
                  trailing: const Icon(Icons.delete),
                  title: Text(item.cardNumber),
                  onTap: () {
                    _creditCardBloc?.add(RemoveCreditCardDataEvent(index));
                  },
                );
              },
            );
          }
        } else if (state is CreditCardDataError) {
          return Text(state.errorMessage);
        } else {
          return const Text('Unable to load data');
        }
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _goToAddCard(context),
          tooltip: 'Add Card',
          child: const Icon(Icons.add)),
    );
  }
}
