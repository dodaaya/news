import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/category/cubit/states.dart';

class CategoryBlocVM extends Cubit<SrcState> {
  CategoryBlocVM() : super(SrcInitialState());

  void getSourceByCategoryId(String categoryId) async {
    try {
      emit(SrcLoadState());
      var response = await ApiManager.getSources(categoryId);
      if (response?.status == 'error') {
        emit(SrcErrorState(errmsg: response!.message));
      } else {
        emit(SrcSuccessState(sourceList: response?.sources));
      }
    } catch (e) {
      emit(SrcErrorState(errmsg: 'error loading srclist'));
    }
  }
}
