import 'package:flutter/material.dart';

class AdminNotificationPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Thiết bị A cần bảo trì",
      "content": "Thiết bị A đã báo lỗi hoạt động quá mức, cần kiểm tra sớm.",
      "time": "5 phút trước",
      "icon": Icons.build,
      "isNew": true,
    },
    {
      "title": "Yêu cầu mới từ người dùng",
      "content": "Có yêu cầu kiểm tra thiết bị B từ khách hàng.",
      "time": "30 phút trước",
      "icon": Icons.assignment,
      "isNew": true,
    },
    {
      "title": "Cập nhật hệ thống",
      "content": "Hệ thống đã được cập nhật phiên bản 1.2.3.",
      "time": "Hôm qua",
      "icon": Icons.system_update,
      "isNew": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông báo hệ thống",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: item['isNew'] ? Colors.purple.shade50 : Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: Icon(item['icon'], color: Colors.deepPurple),
              ),
              title: Text(
                item['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: item['isNew'] ? Colors.deepPurple : Colors.black,
                ),
              ),
              subtitle: Text(item['content']),
              trailing: Text(
                item['time'],
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          );
        },
      ),
    );
  }
}
