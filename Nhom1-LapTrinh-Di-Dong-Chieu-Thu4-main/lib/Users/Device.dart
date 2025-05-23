import 'package:code_baocao/Users/Detail_Device.dart';
import 'package:flutter/material.dart';

class EquipmentUserScreen extends StatelessWidget {
  const EquipmentUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              Text(
                "Danh sách thiết bị",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Text(
              //   "Theo dõi và quản lý các thiết bị thuê dễ dàng",
              //   style: TextStyle(color: Colors.grey),
              // ),
              // SizedBox(height: 16),

              // // Hình ảnh minh họa
              // Container(
              //   height: 180,
              //   decoration: BoxDecoration(
              //     color: Colors.blue[50],
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Center(
              //     child: Icon(Icons.devices, size: 80, color: Colors.blue),
              //   ),
              // ),
              // SizedBox(height: 16),

              // Danh sách thiết bị
              // Text(
              //   "Danh sách thiết bị",
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 8),
              _buildDeviceCard(
                context,
                "Laptop Dell",
                "Đang thuê",
                Icons.laptop,
                Colors.orange,
              ),
              _buildDeviceCard(
                context,
                "Máy chiếu Epson",
                "Đang thuê",
                Icons.tv,
                Colors.blue,
              ),
              // _buildDeviceCard(
              //   context,
              //   "Máy in Canon",
              //   "Hết hạn",
              //   Icons.print,
              //   Colors.red,
              // ),
            ],
          ),
        ),
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
        onTap:  () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeviceDetailPage()),
            );
          },// Ngăn chặn việc bấm vào toàn bộ ListTile
      ),
    );
  }
}
