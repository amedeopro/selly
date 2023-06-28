import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/components/appbar.dart';

import '../bloc/fidelity_points_bloc.dart';
import '../components/drawer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int generateIncreasingRandomNumber(int startValue, int minIncrement) {
    final randomGenerator = Random();
    int currentValue = startValue;

    currentValue += randomGenerator.nextInt(minIncrement + 1);

    return currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: 'Catalogo premi',
          subtitle: "",
          iconBack: true,
          scaffoldKey: null,
          scf_context: context,
          return_to_home: true),
      drawer: drawer(context),
      body: BlocBuilder<FidelityPointsBloc, FidelityPointsBlocState>(
          builder: (context, state) {
        final double totalPoints =
            (state as FidelityPointsBlocStateValue).points;

        return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
                thickness: 1.0,
                height: 0.0,
              );
            },
            itemCount: 15,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Image.network(
                    'https://picsum.photos/id/$index/200/300',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Premio $index'),
                subtitle: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    StepProgressIndicator(
                      totalSteps: generateIncreasingRandomNumber(100, 100),
                      currentStep: generateIncreasingRandomNumber(0, 85),
                      size: 20,
                      padding: 0,
                      selectedColor: Colors.yellow,
                      unselectedColor: Colors.cyan,
                      roundedEdges: Radius.circular(10),
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.yellowAccent, Colors.deepOrange],
                      ),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.black, Colors.blue],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Ti mancano ${generateIncreasingRandomNumber(100, 100) - totalPoints.toInt()} punti')
                  ],
                ),
              );
            });
      }),
    );
  }
}
