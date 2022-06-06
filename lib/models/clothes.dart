class Clothes {
  String? productName;
  String? price;
  String? imageUrl;

  Clothes(
    this.productName,
    this.price,
    this.imageUrl,
  );

  static List<Clothes> generateClothes() {
    return [
      Clothes('Sweater', '\$70.99', 'assets/images/arrival1.png'),
      Clothes('T-Shirt & Jacket', '\$80.99', 'assets/images/arrival2.png'),
    ];
  }
}
