import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:restaurant_go/components/tiles/product_tile.dart';
import 'package:restaurant_go/view/products_page/products_binding.dart';
import 'package:restaurant_go/view/products_page/products_controller.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final ProductsController _productsController;

  @override
  void initState() {
    setupProductsPage();

    _productsController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            _productsController.onTextfieldChanged(value);
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(14),
            border: InputBorder.none,
            hintText: "Pesquise o produto...",
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Cadastrar novo'),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => _productsController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Obx(
                      () => GridView.builder(
                        padding: const EdgeInsets.only(
                          top: 30,
                          bottom: 30,
                          left: 45,
                          right: 45,
                        ),
                        shrinkWrap: true,
                        itemCount: _productsController.productsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size >= 1450 ? 3 : 1,
                          childAspectRatio: size >= 1450 ? 1.8 : 2,
                        ),
                        itemBuilder: (context, index) {
                          var product = _productsController.productsList[index];
                          return ProductTile(
                            name: product.item,
                            value: product.valor.toString(),
                            image: product.imagem,
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
