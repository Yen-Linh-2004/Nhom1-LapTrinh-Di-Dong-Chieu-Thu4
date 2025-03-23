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
  FocusNode descriptionFocusNode = FocusNode(); // Thêm FocusNode để điều khiển focus

  final List<String> devices = ["Laptop Dell XPS 15", "Máy in HP LaserJet", "Máy chiếu Epson"];

  @override
  void dispose() {
    descriptionFocusNode.dispose(); // Giải phóng FocusNode khi không cần
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yêu cầu bảo trì"),
        backgroundColor: Colors.blueAccent,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Ẩn bàn phím khi bấm ra ngoài
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Chọn thiết bị
                      Text("Chọn thiết bị:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedDevice,
                        items: devices.map((String device) {
                          return DropdownMenuItem<String>(
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
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Nhập mô tả sự cố
                      Text("Mô tả sự cố:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      TextField(
                        controller: descriptionController,
                        focusNode: descriptionFocusNode, // Gán FocusNode vào TextField
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Nhập mô tả chi tiết...",
                          border: OutlineInputBorder(),
                        ),
                        onTap: () {
                          // Khi người dùng bấm vào, focus sẽ tự động mở bàn phím
                          descriptionFocusNode.requestFocus();
                        },
                      ),
                      SizedBox(height: 16),

                      // Chọn mức độ ưu tiên
                      Text("Mức độ ưu tiên:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Row(
                        children: ["Bình thường", "Cao", "Khẩn cấp"].map((level) {
                          return Expanded(
                            child: RadioListTile<String>(
                              title: Text(level),
                              value: level,
                              groupValue: priority,
                              onChanged: (value) {
                                setState(() {
                                  priority = value!;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),

                      // Nút gửi yêu cầu
                      Spacer(),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitRequest,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: Text("Gửi yêu cầu", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
   void _submitRequest() {
    if (selectedDevice == null || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!")),
      );
      return;
    }
    // Hiển thị thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đã gửi yêu cầu bảo trì thành công!")),
    );
    // Đặt lại dữ liệu sau 2 giây để tránh mất trạng thái ngay lập tức
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        selectedDevice = null;
        descriptionController.clear();
        priority = "";
      });
    });
  }

}
