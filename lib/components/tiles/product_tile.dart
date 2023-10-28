import 'package:flutter/material.dart';
import 'package:restaurant_go/components/image_base64.dart';
import 'package:restaurant_go/util/device_verifier.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final String value;
  final String? image;

  const ProductTile({
    super.key,
    required this.name,
    required this.value,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: image != null
                      ? ImageFromBase64(
                          base64String: image!,
                          width: double.infinity,
                          height: 230,
                        )
                      : Container(
                          width: 100,
                        ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize:
                                  DeviceVerifier.responsiveFontSizeBig(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R\$ 9,99',
                            style: TextStyle(
                              fontSize:
                                  DeviceVerifier.responsiveFontSize(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton(
                  tooltip: "Exibir menu",
                  icon: const Icon(Icons.more_horiz_rounded),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 'opcao2',
                        child: Text('Editar'),
                      ),
                      const PopupMenuItem(
                        value: 'opcao3',
                        child: Text(
                          'Excluir',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ];
                  },
                  onSelected: (result) {},
                ),
              ))
        ],
      ),
    );
  }
}
