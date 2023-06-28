import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/fidelity_points_bloc.dart';
import 'package:selly/bloc/show_fidelity_bloc.dart';

Widget floatingFidelity(context, username) =>
    BlocBuilder<FidelityPointsBloc, FidelityPointsBlocState>(
        builder: (context, state) {
      final double total = (state as FidelityPointsBlocStateValue).points;

      return Positioned(
        left: 10,
        right: 10,
        top: 0,
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<ShowFidelityBloc>(context)
                .add(ShowFidelityBlocEventToggle(false));
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.orange,
                  Colors.red,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/300"),
                ),
                title: Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "Accumula punti con i tuoi acquisti",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  total.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
      );
    });
