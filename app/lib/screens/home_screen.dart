import 'package:app/models/transacion_model.dart';
import 'package:app/utils/responsive.dart';
import 'package:app/widgets/chart.dart';
import 'package:app/widgets/transaction_form.dart';
import 'package:app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/messages.dart';

/// Home Screen - tela inicial da aplicação.
///
/// @author Rodrigo Andrade
/// @since 20/05/2021
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Controle do Chart: Somente em modo Landscape
  bool _showChart = false;

  /// App bar
  AppBar get _appBar => AppBar(
        title: Text(Messages.APP_TITLE),
        centerTitle: true,
        actions: [
          if (Responsive.isLandscape(context))
            IconButton(
              icon: Icon(
                _showChart ? Icons.menu_book : Icons.bar_chart,
              ),
              onPressed: () => setState(() => _showChart = !_showChart),
            )
        ],
      );

  /// Transaction List
  final List<TransactionModel> _transactionList = <TransactionModel>[];

  /// Retorna as transacoes dos ultimos 7 dias
  List<TransactionModel> get _recentTransaction {
    return _transactionList
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  /// Adiciona Transaction
  void _addTransaction({String title, double value, DateTime dateTime}) {
    setState(() {
      _transactionList.add(TransactionModel(
        id: '${DateTime.now().millisecond}',
        title: title,
        value: value,
        date: dateTime,
      ));
    });

    // Close the bottom Sheet Modal after submit Transaction.
    Navigator.of(context).pop();
  }

  /// Remove um Transaction da lista de Transactions
  ///
  /// @param String id - Id da transaction
  void _removeTransaction(String id) {
    setState(() {
      _transactionList
          .removeWhere((transaction) => transaction.id.compareTo(id) == 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: _transactionList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                    if (_showChart || !Responsive.isLandscape(context))
                      Container(
                        // Responsive Height to Chart
                        height: Responsive.height(context, _appBar) *
                            (Responsive.isLandscape(context) ? .7 : .3),
                        child: Chart(_recentTransaction),
                      ),
                    if (!_showChart || !Responsive.isLandscape(context))
                      Container(
                        height: Responsive.height(context, _appBar) * .7,
                        child: TransactionList(
                          transctionModeList: _transactionList,
                          toDelete: _removeTransaction,
                        ),
                      )
                  ])
            : Container(
                color: Colors.white,
                width: double.infinity,
                height: Responsive.height(context, _appBar),
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/teen-walking.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                    child: TransactionForm(onAddedExpense: _addTransaction));
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
