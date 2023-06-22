import 'dart:async';

import 'package:credit_card_validator_flutter/blocs/Credit_Card_Bloc/credit_card_event.dart';
import 'package:credit_card_validator_flutter/blocs/Credit_Card_Bloc/credit_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Card.dart';
import '../../repositories/credit_card_repo_imp.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  final _creditCardRepo = CreditCardRepoImp();
  List<CardItem> data = [];

  CreditCardBloc() : super((CreditCardDataInitial())) {
    on<FetchAllCreditCardDataEvent>(_fetchCreditCardList);
    on<AddCreditCardDataEvent>(_addCreditCard);
    on<RemoveCreditCardDataEvent>(_removeCreditCard);
  }

  FutureOr<void> _removeCreditCard(
      CreditCardEvent event, Emitter<CreditCardState> emit) async {
    if (event is RemoveCreditCardDataEvent) {
      try {
        await _creditCardRepo.removeCreditCardData(event.index);
        List<CardItem> dataFromStorage =
            await _creditCardRepo.getAllCreditCardData();
        data = dataFromStorage;

        emit(CreditCardDataLoaded(data));
      } catch (e) {
        emit(CreditCardDataError('Error adding data to repo.'));
      }
    }
  }

  FutureOr<void> _addCreditCard(
      CreditCardEvent event, Emitter<CreditCardState> emit) async {
    if (event is AddCreditCardDataEvent) {
      try {
        _creditCardRepo.addCreditCardData(event.item);
        data.add(event.item);
        emit(CreditCardDataLoaded(data));
      } catch (e) {
        emit(CreditCardDataError('Error adding data to repo.'));
      }
    }
  }

  FutureOr<void> _fetchCreditCardList(
      CreditCardEvent event, Emitter<CreditCardState> emit) async {
    if (event is FetchAllCreditCardDataEvent) {
      emit(CreditCardDataLoading());

      try {
        List<CardItem> dataFromStorage =
            await _creditCardRepo.getAllCreditCardData();
        data = dataFromStorage;

        emit(CreditCardDataLoaded(data));
      } catch (e) {
        emit(CreditCardDataError('Error fetching data from repo.'));
      }
    }
  }
}
