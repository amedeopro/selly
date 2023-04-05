import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/show_fidelity_bloc.dart';

Widget floatingFidelity(context) => Positioned(
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
            /*boxShadow: [
              BoxShadow(
                offset: Offset(1, 3),
                blurRadius: 10,
                color: Colors.grey.shade600,
              )
            ],*/
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
                    "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
              ),
              title: Text(
                "Amedeo Pro",
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
                "134",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
