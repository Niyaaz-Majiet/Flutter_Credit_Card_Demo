import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/Card.dart';

@immutable
abstract class CreditCardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreditCardDataInitial extends CreditCardState {}

class CreditCardDataLoading extends CreditCardState {}

class CreditCardDataLoaded extends CreditCardState {
  late final List<CardItem> data;

  CreditCardDataLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class CreditCardDataError extends CreditCardState {
  String errorMessage;

  CreditCardDataError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
