import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fl_chart/fl_chart.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Chuyển đổi giữa 2 màn hình
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Danh sách màn hình
  final List<Widget> _screens = [
    RevenueReportScreen(), // Màn hình báo cáo doanh thu
    DevelopmentSuggestionsScreen(), // Màn hình gợi ý phát triển
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Hiển thị màn hình theo lựa chọn
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Báo cáo",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "Gợi ý"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// =================== Màn hình 1: Báo cáo Doanh Thu ===================
class RevenueReportScreen extends StatelessWidget {
  const RevenueReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Báo cáo doanh thu")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thống kê doanh thu",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Biểu đồ cột doanh thu
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barGroups: [
                      BarChartGroupData(
                        x: 1,
                        barRods: [BarChartRodData(toY: 10, color: Colors.blue)],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [BarChartRodData(toY: 15, color: Colors.blue)],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [BarChartRodData(toY: 7, color: Colors.blue)],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Biểu đồ tròn
            Text(
              "Tỉ lệ doanh thu theo khu vực",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      color: Colors.red,
                      title: 'Miền Bắc',
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.green,
                      title: 'Miền Trung',
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.blue,
                      title: 'Miền Nam',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =================== Màn hình 2: Gợi ý Hướng Phát Triển ===================
class DevelopmentSuggestionsScreen extends StatefulWidget {
  const DevelopmentSuggestionsScreen({super.key});

  @override
  _DevelopmentSuggestionsScreenState createState() =>
      _DevelopmentSuggestionsScreenState();
}

class _DevelopmentSuggestionsScreenState
    extends State<DevelopmentSuggestionsScreen> {
  String? selectedSuggestion;

  // Gợi ý hướng phát triển
  final Map<String, String> suggestions = {
    "Mở rộng thị trường":
        "✅ Nghiên cứu thị trường mới tiềm năng\n"
        "✅ Mở rộng mạng lưới chi nhánh\n"
        "✅ Tăng cường hợp tác chiến lược\n"
        "✅ Đầu tư quảng cáo, tiếp cận khách hàng mới\n"
        "✅ Điều chỉnh sản phẩm phù hợp khu vực",

    "Cải thiện dịch vụ khách hàng":
        "✅ Hỗ trợ khách hàng 24/7\n"
        "✅ Đào tạo nhân viên chăm sóc khách hàng\n"
        "✅ Xử lý phản hồi khách hàng nhanh chóng\n"
        "✅ Chương trình ưu đãi khách hàng thân thiết\n"
        "✅ Sử dụng AI/Chatbot tối ưu hỗ trợ",

    "Tăng cường quảng bá":
        "✅ Marketing online qua Facebook, Google Ads, TikTok\n"
        "✅ Tạo nội dung hấp dẫn trên website & blog\n"
        "✅ Hợp tác với KOL để gia tăng nhận diện\n"
        "✅ Email marketing để giữ chân khách hàng\n"
        "✅ Tổ chức sự kiện, chương trình giảm giá",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gợi ý hướng phát triển")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chọn gợi ý phát triển",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Dropdown chọn hướng phát triển
            DropdownButton<String>(
              isExpanded: true,
              hint: Text("Chọn gợi ý"),
              value: selectedSuggestion,
              items:
                  suggestions.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(key),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSuggestion = value;
                });
              },
            ),
            SizedBox(height: 10),

            // Hiển thị nội dung gợi ý đã chọn
            if (selectedSuggestion != null)
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  suggestions[selectedSuggestion!]!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
