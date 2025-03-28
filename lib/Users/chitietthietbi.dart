import 'package:code_baocao/Users/yeucaubaotri.dart';
import 'package:flutter/material.dart';

class DeviceDetailPage extends StatelessWidget {
  final String maThietBi = "TB001";
  final String tenThietBi = "Laptop Dell XPS 15";
  final String loaiThietBi = "Laptop";
  final String tinhTrang = "Đang cho thuê";
  final String thongSo = "CPU i7, RAM 16GB, SSD 512GB";
  final String hinhAnh = "assets/images/LaptopDELL_XPS.jpg";

  final List<Map<String, String>> lichSuChoThue = [
    {"ngay": "20/02/2024", "donVi": "Trường THCS B", "trangThai": "Đang thuê"},
    {"ngay": "10/03/2024", "donVi": "Trường THPT A", "trangThai": "Trả về"},
    {"ngay": "15/01/2024", "donVi": "Đại học C", "trangThai": "Trả về"},
  ];

  DeviceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết thiết bị"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        // 👉 Bọc toàn bộ nội dung để cuộn
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Bo góc ảnh
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            hinhAnh,
                            width: 400,
                            height: 300,
                            fit: BoxFit.cover, // Căn chỉnh ảnh vừa khít khung
                          ),
                        ),
                      ),

                      SizedBox(height: 16),
                      _buildInfoRow(Icons.tag, "Mã thiết bị", maThietBi),
                      _buildInfoRow(Icons.devices, "Tên thiết bị", tenThietBi),
                      _buildInfoRow(Icons.category, "Loại", loaiThietBi),
                      _buildStatusRow(Icons.warning, "Tình trạng", tinhTrang),
                      _buildInfoRow(Icons.memory, "Thông số", thongSo),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "📌 Lịch sử cho thuê:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 250, // Đặt chiều cao cố định cho danh sách
                child: ListView.builder(
                  shrinkWrap: true,
                  physics:
                      AlwaysScrollableScrollPhysics(), // Bật cuộn cho danh sách
                  itemCount: lichSuChoThue.length,
                  itemBuilder: (context, index) {
                    final item = lichSuChoThue[index];
                    return ListTile(
                      leading: Icon(Icons.history, color: Colors.blue),
                      title: Text("Đơn vị: ${item['donVi']}"),
                      subtitle: Text(
                        "Ngày: ${item['ngay']} - ${item['trangThai']}",
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MaintenanceRequestPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text("Yêu cầu bảo trì / Trả thiết bị"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 10),
          Text("$label:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          Expanded(child: Text(value, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildStatusRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent),
          SizedBox(width: 10),
          Text("$label:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
