import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MaintenanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bảo trì"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Phản hồi"),
              Tab(text: "Quy trình"),
              Tab(text: "Nhận bảo trì"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FeedbackScreen(),
            ProcessScreen(),
            ReceivedMaintenanceScreen(),
          ],
        ),
      ),
    );
  }
}

class FeedbackScreen extends StatelessWidget {
  final List<Map<String, dynamic>> feedbacks = [
    {"name": "Học sinh A", "comment": "Thiết bị bị lỗi màn hình.", "rating": 4},
    {"name": "Giáo viên B", "comment": "Máy in không hoạt động.", "rating": 2},
    {
      "name": "Hiệu trưởng C",
      "comment": "Hệ thống mạng bị chập chờn.",
      "rating": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              var feedback = feedbacks[index];
              return ListTile(
                title: Text(feedback["name"]),
                subtitle: Text(feedback["comment"]),
                trailing: Text("⭐ ${feedback["rating"]}/5"),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProcessScreen extends StatefulWidget {
  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  TextEditingController _deviceController = TextEditingController();
  Map<String, bool> conditions = {
    "Xác minh lỗi thiết bị": false,
    "Kiểm tra phụ tùng thay thế": false,
    "Lập kế hoạch sửa chữa": false,
    "Xác nhận từ quản lý": false,
  };

  void _toggleCondition(String key) {
    setState(() {
      if (!conditions.containsKey(key)) {
        conditions[key] = false;
      }
      conditions[key] = !conditions[key]!;
    });
  }

  bool get _canReceiveMaintenance {
    return conditions.values.every((e) => e);
  }

  @override
  Widget build(BuildContext context) {
    var maintenanceProvider = Provider.of<MaintenanceProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _deviceController,
            decoration: InputDecoration(
              labelText: "Tên thiết bị",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children:
                conditions.keys.map((key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: conditions[key],
                    onChanged: (bool? value) {
                      _toggleCondition(key);
                    },
                  );
                }).toList(),
          ),
        ),
        ElevatedButton(
          onPressed:
              _canReceiveMaintenance
                  ? () {
                    maintenanceProvider.addMaintenance(_deviceController.text);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Đã nhận bảo trì!")));
                  }
                  : null,
          child: Text("Nhận bảo trì"),
        ),
      ],
    );
  }
}

class ReceivedMaintenanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var maintenanceProvider = Provider.of<MaintenanceProvider>(context);
    return ListView.builder(
      itemCount: maintenanceProvider.maintenanceList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(maintenanceProvider.maintenanceList[index]),
          subtitle: Text("Trạng thái: Đang xử lý"),
        );
      },
    );
  }
}

class MaintenanceProvider extends ChangeNotifier {
  List<String> _maintenanceList = [];

  List<String> get maintenanceList => _maintenanceList;

  void addMaintenance(String device) {
    _maintenanceList.add(device);
    notifyListeners();
  }
}
