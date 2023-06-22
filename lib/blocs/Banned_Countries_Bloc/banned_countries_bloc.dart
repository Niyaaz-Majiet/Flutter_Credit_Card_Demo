import 'dart:async';
import 'package:credit_card_validator_flutter/blocs/Banned_Countries_Bloc/banned_countries_event.dart';
import 'package:credit_card_validator_flutter/blocs/Banned_Countries_Bloc/banned_countries_state.dart';
import 'package:credit_card_validator_flutter/models/Country.dart';
import 'package:credit_card_validator_flutter/repositories/banned_countries_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannedCountriesBloc
    extends Bloc<BannedCountriesEvent, BannedCountriesState> {
  final _banedCountriesRepo = BannedCountriesRepoImp();
  List<Country> data = [];

  BannedCountriesBloc() : super((BannedCountriesInitial())) {
    on<FetchAllBannedCountriesEvent>(_fetchBannedCountriesList);
    on<AddBannedCountryEvent>(_addBannedCountry);
    on<RemoveBannedCountryEvent>(_removeBannedCountry);
  }

  FutureOr<void> _removeBannedCountry(
      BannedCountriesEvent event, Emitter<BannedCountriesState> emit) async {
    if (event is RemoveBannedCountryEvent) {
      emit(BannedCountriesLoading());

      try {
        await _banedCountriesRepo.removeBannedCountry(event.index);
        List<Country> dataFromStorage =
            await _banedCountriesRepo.getAllBannedCountriesData();
        data = dataFromStorage;

        emit(BannedCountriesLoaded(data));
      } catch (e) {
        emit(BannedCountriesError('Error adding data to repo.'));
      }
    }
  }

  FutureOr<void> _addBannedCountry(
      BannedCountriesEvent event, Emitter<BannedCountriesState> emit) async {
    if (event is AddBannedCountryEvent) {
      emit(BannedCountriesLoading());

      try {
        _banedCountriesRepo.addBannedCountry(event.item);
        data.add(event.item);
        emit(BannedCountriesLoaded(data));
      } catch (e) {
        emit(BannedCountriesError('Error adding data to repo.'));
      }
    }
  }

  FutureOr<dynamic> _fetchBannedCountriesList(
      BannedCountriesEvent event, Emitter<BannedCountriesState> emit) async {
    if (event is FetchAllBannedCountriesEvent) {
      emit(BannedCountriesLoading());

      try {
        List<Country> dataFromStorage =
            await _banedCountriesRepo.getAllBannedCountriesData();
        data = dataFromStorage;

        emit(BannedCountriesLoaded(data));
      } catch (e) {
        emit(BannedCountriesError('Error fetching data from repo.'));
      }
    }
  }
}
