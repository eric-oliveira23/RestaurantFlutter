import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_go/model/table_model.dart';
import 'package:restaurant_go/services/api_service.dart';

class HomeHolderController extends ChangeNotifier {
  List<TableModel> _tableModel = <TableModel>[].obs;
  List<TableModel> get tableModel => _tableModel;

  List<TableModel> _mesasOcupadasList = [];
  List<TableModel> get mesasOcupadasList => _mesasOcupadasList;

  List<TableModel> _todasAsMesas = [];
  List<TableModel> get todasAsMesas => _todasAsMesas;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _showingPanel = false;
  bool get showingPanel => _showingPanel;

  TableModel? _selectedTable;
  TableModel? get selectedTable => _selectedTable;

  void showPanelClicked(TableModel selectedTable) {
    if (showingPanel) {
      if (_selectedTable?.numero == selectedTable.numero) {
        _showingPanel = false;
      }
      _selectedTable = selectedTable;
      notifyListeners();
      return;
    }

    _showingPanel = !showingPanel;
    _selectedTable = selectedTable;
    notifyListeners();
  }

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    _showingPanel = false;
    notifyListeners();
  }

  Future<void> getTablesRequest() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) async {
        todasAsMesas.clear();

        _tableModel = await ApiService.getAllTables();

        if (_tableModel.isNotEmpty) {
          _mesasOcupadasList = _tableModel;
        }

        _todasAsMesas = List.generate(
          50,
          (index) => TableModel(
            numero: index + 1,
            pedidos: [],
            total: 0,
          ),
        );

        for (var mesaOcupada in _mesasOcupadasList) {
          int index = mesaOcupada.numero - 1;
          _todasAsMesas[index] = mesaOcupada;
        }

        _todasAsMesas.sort((a, b) => a.numero.compareTo(b.numero));

        notifyListeners();
      },
    );
  }
}
