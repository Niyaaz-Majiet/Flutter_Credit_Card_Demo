import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

import '../../models/Country.dart';

@immutable
abstract class BannedCountriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllBannedCountriesEvent extends BannedCountriesEvent {}

class AddBannedCountryEvent extends BannedCountriesEvent {
  late final Country item;

  AddBannedCountryEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveBannedCountryEvent extends BannedCountriesEvent {
  late final int index;

  RemoveBannedCountryEvent(this.index);

  @override
  List<Object?> get props => [index];
}
