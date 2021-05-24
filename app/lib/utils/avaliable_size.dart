import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Tamanhos disponiveis
///
/// @author Rodrigo Andrade
/// @since 24/05/2021
class AvaliableSize {

  /// Retorna a altura disponivel descontando a altura da appbar
  /// e a altuar do padding do top.
  ///
  /// @return double value
  static double height(BuildContext context, AppBar appBar) {
    return MediaQuery.of(context).size.height - appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
  }
}