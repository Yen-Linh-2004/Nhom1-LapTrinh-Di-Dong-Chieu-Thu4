import 'package:code_baocao/Users/Detail_Contract.dart';
import 'package:flutter/material.dart';

class ContractsScreen extends StatelessWidget {
  final List<Map<String, String>> contracts = [
    {"id": "HD001", "device": "Laptop Dell", "status": "Còn hiệu lực"},
    {"id": "HD002", "device": "Máy in Canon", "status": "Còn hiệu lực"},
    {"id": "HD003", "device": "Máy chiếu Epson", "status": "Hết hạn"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Danh sách hợp đồng:", 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10), // Thêm khoảng cách giữa tiêu đề và danh sách
          Expanded(
            child: ListView.builder(
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.assignment),
                    title: Text("Hợp đồng: ${contracts[index]["id"]}"),
                    subtitle: Text("Thiết bị: ${contracts[index]["device"]}"),
                    trailing: Text(
                      contracts[index]["status"]!,
                      style: TextStyle(
                        color: contracts[index]["status"] == "Còn hiệu lực" 
                          ? Colors.green 
                          : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContractDetailScreen()),
                      );
                    }
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
