import 'package:app/widgets/chart.dart';
import 'package:flutter/material.dart';

/// Chart Bar é um componente que pertence ao chart
/// represetando assim a barra de  porcentagem,
/// os valores numericos e o dia da semana.
///
/// @author Rodrigo Andrade
/// @since 25/05/2021
class ChartBar extends StatelessWidget {
  final String weekDay;
  final double value;
  final double percent;

  const ChartBar({this.weekDay, this.value, this.percent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) => Column(
        children: [
          Container(
              height: contraints.maxHeight * .15,
              child: FittedBox(child: Text('${value.toStringAsFixed(2)}'))),
          SizedBox(height: contraints.maxHeight * .05),
          Container(
            width: 10,
            height: contraints.maxHeight * .6,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: contraints.maxHeight * .05),
          Container(
              height: contraints.maxHeight * .15,
              child: FittedBox(child: Text(weekDay))),
        ],
      ),
    );
  }
}
