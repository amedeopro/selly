import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/fidelity_points_bloc.dart';
import 'package:selly/bloc/show_fidelity_bloc.dart';
import 'package:selly/components/show_fidelity_button.dart';

Widget floatingFidelity(context, username) =>
    BlocBuilder<FidelityPointsBloc, FidelityPointsBlocState>(
        builder: (context, state) {
      final double total = (state as FidelityPointsBlocStateValue).points;

      return BlocBuilder<ShowFidelityBloc, ShowFidelityBlocState>(
          builder: (context, state) {
        final bool show = (state as ShowFidelityBlocStateValue).showFidelity;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow.shade700,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                ),
                title: Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                subtitle: Text(
                  "Accumula punti con i tuoi acquisti",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
                trailing: Text(
                  total.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                )),
          ),
        );
      });
    });
