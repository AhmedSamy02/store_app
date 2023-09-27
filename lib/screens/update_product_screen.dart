import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/services/update_product.dart';

class UpdateProductScreen extends StatefulWidget {
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _titleController = TextEditingController(),
      _descController = TextEditingController(),
      _priceController = TextEditingController(),
      _imageController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Update Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Product Name',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Description',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Price',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: TextField(
                  controller: _imageController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Image',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          _isLoading = true;
                        });
                        Product response = await updateProduct(product);
                        print('succes response data is \n${response.toJson()}');
                      } on Exception catch (e) {
                        print(e);
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: const Text('Update'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Product> updateProduct(Product product) {
    return UpdateProduct.updateProduct(
        title: _titleController.text == ''
            ? product.title!
            : _titleController.text,
        price: _priceController.text == ''
            ? product.price.toString()
            : _priceController.text,
        description: _descController.text == ''
            ? product.description ?? ''
            : _descController.text,
        image: _imageController.text == ''
            ? product.image ?? ''
            : _imageController.text,
        category: product.category ?? '',
        id: product.id.toString());
  }
}
