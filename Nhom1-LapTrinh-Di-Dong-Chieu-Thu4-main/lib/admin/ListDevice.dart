import 'package:code_baocao/admin/Detail_Device.dart';
import 'package:code_baocao/admin/importEquipment.dart';
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
      "status": "Còn thiết bị",
      "image": "assets/images/LaptopDELL_XPS.jpg",
      "quantity": 5,
    },
    {
      "name": "Máy chiếu Epson",
      "status": "Còn thiết bị",
      "image": "assets/images/LaptopDELL_XPS.jpg",
      "quantity": 2,
    },
    {
      "name": "Máy in Canon",
      "status": "Hết thiết bị",
      "image": "assets/images/LaptopDELL_XPS.jpg",
      "quantity": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDevices =
        devices.where((device) {
          return device['name'].toLowerCase().contains(
            _searchText.toLowerCase(),
          );
        }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Quản lý thiết bị",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Tìm kiếm thiết bị...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDevices.length,
                itemBuilder: (context, index) {
                  final device = filteredDevices[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceDetailPage(),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          device["image"],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        device["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      device["status"] == "Còn thiết bị"
                                          ? Colors.green
                                          : Colors.red,
                                  size: 10,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  device["status"],
                                  style: TextStyle(
                                    color:
                                        device["status"] == "Còn thiết bị"
                                            ? Colors.green
                                            : Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text("Số lượng: ${device["quantity"]}"),
                          ],
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
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
            icon: const Icon(Icons.add),
            label: const Text("Thêm thiết bị"),
            backgroundColor: Colors.green,
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: "btnImport",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhieuNhapScreen()),
              );
            },
            icon: const Icon(Icons.file_upload),
            label: const Text("Nhập thiết bị"),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Tên thiết bị",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.devices),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Loại thiết bị",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.category),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Số lượng",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.confirmation_number),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Hủy"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Xác nhận"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
