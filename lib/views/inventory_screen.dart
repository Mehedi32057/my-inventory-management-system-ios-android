// import 'package:flutter/material.dart';
// import 'package:nexchain/models/inventory.dart';
// import 'package:nexchain/models/stock.dart';
// import 'package:nexchain/services/inventory_service.dart';
//
// class InventoryScreen extends StatefulWidget {
//   @override
//   _InventoryScreenState createState() => _InventoryScreenState();
// }
//
// class _InventoryScreenState extends State<InventoryScreen> {
//   final InventoryService _inventoryService = InventoryService();
//   late Future<List<Stock>> _stockDetails;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchStockDetails();
//   }
//
//   void _fetchStockDetails() {
//     _stockDetails = _inventoryService.getStockDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Inventory Screen'),
//       ),
//       body: FutureBuilder<List<Stock>>(
//         future: _stockDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error fetching stock details'));
//           }
//
//           final List<Stock>? stockList = snapshot.data;
//
//           if (stockList == null || stockList.isEmpty) {
//             return Center(child: Text('No stock details available'));
//           }
//
//           return ListView.builder(
//             itemCount: stockList.length + 1, // Add 1 for the column names row
//             itemBuilder: (context, index) {
//               if (index == 0) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(child: Text('Material Name', style: TextStyle(fontWeight: FontWeight.bold))),
//                       Expanded(child: Text('Previous Price', style: TextStyle(fontWeight: FontWeight.bold))),
//                       Expanded(child: Text('Unit Price', style: TextStyle(fontWeight: FontWeight.bold))),
//                       Expanded(child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold))),
//                       Expanded(child: Text('Last Stock Update', style: TextStyle(fontWeight: FontWeight.bold))),
//                       Expanded(child: Text('Increase', style: TextStyle(fontWeight: FontWeight.bold))),
//                       Expanded(child: Text('Decrease', style: TextStyle(fontWeight: FontWeight.bold))),
//                     ],
//                   ),
//                 );
//               }
//
//               final Stock stock = stockList[index - 1];
//               final bool isEvenIndex = index % 2 == 0;
//               final Color rowColor = isEvenIndex ? Colors.grey[200]! : Colors.white;
//
//               return Container(
//                 color: rowColor,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(child: Text(stock.rawMaterial?.materialName ?? '')),
//                       Expanded(child: Text(stock.previousPrice.toString())),
//                       Expanded(child: Text(stock.unitPrice.toString())),
//                       Expanded(child: Text(stock.quantity.toString())),
//                       Expanded(child: Text(stock.lastStockUpdateDate.toString())),
//                       Expanded(child: Text('${stock.increase}%')),
//                       Expanded(child: Text('${stock.decrease}%')),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// new code

import 'package:flutter/material.dart';
import 'package:nexchain/models/stock.dart';
import 'package:nexchain/services/inventory_service.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final InventoryService _inventoryService = InventoryService();
  late Future<List<Stock>> _stockDetails;

  @override
  void initState() {
    super.initState();
    _fetchStockDetails();
  }

  void _fetchStockDetails() {
    _stockDetails = _inventoryService.getStockDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inventory Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Stock>>(
        future: _stockDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching stock details', style: TextStyle(fontSize: 16, color: Colors.red)));
          }

          final List<Stock>? stockList = snapshot.data;

          if (stockList == null || stockList.isEmpty) {
            return Center(child: Text('No stock details available', style: TextStyle(fontSize: 16)));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderRow(),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: stockList.length,
                    itemBuilder: (context, index) {
                      final Stock stock = stockList[index];
                      return _buildStockRow(stock, index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderCell('Material Name'),
          _buildHeaderCell('Previous Price'),
          _buildHeaderCell('Unit Price'),
          _buildHeaderCell('Quantity'),
          _buildHeaderCell('Last Update'),
          _buildHeaderCell('Increase'),
          _buildHeaderCell('Decrease'),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  Widget _buildStockRow(Stock stock, int index) {
    final bool isEven = index % 2 == 0;
    final Color rowColor = isEven ? Colors.grey[200]! : Colors.white;

    return Container(
      color: rowColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDataCell(stock.rawMaterial?.materialName ?? '', isEven),
            _buildDataCell(stock.previousPrice.toString(), isEven),
            _buildDataCell(stock.unitPrice.toString(), isEven),
            _buildDataCell(stock.quantity.toString(), isEven),
            _buildDataCell(stock.lastStockUpdateDate.toString(), isEven),
            _buildDataCell('${stock.increase}%', isEven),
            _buildDataCell('${stock.decrease}%', isEven),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, bool isEven) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: isEven ? Colors.grey[100] : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
