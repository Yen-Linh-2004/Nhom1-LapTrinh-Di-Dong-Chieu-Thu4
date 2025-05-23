import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MainScreen1 extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen1> {
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
      appBar: AppBar(
        title: Text(
          "Quản lý Doanh Thu và Phát Triển",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex], // Hiển thị màn hình theo lựa chọn
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.blueAccent),
            label: "Báo cáo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb, color: Colors.blueAccent),
            label: "Gợi ý",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}

// =================== Màn hình 1: Báo cáo Doanh Thu ===================
class RevenueReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Thống kê doanh thu",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Biểu đồ cột doanh thu
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
            SizedBox(height: 30),

            // Biểu đồ tròn
            Text(
              "Tỉ lệ doanh thu theo khu vực",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 40,
                        color: Colors.red,
                        title: 'Miền Bắc',
                        titleStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PieChartSectionData(
                        value: 30,
                        color: Colors.green,
                        title: 'Miền Trung',
                        titleStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PieChartSectionData(
                        value: 30,
                        color: Colors.blue,
                        title: 'Miền Nam',
                        titleStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chọn gợi ý phát triển",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Dropdown chọn hướng phát triển
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ), // Padding cho "Chọn gợi ý"
                  child: Text("Chọn gợi ý"),
                ),
                value: selectedSuggestion,
                items:
                    suggestions.keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(key),
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSuggestion = value;
                  });
                },
                style: TextStyle(fontSize: 16, color: Colors.black),
                underline: Container(), // Loại bỏ đường gạch dưới mặc định
              ),
            ),
            SizedBox(height: 20),
            // Hiển thị nội dung gợi ý đã chọn
            // Hiển thị nội dung gợi ý đã chọn
            if (selectedSuggestion != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ), // Padding cho nội dung gợi ý
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dòng "Mở rộng thị trường" với padding riêng
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ), // Padding cho dòng này
                        child: Text(
                          "Mở rộng thị trường",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Nội dung chi tiết gợi ý dưới đây
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ), // Padding cho nội dung
                        child: Text(
                          suggestions[selectedSuggestion!]!,
                          style: TextStyle(fontSize: 16),
                        ),
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
