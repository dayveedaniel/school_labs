import 'package:flutter/material.dart';
import 'package:school_labs/labs/models/product_model.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    this.product,
  });

  final ProductModel? product;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  ProductModel? productModel;

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
      productModel = ProductModel(
        id: widget.product?.id ?? 0,
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
        title: const Text('Lab 5 David Daniel'),
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
