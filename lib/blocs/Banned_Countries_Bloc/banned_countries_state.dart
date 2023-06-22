import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/Country.dart';

@immutable
abstract class BannedCountriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BannedCountriesInitial extends BannedCountriesState {}

class BannedCountriesLoading extends BannedCountriesState {}

class BannedCountriesLoaded extends BannedCountriesState {
  late final List<Country> data;

  BannedCountriesLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class BannedCountriesError extends BannedCountriesState {
  late final String errorMessage;

  BannedCountriesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
