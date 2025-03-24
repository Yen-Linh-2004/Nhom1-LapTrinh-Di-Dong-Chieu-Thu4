import 'package:flutter/material.dart';

class DeviceDetailPage extends StatefulWidget {
  @override
  _DeviceDetailPageState createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  int _currentIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết thiết bị"),
        backgroundColor: Colors.blueAccent,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildDeviceDetail(),
          _buildRentalHistory(),
          _buildUpdateDeviceForm(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Chi tiết"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Lịch sử"),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Cập nhật"),
        ],
      ),
    );
  }

  Widget _buildDeviceDetail() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(hinhAnh, width: 400, height: 300, fit: BoxFit.cover),
          SizedBox(height: 16),
          _buildInfoRow("Mã thiết bị", maThietBi),
          _buildInfoRow("Tên thiết bị", tenThietBi),
          _buildInfoRow("Loại", loaiThietBi),
          _buildInfoRow("Tình trạng", tinhTrang),
          _buildInfoRow("Thông số", thongSo),
        ],
      ),
    );
  }

  Widget _buildRentalHistory() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: lichSuChoThue.length,
      itemBuilder: (context, index) {
        final item = lichSuChoThue[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.history, color: Colors.blue),
            title: Text("Đơn vị: ${item['donVi']}"),
            subtitle: Text("Ngày: ${item['ngay']} - ${item['trangThai']}"),
          ),
        );
      },
    );
  }

  Widget _buildUpdateDeviceForm() {
    TextEditingController nameController = TextEditingController(
      text: tenThietBi,
    );
    TextEditingController typeController = TextEditingController(
      text: loaiThietBi,
    );
    TextEditingController statusController = TextEditingController(
      text: tinhTrang,
    );
    TextEditingController specController = TextEditingController(text: thongSo);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Tên thiết bị"),
          ),
          TextField(
            controller: typeController,
            decoration: InputDecoration(labelText: "Loại thiết bị"),
          ),
          TextField(
            controller: statusController,
            decoration: InputDecoration(labelText: "Tình trạng"),
          ),
          TextField(
            controller: specController,
            decoration: InputDecoration(labelText: "Thông số kỹ thuật"),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Xử lý cập nhật thiết bị
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Cập nhật thành công!")));
            },
            child: Text("Lưu cập nhật"),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          Expanded(child: Text(value, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
