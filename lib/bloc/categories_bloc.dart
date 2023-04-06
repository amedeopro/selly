import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/model/category_model.dart';

class CategoriesBloc extends Bloc<CategoriesBlocEvent, CategoriesBlocState> {
  CategoriesBloc() : super(CategoriesBlocStateLoading()) {
    on<CategoriesBlocEventInit>((event, emit) async {
      emit(CategoriesBlocStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(CategoriesBlocStateLoaded(categoriesList));
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
