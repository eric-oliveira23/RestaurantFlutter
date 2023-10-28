String priceFormatter(String value) {
  double valor = double.parse(value);

  final reais = valor.floor();
  final centavos = ((valor - reais) * 100).round();

  final reaisFormatted = reais.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  final centavosFormatted = centavos.toString().padLeft(2, '0');

  return 'R\$ $reaisFormatted,$centavosFormatted';
}
