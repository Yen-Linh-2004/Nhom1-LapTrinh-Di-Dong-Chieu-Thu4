import 'package:flutter/material.dart';

class EmployeeListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> employees = [
    {
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
    },
    {
      "name": "Trần Văn Thanh",
      "position": "Nhân viên bán hàng",
      "email": "tranthanh@email.com",
      "phone": "0987 654 321",
      "avatar": "assets/images/anhNV2.jpg",
      "status": "Đang làm việc",
      "date": "01/11/2002",
      "address": "231 Quang Trung, Quận Gò Vấp, TP.HCM",
      "gender": "Nam",
      "joinDate": "12/04/2023",
      "salary": "10,000,000 VNĐ",
      "shift": "Cả ngày (08:00 - 18:00)",
    },
    {
      "name": "Lê Thanh Nhã",
      "position": "Kế toán",
      "email": "lethanhnha@email.com",
      "phone": "0345 678 901",
      "avatar": "assets/images/anhNV3.jpg",
      "status": "Nghỉ việc",
      "date": "21/01/2000",
      "address": "01 Trường Trinh, Quận Tân Phú, TP.HCM",
      "gender": "Nữ",
      "joinDate": "12/04/2020",
      "salary": "14,000,000 VNĐ",
      "shift": "Cả ngày (08:00 - 18:00)",
    },
    {
      "name": "Nguyễn Tấn Vương",
      "position": "Sale",
      "email": "tanvuongnguyen@email.com",
      "phone": "0345 678 901",
      "avatar": "assets/images/anhNV4.jpg",
      "status": "Đang làm việc",
      "date": "24/03/1995",
      "address": "243 Lê Trọng Tấn, Quận Tân Phú, TP.HCM",
      "gender": "Nam",
      "joinDate": "03/04/2025",
      "salary": "7,000,000 VNĐ",
      "shift": "Ca sáng (08:00 - 12:00)",
    },
    {
      "name": "Lê Thị Kiều Nhi",
      "position": "Kế toán",
      "email": "kieunhi@email.com",
      "phone": "0345 678 901",
      "avatar": "assets/images/anhNV5.jpg",
      "status": "Đang làm việc",
      "date": "15/08/1995",
      "address": "234 Trần Hưng Đạo, Quận 1, TP.HCM",
      "gender": "Nữ",
      "joinDate": "12/04/2020",
      "salary": "12,000,000 VNĐ",
      "shift": "Cả ngày (08:00 - 18:00)",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách nhân viên",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          return _buildEmployeeItem(context, employees[index]);
        },
      ),
    );
  }

  /// Widget hiển thị một nhân viên trong danh sách
  Widget _buildEmployeeItem(
    BuildContext context,
    Map<String, dynamic> employee,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: ListTile(
        leading: ClipOval(
          child: Image.asset(
            employee["avatar"],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          employee["name"],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(employee["position"]),
        onTap: () {
          _showEmployeeDetails(context, employee);
        },
      ),
    );
  }

  /// Hiển thị chi tiết nhân viên khi nhấn vào ListTile
  void _showEmployeeDetails(
    BuildContext context,
    Map<String, dynamic> employee,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  employee["avatar"],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                employee["name"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              _buildStatusBadge(employee["status"]),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildInfoTile(Icons.work, "Chức vụ", employee["position"]),
                _buildInfoTile(Icons.email, "Email", employee["email"]),
                _buildInfoTile(Icons.phone, "Số điện thoại", employee["phone"]),
                _buildInfoTile(Icons.cake, "Ngày sinh", employee["date"]),
                _buildInfoTile(Icons.home, "Địa chỉ", employee["address"]),
                _buildInfoTile(Icons.people, "Giới tính", employee["gender"]),
                _buildInfoTile(
                  Icons.access_time,
                  "Ngày vào làm",
                  employee["joinDate"],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Đóng", style: TextStyle(color: Colors.blueAccent)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  /// Widget hiển thị thông tin nhân viên trong popup
  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text("$label: $value", style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  /// Widget hiển thị trạng thái với badge màu sắc
  Widget _buildStatusBadge(String status) {
    bool isActive = status == "Đang làm việc";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isActive ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
