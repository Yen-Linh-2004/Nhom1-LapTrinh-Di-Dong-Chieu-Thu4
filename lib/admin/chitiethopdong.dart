import 'package:code_baocao/admin/capnhathopdong.dart';
import 'package:flutter/material.dart';

class ContractDetailPage extends StatelessWidget {
  final Map<String, String> contract = {
    "contractId": "HD001",
    "tenantName": "Trường THPT Lê Quý Đôn",
    "ownerName": "Ông Trần Văn Tuấn",
    "equipment": "Máy chiếu Epson",
    "startDate": "01/03/2025",
    "endDate": "01/09/2025",
    "cost": "10,000,000 VNĐ",
    "warrantyTerms": "  - Bảo hành 6 tháng, không áp dụng nếu lỗi do người dùng.",
    "paymentTerms": "  - Thanh toán trước 50%, phần còn lại sau khi lắp đặt.",
    "contractTermination": "  - Chấm dứt hợp đồng phải thông báo trước 30 ngày.",
    "maintenanceSchedule":"  - Bảo trì mỗi 3 tháng, khách hàng chịu chi phí bảo trì.",
    "lateFeePolicy": "  - Phạt 5% nếu thanh toán chậm quá 7 ngày.",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết hợp đồng"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.article, color: Colors.blueAccent),
                    title: Text(
                      "Mã hợp đồng",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contract['contractId']!),
                  ),
                  ListTile(
                    leading: Icon(Icons.business, color: Colors.blueAccent),
                    title: Text(
                      "Đơn vị thuê",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contract['tenantName']!),
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.blueAccent),
                    title: Text(
                      "Chủ hợp đồng",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contract['ownerName']!),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.build, color: Colors.blueAccent),
                    title: Text(
                      "Thiết bị thuê",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contract['equipment']!),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      "Thời gian bắt đầu",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contract['startDate']!),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      "Thời gian kết thúc",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contract['endDate']!),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.attach_money, color: Colors.green),
                    title: Text(
                      "Chi phí",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                    subtitle: Text(
                      contract['cost']!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.security, color: Colors.blueAccent),
                    title: Text(
                      "Điều khoản hợp đồng",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${contract['warrantyTerms']}"),
                        Text("${contract['paymentTerms']}"),
                        Text("${contract['contractTermination']}", ),
                        Text("${contract['maintenanceSchedule']}"),
                        Text("${contract['lateFeePolicy']}"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateContractPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.check_circle),
                        label: Text("Cập nhật thông tin"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.picture_as_pdf),
                        label: Text("Tải PDF"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
