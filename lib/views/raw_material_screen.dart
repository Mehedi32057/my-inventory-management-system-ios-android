// import 'package:flutter/material.dart';
// import 'package:nexchain/models/raw_material.dart';
// import 'package:nexchain/services/raw_material_service.dart';
//
// class RawMaterialList extends StatefulWidget {
//   @override
//   _RawMaterialListState createState() => _RawMaterialListState();
// }
//
// class _RawMaterialListState extends State<RawMaterialList> {
//   final RawMaterialService _rawMaterialService = RawMaterialService();
//   List<RawMaterial> _rawMaterials = [];
//   bool _isAddingNewRawMaterial = false;
//   final _formKey = GlobalKey<FormState>();
//   RawMaterial _newRawMaterial = RawMaterial();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadRawMaterials();
//   }
//
//   Future<void> _loadRawMaterials() async {
//     try {
//       final rawMaterials = await _rawMaterialService.getAllRawMaterials();
//       setState(() {
//         _rawMaterials = rawMaterials;
//       });
//     } catch (e) {
//       print('Error loading raw materials: $e');
//     }
//   }
//
//   void _toggleAddRawMaterial() {
//     setState(() {
//       _isAddingNewRawMaterial = !_isAddingNewRawMaterial;
//     });
//   }
//
//   void _submitNewRawMaterial() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       _rawMaterialService.addRawMaterial(_newRawMaterial).then((_) {
//         _loadRawMaterials();
//         _toggleAddRawMaterial();
//       }).catchError((error) {
//         print('Error adding raw material: $error');
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Raw Materials'),
//       ),
//       body: _isAddingNewRawMaterial
//           ? _buildAddRawMaterialForm()
//           : _buildRawMaterialList(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _toggleAddRawMaterial,
//         child: Icon(_isAddingNewRawMaterial ? Icons.cancel : Icons.add),
//       ),
//     );
//   }
//
//   Widget _buildRawMaterialList() {
//     return ListView.builder(
//       itemCount: _rawMaterials.length,
//       itemBuilder: (context, index) {
//         final rawMaterial = _rawMaterials[index];
//         return Card(
//           elevation: 3,
//           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           child: ListTile(
//             title: Text(
//               rawMaterial.materialName ?? '',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(rawMaterial.materialType ?? ''),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 // Implement delete functionality
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildAddRawMaterialForm() {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Material Name'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a material name';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 _newRawMaterial.materialName = value;
//               },
//             ),
//             SizedBox(height: 16),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Material Type'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a material type';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 _newRawMaterial.materialType = value;
//               },
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submitNewRawMaterial,
//               child: Text('Add Raw Material'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//new code

import 'package:flutter/material.dart';
import 'package:nexchain/models/raw_material.dart';
import 'package:nexchain/services/raw_material_service.dart';

class RawMaterialList extends StatefulWidget {
  @override
  _RawMaterialListState createState() => _RawMaterialListState();
}

class _RawMaterialListState extends State<RawMaterialList> {
  final RawMaterialService _rawMaterialService = RawMaterialService();
  List<RawMaterial> _rawMaterials = [];
  bool _isAddingNewRawMaterial = false;
  final _formKey = GlobalKey<FormState>();
  RawMaterial _newRawMaterial = RawMaterial();

  @override
  void initState() {
    super.initState();
    _loadRawMaterials();
  }

  Future<void> _loadRawMaterials() async {
    try {
      final rawMaterials = await _rawMaterialService.getAllRawMaterials();
      setState(() {
        _rawMaterials = rawMaterials;
      });
    } catch (e) {
      print('Error loading raw materials: $e');
    }
  }

  void _toggleAddRawMaterial() {
    setState(() {
      _isAddingNewRawMaterial = !_isAddingNewRawMaterial;
    });
  }

  void _submitNewRawMaterial() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _rawMaterialService.addRawMaterial(_newRawMaterial).then((_) {
        _loadRawMaterials();
        _toggleAddRawMaterial();
      }).catchError((error) {
        print('Error adding raw material: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Raw Materials',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: _isAddingNewRawMaterial
          ? _buildAddRawMaterialForm()
          : _buildRawMaterialList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleAddRawMaterial,
        child: Icon(_isAddingNewRawMaterial ? Icons.cancel : Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  Widget _buildRawMaterialList() {
    return ListView.builder(
      itemCount: _rawMaterials.length,
      itemBuilder: (context, index) {
        final rawMaterial = _rawMaterials[index];
        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(
              rawMaterial.materialName ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.teal,
              ),
            ),
            subtitle: Text(
              rawMaterial.materialType ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Implement delete functionality
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddRawMaterialForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Material Name',
                labelStyle: TextStyle(color: Colors.teal),
                filled: true,
                fillColor: Colors.teal.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a material name';
                }
                return null;
              },
              onSaved: (value) {
                _newRawMaterial.materialName = value;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Material Type',
                labelStyle: TextStyle(color: Colors.teal),
                filled: true,
                fillColor: Colors.teal.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a material type';
                }
                return null;
              },
              onSaved: (value) {
                _newRawMaterial.materialType = value;
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitNewRawMaterial,
              child: Text('Add Raw Material'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
