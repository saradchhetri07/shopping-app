import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/editProduct";
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  TextEditingController _imageurlController = TextEditingController();
  final _imageurlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isinit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageURL': ''
  };
  var _editedProduct =
      Product(id: '', title: '', price: 0, description: '', imageUrl: '');
  var _isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    _imageurlController.addListener(_updateListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isinit == true) {
      var productId = ModalRoute.of(context)!.settings.arguments;

      if (productId != null) {
        productId = productId as String;
        final productProvider = Provider.of<Products>(context, listen: false);
        _editedProduct = productProvider.findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageURL': ""
        };
        _imageurlController.text = _editedProduct.imageUrl;
      }
    }

    setState(() {
      _isinit = false;
    });
    super.didChangeDependencies();
  }

  void _updateListener() {
    // if (_imageurlFocusNode.hasFocus) {
    //   if ((!_imageurlController.text.startsWith("http:") &&
    //           !_imageurlController.text.startsWith("https:")) ||
    //       (!_imageurlController.text.endsWith(".png") &&
    //           !_imageurlController.text.endsWith("jpg") &&
    //           !_imageurlController.text.endsWith("jpeg"))) {
    //     return;
    //   }
    if (_imageurlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageurlFocusNode.removeListener(_updateListener);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageurlController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final productProvider = Provider.of<Products>(context, listen: false);

    if (_form.currentState!.validate()) {
      (_form.currentState!.save());
      //update the edited product
      //check if id of edited product exist

      if (_editedProduct.id != '') {
        productProvider.updateProduct(_editedProduct.id, _editedProduct);
      } else {
        setState(() {
          _isloading = true;
        });
        try {
          await productProvider.addProduct(_editedProduct).then((_) {
            setState(() {
              _isloading = false;
            });
            Navigator.popAndPushNamed(context, "/userProduct");
          });
        } catch (error) {
          showCupertinoDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("An error occured"),
                    content: Text("something went wrong"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "/userProduct");
                          },
                          child: Text("ok"))
                    ],
                  ));
        } finally {
          setState(() {
            _isloading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Form couldn't be validated",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit product"),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm;
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: AppDrawer(),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(labelText: "title"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: value!,
                              price: _editedProduct.price,
                              description: _editedProduct.description,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a value";
                          }
                          if (value.length > 10) {
                            return "value can be at most 10 characters";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          initialValue: _initValues['price'],
                          decoration: InputDecoration(labelText: "price"),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          focusNode: _priceFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the price";
                            }
                            if (double.tryParse(value) == null) {
                              return "Please enter valid price";
                            }
                            if (double.parse(value) <= 0) {
                              return "Please enter value greater than zero";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            try {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  price: double.parse(value!),
                                  description: _editedProduct.description,
                                  imageUrl: _editedProduct.imageUrl,
                                  isFavorite: _editedProduct.isFavorite);
                            } catch (e) {
                              print(e);
                            }
                          }),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration:
                            const InputDecoration(labelText: "description"),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: value!,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorite: _editedProduct.isFavorite);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the description";
                          }
                          if (value.length > 20) {
                            return "Description must be at most 20 characters";
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: _imageurlController.text.isEmpty
                                  ? Center(child: Text("Enter a URL"))
                                  : FittedBox(
                                      child: Image.network(
                                          _imageurlController.text,
                                          fit: BoxFit.cover),
                                    )),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Enter imageURL"),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageurlController,
                              focusNode: _imageurlFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                    id: _editedProduct.id,
                                    title: _editedProduct.title,
                                    price: _editedProduct.price,
                                    description: _editedProduct.description,
                                    imageUrl: value!,
                                    isFavorite: _editedProduct.isFavorite);
                              },
                              validator: (value) {
                                try {
                                  if (value!.isEmpty) {
                                    return "Enter image url";
                                  }
                                  if ((!value!.startsWith("http") ||
                                          !value!.startsWith("https")) &&
                                      (!value!.endsWith("jpg") ||
                                          !value!.endsWith("jpeg")) &&
                                      (!value!.endsWith("png"))) {
                                    return "Invalid url";
                                  }
                                  return null;
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
