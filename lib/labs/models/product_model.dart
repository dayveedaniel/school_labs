class ProductModel {
  ProductModel({
    required this.id,
    required this.kind,
    required this.title,
    required this.price,
    required this.weight,
    this.filePath = '',
  });

  final int id;
  final String kind;
  final String title;
  final double price;
  final double weight;
  final String filePath;

  String get info => ('$kind, $title, $weight кг, $price ₽');

  Map<String, dynamic> toMap() =>
     <String, dynamic>{
      'kind': kind,
      'title': title,
      'price': price,
      'weight': weight,
      'filePath': filePath,
    };


  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'].toInt(),
      kind: map['kind'],
      title: map['title'],
      price: map['price'].toDouble(),
      weight: map['weight'].toDouble(),
      filePath: map['filePath'],
    );
  }

  ProductModel copyWith({
    int? id,
    String? kind,
    String? title,
    double? price,
    double? weight,
    String? filePath,
  }) {
    return ProductModel(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      filePath: filePath ?? this.filePath,
    );
  }
}

final productsMock = [
  ProductModel(
    id: 1,
    kind: 'Фрукт',
    title: 'Яблоко',
    price: 21.22,
    weight: 12,
  ),
  ProductModel(
    id: 2,
    kind: 'Фрукт',
    title: 'Банан',
    price: 37.78,
    weight: 5,
  ),
  ProductModel(
    id: 3,
    kind: 'Фрукт',
    title: 'Апельсин',
    price: 3.8,
    weight: 2,
  ),
  ProductModel(
    id: 4,
    kind: 'Овощ',
    title: 'Помидор',
    price: 11.4,
    weight: 47,
  ),
  ProductModel(
    id: 5,
    kind: 'Овощ',
    title: 'Огурец',
    price: 64.33,
    weight: 6,
  ),
];
