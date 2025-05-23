import 'package:code_baocao/Users/MaintenanceRequired.dart';
import 'package:flutter/material.dart';

class DeviceDetailPage extends StatelessWidget {
  final Map<String, String> equipment = {
    'name': 'Máy chiếu Epson X300',
    'code': 'EQP001',
    'status': 'Đang hoạt động',
    'location': 'Phòng học 305',
    'specs':
        'Độ sáng: 3300 Lumens\nĐộ phân giải: XGA\nCổng kết nối: HDMI, VGA, USB',
    'warranty': 'Bảo hành đến: 01/09/2025',
    'lastMaintenance': '10/03/2025',
    'nextMaintenance': '10/06/2025',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F7),
      appBar: AppBar(
        title: Text("Chi tiết thiết bị"),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.teal.shade100,
                      child: Icon(
                        Icons.videocam,
                        size: 40,
                        color: Colors.teal[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      equipment['name']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      equipment['code']!,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 20),
                    _infoRow(
                      Icons.qr_code_2,
                      "Mã thiết bị",
                      equipment['code']!,
                    ),
                    _infoRow(
                      Icons.location_on,
                      "Vị trí",
                      equipment['location']!,
                    ),
                    _infoRow(
                      Icons.settings,
                      "Thông số kỹ thuật",
                      equipment['specs']!,
                    ),
                    _infoRow(
                      Icons.verified,
                      "Tình trạng",
                      equipment['status']!,
                      color: Colors.green,
                    ),
                    _infoRow(
                      Icons.security,
                      "Bảo hành",
                      equipment['warranty']!,
                    ),
                    _infoRow(
                      Icons.build,
                      "Lần bảo trì gần nhất",
                      equipment['lastMaintenance']!,
                    ),
                    _infoRow(
                      Icons.calendar_month,
                      "Lịch bảo trì tiếp theo",
                      equipment['nextMaintenance']!,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaintenanceRequestPage(),
                  ),
                );
              },
              icon: Icon(Icons.build_circle, color: Colors.white),
              label: Text("Gửi yêu cầu bảo trì", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical:18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color ?? Colors.teal),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
