import 'package:flutter/material.dart';

class ProductModelLab4 {
  ProductModelLab4({
    required this.kind,
    required this.title,
    required this.price,
    required this.weight,
  });

  final String kind;
  final String title;
  final double price;
  final double weight;

  String get info => ('$kind, $title, $weight кг, $price ₽');
}

class Lab4 extends StatefulWidget {
  const Lab4({super.key});

  @override
  State<Lab4> createState() => _Lab4State();
}

class _Lab4State extends State<Lab4> {
  List<ProductModelLab4> products = [];

  @override
  void initState() {
    products.addAll([
      ProductModelLab4(
        kind: 'Фрукт',
        title: 'Яблоко',
        price: 21.22,
        weight: 12,
      ),
      ProductModelLab4(
        kind: 'Фрукт',
        title: 'Банан',
        price: 37.78,
        weight: 5,
      ),
      ProductModelLab4(
        kind: 'Фрукт',
        title: 'Апельсин',
        price: 3.8,
        weight: 2,
      ),
      ProductModelLab4(
        kind: 'Овощ',
        title: 'Помидор',
        price: 11.4,
        weight: 47,
      ),
      ProductModelLab4(
        kind: 'Овощ',
        title: 'Огурец',
        price: 64.33,
        weight: 6,
      ),
    ]);
    super.initState();
  }

  void addProductToList(ProductModelLab4 newProduct) {
    products.add(newProduct);
    setState(() {});
  }

  void updateProductData(ProductModelLab4 newProduct, int indexInList) {
    products[indexInList] = newProduct;
    setState(() {});
  }

  Future<void> addNewProduct(BuildContext context) async {
    final ProductModelLab4? newProduct = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EditScreenLab4()),
    );
    if (newProduct != null) addProductToList(newProduct);
  }

  Future<void> editProduct(
    BuildContext context,
    int indexInList,
    ProductModelLab4 currentProduct,
  ) async {
    final ProductModelLab4? newProduct = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => EditScreenLab4(product: currentProduct)),
    );
    if (newProduct != null) updateProductData(newProduct, indexInList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лаб 4 Семенов Михаил')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => addNewProduct(context),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: List.generate(
              products.length,
              (index) {
                final product = products[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(product.info),
                    onTap: () => editProduct(context, index, product),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class EditScreenLab4 extends StatefulWidget {
  const EditScreenLab4({
    super.key,
    this.product,
  });

  final ProductModelLab4? product;

  @override
  State<EditScreenLab4> createState() => _EditScreenLab4State();
}

class _EditScreenLab4State extends State<EditScreenLab4> {
  ProductModelLab4? productModel;

  final _typeController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      productModel = widget.product;
      _typeController.text = productModel!.kind;
      _nameController.text = productModel!.title;
      _weightController.text = productModel!.weight.toString();
      _priceController.text = productModel!.price.toString();
    }
    setState(() {});
  }

  void validateForm() {
    if (_typeController.text.trim().isNotEmpty &&
        _nameController.text.trim().isNotEmpty &&
        _priceController.text.trim().isNotEmpty &&
        double.tryParse(_priceController.text) != null &&
        _weightController.text.trim().isNotEmpty &&
        double.tryParse(_weightController.text) != null) {
      productModel = ProductModelLab4(
        kind: _typeController.text,
        title: _nameController.text,
        weight: double.parse(_weightController.text),
        price: double.parse(_priceController.text),
      );
    } else {
      productModel = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лаб 4 Семенов Михаил'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 35),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done, size: 35),
            onPressed: productModel == null
                ? null
                : () => Navigator.pop(context, productModel),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          onChanged: validateForm,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Тип'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Цена'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _weightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Масса'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
