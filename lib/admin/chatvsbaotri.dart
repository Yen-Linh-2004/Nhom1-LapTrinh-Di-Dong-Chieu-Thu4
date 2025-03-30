import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [ChatScreen(), MaintenanceScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Bảo trì'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, String>> _faq = [
    {
      'question': 'Làm thế nào để đặt lịch bảo trì?',
      'answer':
          'Bạn có thể liên hệ qua hotline hoặc gửi yêu cầu trên ứng dụng.',
    },
    {
      'question': 'Thời gian bảo trì trung bình là bao lâu?',
      'answer': 'Tùy vào loại thiết bị, thông thường mất từ 30 phút đến 2 giờ.',
    },
    {
      'question': 'Chi phí bảo trì được tính như thế nào?',
      'answer':
          'Chi phí dựa trên loại bảo trì, thiết bị và các linh kiện thay thế nếu có.',
    },
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản lý hội thoại')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder:
                  (context, index) => ListTile(title: Text(_messages[index])),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _faq.length,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(_faq[index]['question']!),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text(_faq[index]['question']!),
                              content: Text(_faq[index]['answer']!),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Đóng'),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Nhập tin nhắn...'),
                  ),
                ),
                IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MaintenanceScreen extends StatelessWidget {
  final List<Map<String, String>> maintenanceRequests = [
    {
      'device': 'Máy lạnh',
      'issue': 'Quạt gió không hoạt động',
      'staff': 'Nguyễn Văn A',
      'requester': 'Giáo viên',
      'process':
          '1. Kiểm tra nguồn điện.\n2. Kiểm tra quạt gió.\n3. Vệ sinh và bôi trơn.\n4. Kiểm tra lại sau bảo trì.',
    },
    {
      'device': 'Máy in',
      'issue': 'Kẹt giấy liên tục',
      'staff': 'Trần Văn B',
      'requester': 'Học sinh',
      'process':
          '1. Kiểm tra khay giấy.\n2. Làm sạch con lăn.\n3. Reset máy in.\n4. Thử in lại.',
    },
    {
      'device': 'Máy tính',
      'issue': 'Không thể khởi động',
      'staff': 'Lê Thị C',
      'requester': 'Hiệu trưởng',
      'process':
          '1. Kiểm tra nguồn điện.\n2. Thử khởi động an toàn.\n3. Kiểm tra ổ cứng.\n4. Cài đặt lại hệ điều hành nếu cần.',
    },
    {
      'device': 'Máy chiếu',
      'issue': 'Hình ảnh bị nhòe',
      'staff': 'Phạm Văn D',
      'requester': 'Giáo viên',
      'process':
          '1. Kiểm tra ống kính.\n2. Điều chỉnh tiêu cự.\n3. Kiểm tra nguồn cấp.\n4. Thay bóng đèn nếu cần.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách yêu cầu bảo trì')),
      body: ListView.builder(
        itemCount: maintenanceRequests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(maintenanceRequests[index]['device']!),
            subtitle: Text(
              'Vấn đề: ${maintenanceRequests[index]['issue']}\nNgười yêu cầu: ${maintenanceRequests[index]['requester']}',
            ),
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text(maintenanceRequests[index]['device']!),
                      content: Text(
                        'Vấn đề: ${maintenanceRequests[index]['issue']}\nNgười yêu cầu: ${maintenanceRequests[index]['requester']}\nNhân viên bảo trì: ${maintenanceRequests[index]['staff']}\nQuy trình bảo trì:\n${maintenanceRequests[index]['process']}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Đóng'),
                        ),
                      ],
                    ),
              );
            },
          );
        },
      ),
    );
  }
}