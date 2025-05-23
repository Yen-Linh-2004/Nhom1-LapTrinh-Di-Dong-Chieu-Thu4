import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> requests = [
    {
      'device': 'Laptop Dell',
      'issue': 'Màn hình bị nhòe',
      'status': 'Đang xử lý',
      'notes': 'Đang chờ linh kiện',
    },
    {
      'device': 'Máy in Canon',
      'issue': 'Không nhận giấy',
      'status': 'Đã hoàn thành',
      'notes': 'Thay bộ cuốn giấy',
    },
  ];
  final TextEditingController _statusController = TextEditingController();

  void _editRequest(int index) {
    TextEditingController notesController = TextEditingController(text: requests[index]['notes']);
    TextEditingController statusController = TextEditingController(text: requests[index]['status']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa yêu cầu bảo trì'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               DropdownButtonFormField<String>(
                value: _statusController.text.isEmpty ? null : _statusController.text,
                decoration: InputDecoration(labelText: 'Trạng thái'),
                items: ['Chờ xử lý', 'Đang xử lý', 'Hoàn thành']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _statusController.text = value!;
                  });
                },
              ),
              TextField(
                controller: notesController,
                decoration: InputDecoration(labelText: 'Ghi chú'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  requests[index]['status'] = statusController.text;
                  requests[index]['notes'] = notesController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông báo')),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(requests[index]['device']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sự cố: ${requests[index]['issue']}'),
                  Text('Trạng thái: ${requests[index]['status']}'),
                  Text('Ghi chú: ${requests[index]['notes']}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _editRequest(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
