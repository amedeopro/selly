import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:selly/bloc/categories_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:selly/bloc/show_fidelity_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:selly/model/category_model.dart';

Widget categories() => BlocBuilder<ShowFidelityBloc, ShowFidelityBlocState>(
        builder: (context, state) {
      final bool show = (state as ShowFidelityBlocStateValue).showFidelity;
      return Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 78.0 ),
        height: 50.0,
        child: BlocBuilder<CategoriesBloc, CategoriesBlocState>(
          builder: (context, state) {
            if (state is CategoriesBlocStateLoading) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: GFButton(
                        onPressed: () {},
                        text: "",
                        shape: GFButtonShape.pills,
                        type: GFButtonType.outline2x,
                      ),
                    ),
                  );
                },
              );
            } else {
              return BlocBuilder<CategoriesBloc, CategoriesBlocState>(
                  builder: (context, state) {
                final categoriesList =
                    (state as CategoriesBlocStateLoaded).categories;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      child: GFButton(
                        onPressed: () {
                          BlocProvider.of<ShoppingCartBloc>(context).add(
                              ShoppingCartBlocEventProductChangeCategory(
                                  categoriesList[index].id));
                        },
                        text: categoriesList[index].name,
                        shape: GFButtonShape.pills,
                        type: GFButtonType.outline2x,
                      ),
                    );
                  },
                );
              });
            }
          },
        ),
      );
    });
