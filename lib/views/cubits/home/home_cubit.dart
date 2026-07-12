import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/museum_model.dart';
import '../../../models/obelisk_model.dart';
import '../../../models/pharaoh_model.dart';
import '../../../models/pyramid_model.dart';
import '../../../models/quote_model.dart';
import '../../../models/statue_model.dart';
import '../../../models/temple_model.dart';

import '../../../repositories/museums_repository.dart';
import '../../../repositories/obelisks_repository.dart';
import '../../../repositories/pharaohs_repository.dart';
import '../../../repositories/pyramid_repository.dart';
import '../../../repositories/quotes_repository.dart';
import '../../../repositories/statues_repository.dart';
import '../../../repositories/temples_repository.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final QuotesRepository quotesRepository = QuotesRepository();
  final PharaohsRepository pharaohsRepository = PharaohsRepository();
  final StatuesRepository statuesRepository = StatuesRepository();
  final TemplesRepository templesRepository = TemplesRepository();
  final MuseumsRepository museumsRepository = MuseumsRepository();
  final ObelisksRepository obelisksRepository = ObelisksRepository();
  final PyramidsRepository pyramidsRepository = PyramidsRepository();

  Future<void> loadData() async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        quotesRepository.getQuotes(),
        pharaohsRepository.getPharaohs(),
        statuesRepository.getStatues(),
        templesRepository.getTemples(),
        museumsRepository.getMuseums(),
        obelisksRepository.getObelisks(),
        pyramidsRepository.getPyramids(),
      ]);

      final quotes = results[0] as List<QuoteModel>;
      final pharaohs = results[1] as List<PharaohModel>;
      final statues = results[2] as List<StatueModel>;
      final temples = results[3] as List<TempleModel>;
      final museums = results[4] as List<MuseumModel>;
      final obelisks = results[5] as List<ObeliskModel>;
      final pyramids = results[6] as List<PyramidModel>;

      quotes.shuffle(Random());
      pharaohs.shuffle(Random());
      statues.shuffle(Random());
      temples.shuffle(Random());
      museums.shuffle(Random());
      obelisks.shuffle(Random());
      pyramids.shuffle(Random());

      emit(
        HomeLoaded(
          quotes: quotes,
          pharaohs: pharaohs,
          statues: statues,
          temples: temples,
          museums: museums,
          obelisks: obelisks,
          pyramids: pyramids,
        ),
      );
    } catch (e) {
      emit(
        HomeError(
          e.toString(),
        ),
      );
    }
  }
}