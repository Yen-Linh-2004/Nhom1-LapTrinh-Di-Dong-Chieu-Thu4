import 'package:equipment_management/admin/chitietthietbi.dart';
import 'package:flutter/material.dart';

class EquipmentUserScreen extends StatefulWidget {
  const EquipmentUserScreen({super.key});

  @override
  _EquipmentUserScreenState createState() => _EquipmentUserScreenState();
}

class _EquipmentUserScreenState extends State<EquipmentUserScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  List<Map<String, dynamic>> devices = [
    {
      "name": "Laptop Dell",
      "status": "Đang thuê",
      "icon": Icons.laptop,
      "color": Colors.orange,
    },
    {
      "name": "Máy chiếu Epson",
      "status": "Đang thuê",
      "icon": Icons.tv,
      "color": Colors.blue,
    },
    {
      "name": "Máy in Canon",
      "status": "Hết hạn",
      "icon": Icons.print,
      "color": Colors.red,
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
            // Thanh tìm kiếm
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

            // Danh sách thiết bị
            Expanded(
              child: ListView(
                children:
                    devices
                        .where(
                          (device) => device["name"].toLowerCase().contains(
                            _searchText,
                          ),
                        )
                        .map(
                          (device) => _buildDeviceCard(
                            context,
                            device["name"],
                            device["status"],
                            device["icon"],
                            device["color"],
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),

      // Nút thêm thiết bị và nhập thiết bị
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: "btnAdd",
            onPressed: () {
              // Mở bottom sheet thêm thiết bị
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
              // Mở bottom sheet nhập thiết bị
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

  Widget _buildDeviceCard(
    BuildContext context,
    String name,
    String status,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 36),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Trạng thái: $status"),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor:
                status == "Đang thuê" ? Colors.orange : Colors.blue,
          ),
          child: Text(status == "Đang thuê" ? "Trả thiết bị" : "Thuê lại"),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeviceDetailPage()),
          );
        },
      ),
    );
  }

  // Hiển thị BottomSheet để thêm hoặc nhập thiết bị
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
              TextField(decoration: InputDecoration(labelText: "Trạng thái")),
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
