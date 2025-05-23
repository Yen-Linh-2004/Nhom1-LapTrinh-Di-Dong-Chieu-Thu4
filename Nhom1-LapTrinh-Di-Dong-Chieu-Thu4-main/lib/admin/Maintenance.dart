import 'package:flutter/material.dart';

class MaintenanceRequest {
  String deviceName;
  String issue;
  bool isConfirmed;
  DateTime? scheduledDate;
  bool isCompleted;

  MaintenanceRequest({
    required this.deviceName,
    required this.issue,
    this.isConfirmed = false,
    this.scheduledDate,
    this.isCompleted = false,
  });
}

class MaintenanceFlowScreen extends StatefulWidget {
  @override
  _MaintenanceFlowScreenState createState() => _MaintenanceFlowScreenState();
}

class _MaintenanceFlowScreenState extends State<MaintenanceFlowScreen> {
  final List<MaintenanceRequest> _requests = [
    MaintenanceRequest(deviceName: "Máy chiếu", issue: "Không lên hình"),
    MaintenanceRequest(deviceName: "Máy tính", issue: "Không khởi động được"),
  ];

  void _confirmRequest(int index) {
    setState(() {
      _requests[index].isConfirmed = true;
    });
  }

  void _pickDate(int index) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );

    if (picked != null) {
      setState(() {
        _requests[index].scheduledDate = picked;
      });
    }
  }

  void _markCompleted(int index) {
    setState(() {
      _requests[index].isCompleted = true;
    });
  }

  Widget _buildStepCard(MaintenanceRequest request, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📦 Thiết bị: ${request.deviceName}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "⚠️ Vấn đề: ${request.issue}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),

            if (!request.isConfirmed)
              ElevatedButton.icon(
                onPressed: () => _confirmRequest(index),
                icon: Icon(Icons.check),
                label: Text("Xác nhận yêu cầu"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              )
            else if (request.scheduledDate == null)
              ElevatedButton.icon(
                onPressed: () => _pickDate(index),
                icon: Icon(Icons.calendar_month),
                label: Text("Chọn ngày bảo trì"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              )
            else if (!request.isCompleted)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📅 Ngày bảo trì: ${request.scheduledDate!.toLocal().toString().split(' ')[0]}",
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => _markCompleted(index),
                    icon: Icon(Icons.done_all),
                    label: Text("Đã bảo trì"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              )
            else
              Text(
                "✅ Đã hoàn thành bảo trì",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quy trình Bảo trì",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          return _buildStepCard(_requests[index], index);
        },
      ),
    );
  }
}
