import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:selly/bloc/show_fidelity_bloc.dart';

Widget categories() => BlocBuilder<ShowFidelityBloc, ShowFidelityBlocState>(
        builder: (context, state) {
      final bool show = (state as ShowFidelityBlocStateValue).showFidelity;
      return Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(vertical: show ? 65.0 : 35.0),
        height: 50.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            GFButton(
              onPressed: () {},
              text: "Caffé in polvere",
              shape: GFButtonShape.pills,
              type: GFButtonType.outline2x,
            ),
            SizedBox(
              width: 5,
            ),
            GFButton(
              onPressed: () {},
              text: "Caffé in grani",
              shape: GFButtonShape.pills,
              color: Colors.orange,
            ),
            SizedBox(
              width: 5,
            ),
            GFButton(
              onPressed: null,
              text: "Cialde",
              shape: GFButtonShape.pills,
            ),
            SizedBox(
              width: 5,
            ),
            GFButton(
              onPressed: () {},
              text: "Capsule",
              shape: GFButtonShape.pills,
            ),
            SizedBox(
              width: 5,
            ),
            GFButton(
              onPressed: () {},
              text: "Zucchero",
              shape: GFButtonShape.pills,
            ),
            SizedBox(
              width: 5,
            ),
            GFButton(
              onPressed: () {},
              text: "Accessori",
              shape: GFButtonShape.pills,
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      );
    });
