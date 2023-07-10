// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:shop/providers/product.dart';

// class EditProductScreen extends StatefulWidget {
//   static const routeName = "/editProduct";
//   const EditProductScreen({super.key});

//   @override
//   State<EditProductScreen> createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   final _priceFocusNode = FocusNode();
//   final _descriptionFocusNode = FocusNode();
//   TextEditingController _imageurlController = TextEditingController();
//   final _imageurlFocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _editedProduct =
//       Product(id: '', title: '', price: 0, description: '', imageUrl: '');
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   _imageurlController.addListener(_updateListener);
//   //   super.initState();
//   // }

//   void _updateListener() {
//     // if (_imageurlFocusNode.hasFocus) {
//     //   if ((!_imageurlController.text.startsWith("http:") &&
//     //           !_imageurlController.text.startsWith("https:")) ||
//     //       (!_imageurlController.text.endsWith(".png") &&
//     //           !_imageurlController.text.endsWith("jpg") &&
//     //           !_imageurlController.text.endsWith("jpeg"))) {
//     //     return;
//     //   }
//     setState(() {});
//     // }
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _imageurlFocusNode.removeListener(_updateListener);
//     _priceFocusNode.dispose();
//     _descriptionFocusNode.dispose();
//     _imageurlController.dispose();
//     _imageurlController.dispose();
//     super.dispose();
//   }

//   void _saveForm() {
//     _form.currentState?.validate();
//     _form.currentState?.save();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("edit product"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 _saveForm;
//               },
//               icon: Icon(Icons.save))
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//             key: _form,
//             child: ListView(
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(labelText: "title"),
//                   textInputAction: TextInputAction.next,
//                   onFieldSubmitted: (_) {
//                     FocusScope.of(context).requestFocus(_priceFocusNode);
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         id: _editedProduct.id,
//                         title: value!,
//                         price: _editedProduct.price,
//                         description: _editedProduct.description,
//                         imageUrl: _editedProduct.imageUrl);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please provide a value";
//                     }
//                     if (value.length > 10) {
//                       return "value can be at most 10 characters";
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: "price"),
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                   focusNode: _priceFocusNode,
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         id: _editedProduct.id,
//                         title: _editedProduct.title,
//                         price: double.parse(value!),
//                         description: _editedProduct.description,
//                         imageUrl: _editedProduct.imageUrl);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter the price";
//                     }
//                     if (double.tryParse(value) == null) {
//                       return "Please enter valid price";
//                     }
//                     if (double.parse(value) <= 0) {
//                       return "Please enter value greater than zero";
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: "description"),
//                   keyboardType: TextInputType.multiline,
//                   maxLines: 3,
//                   textInputAction: TextInputAction.next,
//                   focusNode: _descriptionFocusNode,
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         id: _editedProduct.id,
//                         title: _editedProduct.title,
//                         price: _editedProduct.price,
//                         description: value!,
//                         imageUrl: _editedProduct.imageUrl);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter the price";
//                     }
//                     if (double.tryParse(value) == null) {
//                       return "Please enter valid price";
//                     }
//                     if (double.parse(value) <= 0) {
//                       return "Please enter value greater than zero";
//                     }
//                     return null;
//                   },
//                 ),
//                 // Row(
//                 //   children: [
//                 //     Container(
//                 //         width: 100,
//                 //         height: 100,
//                 //         margin: EdgeInsets.all(8.0),
//                 //         decoration: BoxDecoration(
//                 //             border: Border.all(width: 1, color: Colors.grey)),
//                 //         child: _imageurlController.text.isEmpty
//                 //             ? Center(child: Text("Enter a URL"))
//                 //             : FittedBox(
//                 //                 child: Image.network(_imageurlController.text,
//                 //                     fit: BoxFit.cover),
//                 //               )),
//                 //     Expanded(
//                 //       child: TextFormField(
//                 //         decoration:
//                 //             const InputDecoration(labelText: "Enter imageURL"),
//                 //         keyboardType: TextInputType.url,
//                 //         textInputAction: TextInputAction.done,
//                 //         controller: _imageurlController,
//                 //         focusNode: _imageurlFocusNode,
//                 //         onFieldSubmitted: (_) {
//                 //           _saveForm();
//                 //         },
//                 //         onSaved: (value) {
//                 //           _editedProduct = Product(
//                 //               id: _editedProduct.id,
//                 //               title: _editedProduct.title,
//                 //               price: _editedProduct.price,
//                 //               description: _editedProduct.description,
//                 //               imageUrl: value!);
//                 //         },
//                 //         // validator: (value) {
//                 //         //   if (_imageurlController.text.isEmpty) {
//                 //         //     return "Enter a valid url";
//                 //         //   }
//                 //         //   return null;
//                 //         // },
//                 //       ),
//                 //     ),
//                 //   ],
//                 // )
//               ],
//             )),
//       ),
//     );
//   }
// }
