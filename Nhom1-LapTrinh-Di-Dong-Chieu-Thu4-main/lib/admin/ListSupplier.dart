import 'package:flutter/material.dart';

class SupplierListScreen extends StatefulWidget {
  @override
  _SupplierListScreenState createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  List<Map<String, dynamic>> suppliers = [
    {
      "name": "Nhà cung cấp thiết bị An Lạc Phát",
      "logo": "assets/images/logo_AnLacPhat.jpg",
      "phone": "0123 456 789",
      "status": "Đang hoạt động",
      "address": "123 Đường Nguyễn Văn A, Quận 1, TP.HCM",
      "email": "anlacphat@gmail.com",
      "products": "Điều hòa, máy chiếu, máy lọc nước",
      "workingHours": "08:00 - 18:00 (Thứ 2 - Thứ 7)",
    },
    {
      "name": "Công ty cung cấp thiết bị HandyGoods",
      "logo": "assets/images/logo_HandyGoods.jpg",
      "phone": "0987 654 321",
      "status": "Ngừng hoạt động",
      "address": "456 Đường Trần Bình, Quận 5, TP.HCM",
      "email": "minhhieu@hmail.com",
      "products":
          "Bảng tương tác thông minh, Camera ghi hình bài giảng, Micro không dây, hệ thống âm thanh",
      "workingHours": "09:00 - 17:00 (Thứ 2 - Thứ 6)",
    },
    {
      "name": "Công ty TNHH Minh Hiếu VN",
      "logo": "assets/images/Logo_MinhHieu.jpg",
      "phone": "0357 123 456",
      "status": "Đang hoạt động",
      "address": "456 Đường Trần Bình, Quận 5, TP.HCM",
      "email": "minhhieu@hmail.com",
      "products":
          "Kính hiển vi, Thiết bị thí nghiệm (hóa học, vật lý, sinh học), Bộ thí nghiệm STEM",
      "workingHours": "09:00 - 17:00 (Thứ 2 - Thứ 6)",
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách nhà cung cấp",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm nhà cung cấp...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: suppliers.length,
              itemBuilder: (context, index) {
                final supplier = suppliers[index];

                // Lọc danh sách dựa trên từ khóa tìm kiếm
                if (!supplier["name"].toLowerCase().contains(searchQuery)) {
                  return SizedBox.shrink();
                }

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      _showSupplierDetails(supplier);
                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          supplier["logo"],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        supplier["name"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("📞 ${supplier["phone"]}"),
                      
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSupplierDetails(Map<String, dynamic> supplier) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  supplier["logo"],
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                supplier["name"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(),
                _buildInfoTile(
                  Icons.location_on,
                  "Địa chỉ",
                  supplier["address"],
                ),
                _buildInfoTile(Icons.phone, "Số điện thoại", supplier["phone"]),
                _buildInfoTile(Icons.email, "Email", supplier["email"]),
                _buildInfoTile(
                  Icons.shopping_cart,
                  "Sản phẩm",
                  supplier["products"],
                ),
                _buildInfoTile(
                  Icons.access_time,
                  "Giờ làm việc",
                  supplier["workingHours"],
                ),
                SizedBox(height: 10),
                _buildStatusBadge(supplier["status"]),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Đóng", style: TextStyle(color: Colors.blueAccent)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  /// Widget hiển thị từng dòng thông tin với biểu tượng
  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text("$label: $value", style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  /// Hiển thị trạng thái với badge màu sắc
  Widget _buildStatusBadge(String status) {
    bool isActive = status == "Đang hoạt động";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isActive ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
