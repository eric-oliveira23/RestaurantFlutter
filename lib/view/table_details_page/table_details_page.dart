import 'package:flutter/material.dart';
import 'package:restaurant_go/model/table_model.dart';
import 'package:restaurant_go/view/table_details_page/table_details_binding.dart';

class TableDetailsPage extends StatefulWidget {
  final List<Pedido> pedidos;

  const TableDetailsPage({super.key, required this.pedidos});

  @override
  State<TableDetailsPage> createState() => _TableDetailsPageState();
}

class _TableDetailsPageState extends State<TableDetailsPage> {
  @override
  void initState() {
    setupTableDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.pedidos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.pedidos[index].item),
                leading: Text(
                  widget.pedidos[index].quantidade.toString(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
