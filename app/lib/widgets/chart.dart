import 'package:app/models/chart_model.dart';
import 'package:app/models/transacion_model.dart';
import 'package:app/widgets/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Chart component - Componente
/// de renderização das ultimas transações
/// da semana com base no dia atual.
///
/// @author Rodrigo Andrade
/// @since 25/05/2021
class Chart extends StatelessWidget {
  final List<TransactionModel> transactions;

  Chart(this.transactions);

  /// Agrupa as transacoes com base no dia atual
  ///
  /// @return Lista de ChartModel
  List<ChartModel> get _groupedTransactions {
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(Duration(
        days: index,
      ));

      final String dateInWeek = DateFormat.E().format(weekDay)[0].toUpperCase();
      double totalInThisDay = transactions
          .where((transaction) {
            bool equalsDay = transaction.date.day == weekDay.day;
            bool equalsMonth = transaction.date.month == weekDay.month;
            bool equalsYear = transaction.date.year == weekDay.year;

            return equalsDay && equalsMonth && equalsYear;
          })
          .fold(0, (value, transaction) => value + transaction.value);

      return ChartModel(weekDay: dateInWeek, value: totalInThisDay);
    }).reversed.toList();
  }

  /// Calcula o total gasto na semana
  ///
  /// @return double value or zero
  double get _weekTotal => transactions.fold(
      0, (previousValue, element) => previousValue + element.value);

  /// Retorna a porcentagem gasta no dia com base no total.
  double _percentage(double value) {
    return value == 0 && _weekTotal == 0 ? 0 : value / _weekTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: _groupedTransactions
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      value: e.value,
                      weekDay: e.weekDay,
                      percent: _percentage(e.value),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
