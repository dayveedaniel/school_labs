import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_labs/labs/lab5/camera_screen.dart';
import 'package:school_labs/labs/lab5/db_service.dart';
import 'package:school_labs/labs/models/product_model.dart';
import 'package:school_labs/main.dart';

import 'edit_screen.dart';

class Lab5 extends StatefulWidget {
  const Lab5({super.key});

  @override
  State<Lab5> createState() => _Lab4State();
}

class _Lab4State extends State<Lab5> {
  late final DbService service;

  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    service = DbService();
    initProducts();
  }

  Future<void> initProducts() async {
    if (products.isNotEmpty) products.clear();
    products = await service.retrieveAllData();
    setState(() {});
  }

  Future<void> addProductToList(ProductModel newProduct) async {
    await service.insertData([newProduct]);
    await initProducts();
  }

  Future<void> updateProductData(
    ProductModel newProduct,
    int indexInList,
  ) async {
    await service.updateCertainData(newProduct);
    await initProducts();
  }

  Future<void> addNewProduct(BuildContext context) async {
    final ProductModel? newProduct = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EditScreen()),
    );
    if (newProduct != null) await addProductToList(newProduct);
  }

  Future<void> deleteProduct(int id) async {
    await service.deleteCertainData(id);
    await initProducts();
  }

  Future<void> editProduct(
    BuildContext context,
    int indexInList,
    ProductModel currentProduct,
  ) async {
    final ProductModel? newProduct = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => EditScreen(product: currentProduct)),
    );
    if (newProduct != null) await updateProductData(newProduct, indexInList);
  }

  Future<void> addImage(ProductModel product) async {
    final String? imagePath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraWidget(cameras.first)),
    );

    if (imagePath != null) {
      await service.updateCertainData(product.copyWith(filePath: imagePath));

      await initProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лаб 5 Семенов Михаил')),
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

                return Dismissible(
                  key: ValueKey<int>(product.id),
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      await deleteProduct(product.id);
                    }
                  },
                  confirmDismiss: (direction) async =>
                      direction == DismissDirection.endToStart,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () async => await addImage(product),
                        icon: const Icon(Icons.add_a_photo),
                      ),
                      title: Column(
                        children: [
                          Text(product.info),
                          const SizedBox(height: 10),
                          if (product.filePath.isNotEmpty)
                            Image.file(File(product.filePath))
                        ],
                      ),
                      onTap: () => editProduct(context, index, product),
                    ),
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
