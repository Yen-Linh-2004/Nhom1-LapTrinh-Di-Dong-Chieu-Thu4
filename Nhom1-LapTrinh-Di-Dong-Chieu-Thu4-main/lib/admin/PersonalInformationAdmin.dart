import 'package:flutter/material.dart';

class EmployeeProfilePage extends StatelessWidget {
  final Map<String, String> employee = {
    "name": "Nguyễn Ngọc Thảo Vy",
    "position": "Quản lý",
    "email": "vynguyen@email.com",
    "phone": "0123 456 789",
    "avatar": "assets/images/anhNV1.jpg",
    "status": "Đang làm việc",
    "date": "09/02/1999",
    "address": "02 Nguyễn Quý Anh, Quận Tân Phú, TP.HCM",
    "gender": "Nữ",
    "joinDate": "12/04/2020",
    "salary": "12,000,000 VNĐ",
    "shift": "Cả ngày (08:00 - 18:00)",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình đại diện nhân viên
              Center(
                child: ClipOval(
                  child: Image.asset(
                    employee['avatar']!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Tên nhân viên và vị trí công việc
              Center(
                child: Text(
                  employee['name']!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Center(
                child: Text(
                  employee['position']!,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 30),
              // Card chứa thông tin chi tiết
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("Ngày sinh", employee['date']!),
                      _buildInfoRow("Giới tính", employee['gender']!),
                      _buildInfoRow("Địa chỉ", employee['address']!),
                      _buildInfoRow("Số điện thoại", employee['phone']!),
                      _buildInfoRow("Email", employee['email']!),
                      _buildInfoRow("Ngày vào làm", employee['joinDate']!),
                      _buildInfoRow("Lương", employee['salary']!),
                      _buildInfoRow("Ca làm việc", employee['shift']!),
                      _buildInfoRow("Trạng thái", employee['status']!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm hiển thị mỗi dòng thông tin
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
