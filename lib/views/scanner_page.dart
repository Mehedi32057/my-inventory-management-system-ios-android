// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// //
// // class ScannerPage extends StatefulWidget {
// //   @override
// //   _ScannerPageState createState() => _ScannerPageState();
// // }
// //
// // class _ScannerPageState extends State<ScannerPage> {
// //   String _scanResult = '';
// //
// //   Future<void> _scanQRCode() async {
// //     String scanResult = await FlutterBarcodeScanner.scanBarcode(
// //       '#FF0000', // Scanner overlay color
// //       'Cancel', // Cancel button text
// //       false, // Show flash icon
// //       ScanMode.QR, // Scan mode
// //     );
// //
// //     setState(() {
// //       _scanResult = scanResult;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Scanner Page'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             ElevatedButton(
// //               onPressed: _scanQRCode,
// //               child: Text('Scan QR Code'),
// //             ),
// //             SizedBox(height: 20),
// //             Text('Scan Result: $_scanResult'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
//
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//
// // Demo data structure for products
// class Product {
//   final String productName;
//   final String batchNumber;
//   final int quantity;
//   final String worker;
//   final String trucker;
//
//   Product({
//     required this.productName,
//     required this.batchNumber,
//     required this.quantity,
//     required this.worker,
//     required this.trucker,
//   });
// }
//
// class ScannerPage extends StatefulWidget {
//   @override
//   _ScannerPageState createState() => _ScannerPageState();
// }
//
// class _ScannerPageState extends State<ScannerPage> {
//   String _scanResult = '';
//   Product? _product;
//
//   // Demo product list
//   List<Product> products = [
//     Product(
//       productName: 'Product 1',
//       batchNumber: 'B123',
//       quantity: 100,
//       worker: 'Worker A',
//       trucker: 'Trucker X',
//     ),
//     Product(
//       productName: 'Product 2',
//       batchNumber: 'B456',
//       quantity: 200,
//       worker: 'Worker B',
//       trucker: 'Trucker Y',
//     ),
//     Product(
//       productName: 'Product 3',
//       batchNumber: 'B789',
//       quantity: 150,
//       worker: 'Worker C',
//       trucker: 'Trucker Z',
//     ),
//   ];
//
//   // Function to simulate finding product by barcode (QR code)
//   Product? _getProductFromBarcode(String barcode) {
//     return products.firstWhere(
//           (product) => product.batchNumber == barcode,
//       orElse: () => Product(
//         productName: 'Unknown',
//         batchNumber: barcode,
//         quantity: 0,
//         worker: 'N/A',
//         trucker: 'N/A',
//       ),
//     );
//   }
//
//   // Function to scan QR code
//   Future<void> _scanQRCode() async {
//     String scanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000', // Scanner overlay color
//       'Cancel', // Cancel button text
//       false, // Show flash icon
//       ScanMode.QR, // Scan mode
//     );
//
//     // Look up the product from the scan result
//     setState(() {
//       _scanResult = scanResult;
//       _product = _getProductFromBarcode(scanResult);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scanner Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _scanQRCode,
//               child: Text('Scan QR Code'),
//             ),
//             SizedBox(height: 20),
//             Text('Scan Result: $_scanResult'),
//             SizedBox(height: 20),
//             // Display product details if found
//             if (_product != null) ...[
//               Text('Product Name: ${_product!.productName}'),
//               Text('Batch Number: ${_product!.batchNumber}'),
//               Text('Quantity: ${_product!.quantity}'),
//               Text('Worker: ${_product!.worker}'),
//               Text('Trucker: ${_product!.trucker}'),
//             ] else if (_scanResult.isNotEmpty) ...[
//               Text('Product not found for barcode: $_scanResult')
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
//

//new code
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// Demo data structure for products
class Product {
  final String productName;
  final String batchNumber;
  final int quantity;
  final String worker;
  final String trucker;

  Product({
    required this.productName,

    required this.batchNumber,
    required this.quantity,
    required this.worker,
    required this.trucker,
  });
}

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrViewController;
  String _scanResult = '';
  Product? _product;

  // Demo product list
  List<Product> products = [
    Product(
      productName: 'Product 1',
      batchNumber: 'B123',
      quantity: 100,
      worker: 'Worker A',
      trucker: 'Trucker X',
    ),
    Product(
      productName: 'Product 2',
      batchNumber: 'B456',
      quantity: 200,
      worker: 'Worker B',
      trucker: 'Trucker Y',
    ),
    Product(
      productName: 'Product 3',
      batchNumber: 'B789',
      quantity: 150,
      worker: 'Worker C',
      trucker: 'Trucker Z',
    ),
  ];

  // Function to simulate finding product by barcode (QR code)
  Product? _getProductFromBarcode(String barcode) {
    return products.firstWhere(
          (product) => product.batchNumber == barcode,
      orElse: () => Product(
        productName: 'Unknown',
        batchNumber: barcode,
        quantity: 0,
        worker: 'N/A',
        trucker: 'N/A',
      ),
    );
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner Page'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Scan Result: $_scanResult'),
                  SizedBox(height: 10),
                  if (_product != null) ...[
                    Text('Product Name: ${_product!.productName}'),
                    Text('Batch Number: ${_product!.batchNumber}'),
                    Text('Quantity: ${_product!.quantity}'),
                    Text('Worker: ${_product!.worker}'),
                    Text('Trucker: ${_product!.trucker}'),
                  ] else if (_scanResult.isNotEmpty) ...[
                    Text('Product not found for barcode: $_scanResult')
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _scanResult = scanData.code!;
        _product = _getProductFromBarcode(_scanResult);
      });
    });
  }
}