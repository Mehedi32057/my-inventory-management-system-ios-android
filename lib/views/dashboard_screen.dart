import 'package:flutter/material.dart';
import 'package:nexchain/widgets/dashboard_option.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.deepPurple, // Change the appBar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade200, Colors.purple.shade600],
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          childAspectRatio: 1.5,
          children: [
            DashboardOption(
              iconPath: 'images/supplier.png',
              title: 'Add Supplier',
              onTap: () {
                Navigator.pushNamed(context, '/supplier');
              },
            ),
            DashboardOption(
              iconPath: 'images/rawmaterial.png',
              title: 'Add RawMaterial',
              onTap: () {
                Navigator.pushNamed(context, '/rawmaterial');
              },
            ),
            DashboardOption(
              iconPath: 'images/procurement.png',
              title: 'Payment Info',
              onTap: () {
                Navigator.pushNamed(context, '/paymentinfo');
              },
            ),
            DashboardOption(
              iconPath: 'images/stock.png',
              title: 'StockDetails',
              onTap: () {
                Navigator.pushNamed(context, '/stock');
              },
            ),
            DashboardOption(
              iconPath: 'images/warestatus.png',
              title: 'WareHouse Status',
              onTap: () {
                Navigator.pushNamed(context, '/warestatus');
              },
            ),
            DashboardOption(
              iconPath: 'images/menu.png',
              title: 'Menu Bar',
              onTap: () {
                Navigator.pushNamed(context, '/menu');
              },
            ),
            DashboardOption(
              iconPath: 'images/employee.png',
              title: 'Employee List',
              onTap: () {
                Navigator.pushNamed(context, '/employee');
              },
            ),
            DashboardOption(
              iconPath: 'images/scan.png',
              title: 'Scanner',
              onTap: () {
                Navigator.pushNamed(context, '/scan');
              },
            ),
          ],
        ),
      ),
    );
  }
}

//new code

// import 'package:flutter/material.dart';
// import 'package:nexchain/widgets/dashboard_option.dart';
//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Dashboard',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 26,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurpleAccent,
//         elevation: 8,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade700],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: GridView.count(
//             crossAxisCount: 2,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//             childAspectRatio: 1.2,
//             children: [
//               _buildDashboardOption(
//                 context,
//                 iconPath: 'images/supplier.png',
//                 title: 'Add Supplier',
//                 routeName: '/supplier',
//               ),
//               _buildDashboardOption(
//                 context,
//                 iconPath: 'images/rawmaterial.png',
//                 title: 'Add RawMaterial',
//                 routeName: '/rawmaterial',
//               ),
//               _buildDashboardOption(
//                 context,
//                 iconPath: 'images/procurement.png',
//                 title: 'Payment Info',
//                 routeName: '/paymentinfo',
//               ),
//               _buildDashboardOption(
//                 context,
//                 iconPath: 'images/stock.png',
//                 title: 'StockDetails',
//                 routeName: '/stock',
//               ),
//               _buildDashboardOption(
//                 context,
//                 iconPath: 'images/warestatus.png',
//                 title: 'WareHouse Status',
//                 routeName: '/warestatus',
//               ),
//               _buildDashboardOption(
//                 context,
//                 iconPath: 'images/menu.png',
//                 title: 'Menu Bar',
//                 routeName: '/menu',
//               ),
//               _buildDashboardOption(
//                 context,
//                 iconPath: 'images/employee.png',
//                 title: 'Employee List',
//                 routeName: '/employee',
//               ),
//               _buildDashboardOption(
//                 context,
//                 iconPath: 'images/scan.png',
//                 title: 'Scanner',
//                 routeName: '/scan',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDashboardOption(BuildContext context, {
//     required String iconPath,
//     required String title,
//     required String routeName,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, routeName);
//       },
//       child: Card(
//         color: Colors.white,
//         elevation: 8,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Positioned.fill(
//                 child: Image.asset(
//                   iconPath,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Container(
//                 color: Colors.black54,
//                 child: Center(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
