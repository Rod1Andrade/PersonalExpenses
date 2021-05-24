import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Tamanhos disponiveis
///
/// @author Rodrigo Andrade
/// @since 24/05/2021
class Responsive {

  /// Retorna a altura disponivel descontando a altura da appbar
  /// e a altuar do padding do top.
  ///
  /// @return double value
  static double height(BuildContext context, AppBar appBar) {
    return MediaQuery.of(context).size.height - appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
  }

  /// Verifica se a orientacao esta em paisagem
  ///
  /// @return True caso esteja e False caso contrario
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}