// import 'package:flutter/material.dart';
// import 'package:nexchain/services/api_service.dart';
// import '../models/product.dart';
//
// class ProductListScreen extends StatefulWidget {
//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }
//
// class _ProductListScreenState extends State<ProductListScreen> {
//   List<ProductAn> _products = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts();
//   }
//
//   Future<void> _fetchProducts() async {
//     try {
//       final products = await ApiService().getProducts();
//       setState(() {
//         _products = products;
//       });
//     } catch (e) {
//       // Handle error
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product List'),
//       ),
//       body: ListView.builder(
//         itemCount: _products.length,
//         itemBuilder: (context, index) {
//           final product = _products[index];
//           return Card(
//             elevation: 3,
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text(
//                 product.productName,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 8),
//                   Text(
//                     'Price: \$${product.price.toStringAsFixed(2)}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Purchase Date: ${product.purchaseDate.toString()}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'Quantity: ${product.quantity.toString()}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     'ID: ${product.id.toString()}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   // Add any other details you want to display
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:nexchain/services/api_service.dart';
import '../models/product.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductAn> _products = [];
  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await ApiService().getProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading products: ${e.toString()}')),
      );
    }
  }

  void _showEditDialog(ProductAn product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Product Name'),
                controller: TextEditingController(text: product.productName),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                controller: TextEditingController(text: product.price.toString()),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                controller: TextEditingController(text: product.quantity.toString()),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement update logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Product updated successfully')),
              );
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(ProductAn product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Product'),
        content: Text('Are you sure you want to delete ${product.productName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement delete logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Product deleted successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            sortColumnIndex: _currentSortColumn,
            sortAscending: _isAscending,
            columns: [
              DataColumn(
                label: Text('ID'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    _currentSortColumn = columnIndex;
                    _isAscending = ascending;
                    _products.sort((a, b) =>
                    ascending ? a.id.compareTo(b.id) : b.id.compareTo(a.id)
                    );
                  });
                },
              ),
              DataColumn(
                label: Text('Product Name'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    _currentSortColumn = columnIndex;
                    _isAscending = ascending;
                    _products.sort((a, b) =>
                    ascending ? a.productName.compareTo(b.productName) : b.productName.compareTo(a.productName)
                    );
                  });
                },
              ),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Purchase Date')),
              DataColumn(label: Text('Actions')),
            ],
            rows: _products.map(
                  (product) => DataRow(
                cells: [
                  DataCell(Text(product.id.toString())),
                  DataCell(Text(product.productName)),
                  DataCell(Text('\$${product.price.toStringAsFixed(2)}')),
                  DataCell(Text(product.quantity.toString())),
                  DataCell(Text(product.purchaseDate.toString())),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditDialog(product),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteDialog(product),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }
}