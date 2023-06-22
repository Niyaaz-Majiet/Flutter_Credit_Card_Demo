import 'package:credit_card_validator_flutter/routes/routes.dart';
import 'package:credit_card_validator_flutter/routes/router.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: generateRoute,
      initialRoute: homeRoute,
    );
  }
}

// class AppBlocObserver extends BlocObserver {
//   const AppBlocObserver();
//
//   @override
//   void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
//     super.onChange(bloc, change);
//     if (bloc is Bloc) print(change);
//   }
//
//   @override
//   void onTransition(
//       Bloc<dynamic, dynamic> bloc,
//       Transition<dynamic, dynamic> transition,
//       ) {
//     super.onTransition(bloc, transition);
//     print(transition);
//   }
// }
