import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

import '../../models/Card.dart';

@immutable
abstract class CreditCardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllCreditCardDataEvent extends CreditCardEvent {}

class AddCreditCardDataEvent extends CreditCardEvent {
  late final CardItem item;

  AddCreditCardDataEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveCreditCardDataEvent extends CreditCardEvent {
  late final int index;

  RemoveCreditCardDataEvent(this.index);

  @override
  List<Object?> get props => [index];
}
