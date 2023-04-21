import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/model/category_model.dart';
import 'package:selly/resources/api_repository.dart';

class CategoriesBloc extends Bloc<CategoriesBlocEvent, CategoriesBlocState> {
  CategoriesBloc() : super(CategoriesBlocStateLoading()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<CategoriesBlocEventInit>((event, emit) async {
      try {
        emit(CategoriesBlocStateLoading());
        await Future.delayed(const Duration(seconds: 2));
        final categoriesList = await _apiRepository.fetchCategoryList();
        emit(CategoriesBlocStateLoaded(categoriesList as List<CategoryModel>));
      } catch (e) {
        print(e);
        return;
      }
    });
  }
}

abstract class CategoriesBlocEvent {}

class CategoriesBlocEventInit extends CategoriesBlocEvent {}

class CategoriesBlocEventProductDelete extends CategoriesBlocEvent {}

abstract class CategoriesBlocState {}

class CategoriesBlocStateLoading extends CategoriesBlocState {}

class CategoriesBlocStateLoaded extends CategoriesBlocState {
  List<CategoryModel> categories;
  CategoriesBlocStateLoaded(this.categories);
}
