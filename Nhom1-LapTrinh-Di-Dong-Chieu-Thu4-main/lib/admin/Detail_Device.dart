import 'package:flutter/material.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        title: Text(
          "Chi tiết thiết bị",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  hinhAnh,
                  width: 400,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              _buildInfoRow("Mã thiết bị", maThietBi),
              _buildInfoRow("Tên thiết bị", tenThietBi),
              _buildInfoRow("Loại", loaiThietBi),
              _buildInfoRow("Tình trạng", tinhTrang),
              _buildInfoRow("Thông số", thongSo),
            ],
          ),
        ),
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
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInput("Tên thiết bị", nameController),
            SizedBox(height: 12),
            _buildInput("Loại thiết bị", typeController),
            SizedBox(height: 12),
            _buildInput("Tình trạng", statusController),
            SizedBox(height: 12),
            _buildInput("Thông số kỹ thuật", specController, maxLines: 3),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Xử lý cập nhật thiết bị
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Cập nhật thành công!")),
                  );
                },
                icon: Icon(Icons.save),
                label: Text(
                  "Lưu cập nhật",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildInput(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
