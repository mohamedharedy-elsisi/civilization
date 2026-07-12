import '../../../models/museum_model.dart';
import '../../../models/obelisk_model.dart';
import '../../../models/pharaoh_model.dart';
import '../../../models/pyramid_model.dart';
import '../../../models/quote_model.dart';
import '../../../models/statue_model.dart';
import '../../../models/temple_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<QuoteModel> quotes;
  final List<PharaohModel> pharaohs;
  final List<StatueModel> statues;
  final List<TempleModel> temples;
  final List<MuseumModel> museums;
  final List<ObeliskModel> obelisks;
  final List<PyramidModel> pyramids;

  HomeLoaded({
    required this.quotes,
    required this.pharaohs,
    required this.statues,
    required this.temples,
    required this.museums,
    required this.obelisks,
    required this.pyramids,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}