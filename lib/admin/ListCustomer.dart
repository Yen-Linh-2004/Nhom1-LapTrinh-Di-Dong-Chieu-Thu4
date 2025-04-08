import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CustomerListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> customers = [
    {
      "name": "Nguyễn Vân Anh",
      "position": "Chủ hợp đồng (Hiệu trưởng)",
      "email": "vanthanh@email.com",
      "phone": "0912 345 678",
      "avatar": "assets/images/anhKH1.jpg",
      "IDContract": "HD001",
      "NameContract": "Trường THPT Lê Quý Đôn",
      "startDate": "01/03/2025",
      "endDate": "01/09/2025",
      "contractStatus": "Đang hiệu lực",
      "maintenanceStatus": "Chưa xử lý",
    },
    {
      "name": "Trần Thị Mỹ Dung",
      "position": "Người chịu trách nhiệm thiết bị (GVCN p104)",
      "email": "trandung@email.com",
      "phone": "0903 678 901",
      "avatar": "assets/images/anhKH2.jpg",
      "IDContract": "HD001",
      "NameContract": "Trường THPT Lê Quý Đôn",
      "startDate": "01/03/2025",
      "endDate": "01/09/2025",
      "contractStatus": "Hết hạn",
      "maintenanceStatus": "Đã hoàn thành",
    },
    {
      "name": "Lê Quốc Tuấn",
      "position": "Người chịu trách nhiệm thiết bị (Lớp phó p104)",
      "email": "quoctuan@email.com",
      "phone": "0987 654 321",
      "avatar": "assets/images/anhKH3.jpg",
      "IDContract": "HD001",
      "NameContract": "Trường THPT Lê Quý Đôn",
      "startDate": "01/03/2025",
      "endDate": "01/09/2025",
      "contractStatus": "Đang hiệu lực",
      "maintenanceStatus": "Đang xử lý",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách khách hàng"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.separated(
        itemCount: customers.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final customer = customers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(customer["avatar"] ?? "assets/images/default_avatar.png"),
              radius: 25,
            ),
            title: Text(
              customer["name"] ?? "Chưa có tên",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("📧 ${customer["position"] ?? "Không có chức vụ nào"}"),
                 SizedBox(height: 5),
              ],
             ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () => _showCustomerDetails(context, customer),
          );
        },
      ),
    );
  }

  // ignore: unused_element
  Color _getMaintenanceColor(String? status) {
    switch (status) {
      case "Chưa xử lý":
        return Colors.red;
      case "Đang xử lý":
        return Colors.orange;
      case "Đã hoàn thành":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

// chi tiết khách hàng
  void _showCustomerDetails(
    BuildContext context,
    Map<String, dynamic> customer,
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
                  customer["avatar"] ?? "assets/images/default_avatar.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                customer["name"] ?? "Không có tên",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                customer["position"] ?? "Không có vị trí",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoTile(
                  Icons.email,
                  "Email",
                  customer["email"] ?? "Không có email",
                ),
                _buildInfoTile(
                  Icons.phone,
                  "Số điện thoại",
                  customer["phone"] ?? "Không có số",
                ),
                Divider(),
                _buildInfoTile(
                  Icons.assignment,
                  "Mã hợp đồng",
                  customer["IDContract"] ?? "Không có hợp đồng",
                ),
                _buildInfoTile(
                  Icons.business,
                  "Tên hợp đồng",
                  customer["NameContract"] ?? "Không có thông tin",
                ),
                _buildInfoTile(
                  Icons.date_range,
                  "Ngày bắt đầu",
                  customer["startDate"] ?? "Không xác định",
                ),
                _buildInfoTile(
                  Icons.event,
                  "Ngày kết thúc",
                  customer["endDate"] ?? "Không xác định",
                ),
                _buildInfoTile(
                  Icons.description,
                  "Trạng thái hợp đồng",
                  customer["contractStatus"] ?? "Không xác định",
                ),
                Divider(),
                _buildInfoTile(
                  Icons.build,
                  "Trạng thái bảo trì",
                  customer["maintenanceStatus"] ?? "Không có dữ liệu",
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

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title: $value",
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
