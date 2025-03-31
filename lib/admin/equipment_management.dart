// ignore_for_file: unused_field

import 'package:code_baocao/admin/chitietthietbi.dart';
import 'package:flutter/material.dart';

class EquipmentUserScreen extends StatefulWidget {
  const EquipmentUserScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EquipmentUserScreenState createState() => _EquipmentUserScreenState();
}

class _EquipmentUserScreenState extends State<EquipmentUserScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  int? _selectedIndex;

  List<Map<String, dynamic>> devices = [
    {
      "name": "Laptop Dell",
      "status": "Đang thuê",
      "image": "assets/images/LaptopDELL_XPS.jpg",
      "quantity": 5,
    },
    {
      "name": "Máy chiếu Epson",
      "status": "Đang thuê",
      "image": "assets/images/LaptopDELL_XPS.jpg",
      "quantity": 2,
    },
    {
      "name": "Máy in Canon",
      "status": "Hết hạn",
      "image": "assets/images/LaptopDELL_XPS.jpg",
      "quantity": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Quản lý thiết bị"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Tìm kiếm thiết bị...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceDetailPage(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio(
                              value: index,
                              groupValue: _selectedIndex,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedIndex = value;
                                });
                              },
                            ),
                            Image.asset(
                              device["image"],
                              width: 200,
                              height: 200,
                            ),
                          ],
                        ),
                        title: Text(
                          device["name"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Trạng thái: ${device["status"]}"),
                            Text("Số lượng: ${device["quantity"]}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: "btnAdd",
            onPressed: () {
              _showBottomSheet(context, "Thêm thiết bị");
            },
            icon: Icon(Icons.add),
            label: Text("Thêm thiết bị"),
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: "btnImport",
            onPressed: () {
              _showBottomSheet(context, "Nhập thiết bị");
            },
            icon: Icon(Icons.file_upload),
            label: Text("Nhập thiết bị"),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: "Tên thiết bị")),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: "Loại thiết bị"),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: "Số lượng"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Hủy"),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Xác nhận")),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}