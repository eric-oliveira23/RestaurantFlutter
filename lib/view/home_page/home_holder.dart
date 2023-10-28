import 'package:flutter/material.dart';
import 'package:restaurant_go/model/table_model.dart';
import 'package:restaurant_go/util/device_verifier.dart';
import 'package:restaurant_go/util/price_formatter.dart';
import 'package:restaurant_go/view/home_page/home_holder_controller.dart';
import 'package:restaurant_go/view/products_page/products_page.dart';

class HomeHolder extends StatefulWidget {
  const HomeHolder({super.key});

  @override
  State<HomeHolder> createState() => _HomeHolderState();
}

class _HomeHolderState extends State<HomeHolder> {
  final HomeHolderController _homeController = HomeHolderController();

  @override
  void initState() {
    _homeController.getTablesRequest();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: ListenableBuilder(
        listenable: _homeController,
        builder: (context, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationRail(
                selectedIndex: _homeController.selectedIndex,
                onDestinationSelected: (int index) {
                  _homeController.updateIndex(index);
                },
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.table_restaurant_outlined),
                    label: Text("Mesas"),
                    indicatorColor: Colors.black,
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.food_bank),
                    label: Text("Produtos"),
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  if (_homeController.selectedIndex == 0) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: TablesPage(
                          size: size,
                          homeController: _homeController,
                        ),
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: ProductsPage(),
                    );
                  }
                },
              ),
              TableDetailsPanel(
                size: size,
                homeHolderController: _homeController,
              )
            ],
          );
        },
      ),
    );
  }
}

class TablesPage extends StatelessWidget {
  const TablesPage({
    super.key,
    required this.size,
    required HomeHolderController homeController,
  }) : _homeController = homeController;

  final Size size;
  final HomeHolderController _homeController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tables',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: size.width >= 500 ? 5 : 3,
            children: List.generate(
              _homeController.todasAsMesas.length,
              (index) {
                var item = _homeController.todasAsMesas[index];
                return TableTile(
                  tableModel: item,
                  onTap: () {
                    _homeController.showPanelClicked(
                      item,
                    );
                  },
                  homeController: _homeController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TableTile extends StatelessWidget {
  final TableModel tableModel;
  final VoidCallback onTap;
  final HomeHolderController homeController;

  const TableTile({
    super.key,
    required this.tableModel,
    required this.onTap,
    required this.homeController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        onTap: () => onTap(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.multiply,
            color: tableModel.numero == homeController.selectedTable?.numero &&
                    homeController.showingPanel
                ? const Color(0xFFFFAC4A)
                : const Color(0xFFFAFAFC),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Text(tableModel.numero.toString()),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircleAvatar(
                      backgroundColor: tableModel.pedidos.isNotEmpty
                          ? Colors.yellow
                          : Colors.greenAccent,
                    ),
                  ),
                ),
                tableModel.pedidos.isNotEmpty
                    ? Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tableModel.nome != null
                                ? Text(
                                    tableModel.nome!,
                                  )
                                : const SizedBox.shrink(),
                            Text(
                              priceFormatter(
                                tableModel.total.toString(),
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TableDetailsPanel extends StatelessWidget {
  final Size size;
  final HomeHolderController homeHolderController;

  const TableDetailsPanel({
    Key? key,
    required this.size,
    required this.homeHolderController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = size.width > 1000 ? size.width / 4 : size.width / 3;

    return AnimatedSize(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: homeHolderController.showingPanel ? width : 0,
        color: Colors.white,
        child: Visibility(
          visible: homeHolderController.showingPanel,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Table ${homeHolderController.selectedTable?.numero}",
                            style: TextStyle(
                              fontSize:
                                  DeviceVerifier.responsiveFontSize(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            homeHolderController.selectedTable?.nome ?? "",
                            style: TextStyle(
                              fontSize: DeviceVerifier.responsiveFontSizeSmall(
                                  context),
                            ),
                          ),
                        ]),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFFFAC4A),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      homeHolderController.selectedTable?.pedidos.length ?? 0,
                  itemBuilder: (context, index) {
                    var pedido =
                        homeHolderController.selectedTable?.pedidos[index];
                    return ListTile(
                      title: Text(pedido!.item),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
