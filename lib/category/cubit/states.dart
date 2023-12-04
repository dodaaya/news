import 'package:news/model/SourceResponse.dart';

abstract class SrcState {}

class SrcInitialState extends SrcState {}

class SrcLoadState extends SrcState {}

class SrcErrorState extends SrcState {
  String? errmsg;

  SrcErrorState({required this.errmsg});
}

class SrcSuccessState extends SrcState {
  List<Source>? sourceList;

  SrcSuccessState({required this.sourceList});
}
