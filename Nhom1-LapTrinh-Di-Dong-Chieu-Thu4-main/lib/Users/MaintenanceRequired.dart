import 'package:flutter/material.dart';

class MaintenanceRequestPage extends StatefulWidget {
  const MaintenanceRequestPage({super.key});

  @override
  _MaintenanceRequestPageState createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  String? selectedDevice;
  String priority = "Bình thường";
  TextEditingController descriptionController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();

  final List<String> devices = [
    "Laptop Dell XPS 15",
    "Máy in HP LaserJet",
    "Máy chiếu Epson"
  ];

  @override
  void dispose() {
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text("Yêu cầu bảo trì", style: TextStyle(color:Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề
                  const Text(
                    "Thông tin thiết bị",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Dropdown chọn thiết bị
                  DropdownButtonFormField<String>(
                    value: selectedDevice,
                    items: devices.map((device) {
                      return DropdownMenuItem(
                        value: device,
                        child: Text(device),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDevice = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Chọn thiết bị",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mô tả sự cố
                  const Text(
                    "Mô tả sự cố",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    focusNode: descriptionFocusNode,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Nhập mô tả chi tiết...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mức độ ưu tiên
                  const Text(
                    "Mức độ ưu tiên",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 15,
                    children: ["Bình thường", "Cao", "Khẩn cấp"].map((level) {
                      return ChoiceChip(
                        label: Text(level),
                        selected: priority == level,
                        selectedColor: Colors.orangeAccent,
                        onSelected: (_) {
                          setState(() => priority = level);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),

                  // Gửi yêu cầu
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send, color: Colors.white),
                      label: const Text("Gửi yêu cầu", style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical:18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _submitRequest,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (selectedDevice == null || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đã gửi yêu cầu bảo trì thành công!")),
    );

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        selectedDevice = null;
        descriptionController.clear();
        priority = "Bình thường";
      });
    });
  }
}
