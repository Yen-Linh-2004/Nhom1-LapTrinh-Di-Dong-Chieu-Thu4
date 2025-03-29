import 'package:flutter/material.dart';

class UpdateContractPage extends StatefulWidget {
  @override
  _UpdateContractPageState createState() => _UpdateContractPageState();
}

class _UpdateContractPageState extends State<UpdateContractPage> {
  final _formKey = GlobalKey<FormState>();

  Map<String, String> contract = {
    "contractId": "HD001",
    "tenantName": "Trường THPT Lê Quý Đôn",
    "ownerName": "Ông Trần Văn Tuấn",
    "equipment": "Máy chiếu Epson",
    "startDate": "01/03/2025",
    "endDate": "01/09/2025",
    "cost": "10,000,000 VNĐ",
    "warrantyTerms": "- Bảo hành 6 tháng, không áp dụng nếu lỗi do người dùng.",
    "paymentTerms": "- Thanh toán trước 50%, phần còn lại sau khi lắp đặt.",
    "contractTermination": "- Chấm dứt hợp đồng phải thông báo trước 30 ngày.",
    "maintenanceSchedule": "- Bảo trì mỗi 3 tháng, khách hàng chịu chi phí bảo trì.",
    "lateFeePolicy": "- Phạt 5% nếu thanh toán chậm quá 7 ngày.",
  };

  late TextEditingController tenantController;
  late TextEditingController ownerController;
  late TextEditingController equipmentController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController costController;
  late TextEditingController allTermsController;

  @override
  void initState() {
    super.initState();

    // Khởi tạo các controller
    tenantController = TextEditingController(text: contract["tenantName"]);
    ownerController = TextEditingController(text: contract["ownerName"]);
    equipmentController = TextEditingController(text: contract["equipment"]);
    startDateController = TextEditingController(text: contract["startDate"]);
    endDateController = TextEditingController(text: contract["endDate"]);
    costController = TextEditingController(text: contract["cost"]);

    // Gộp tất cả điều khoản vào một TextField
    allTermsController = TextEditingController(
      text: "${contract["warrantyTerms"]}\n"
          "${contract["paymentTerms"]}\n"
          "${contract["contractTermination"]}\n"
          "${contract["maintenanceSchedule"]}\n"
          "${contract["lateFeePolicy"]}",
    );
  }

  @override
  void dispose() {
    tenantController.dispose();
    ownerController.dispose();
    equipmentController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    costController.dispose();
    allTermsController.dispose();
    super.dispose();
  }

  void saveContract() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        contract["tenantName"] = tenantController.text;
        contract["ownerName"] = ownerController.text;
        contract["equipment"] = equipmentController.text;
        contract["startDate"] = startDateController.text;
        contract["endDate"] = endDateController.text;
        contract["cost"] = costController.text;

        // Chia lại các điều khoản từ TextField duy nhất
        List<String> terms = allTermsController.text.split("\n");
        if (terms.length >= 5) {
          contract["warrantyTerms"] = terms[0];
          contract["paymentTerms"] = terms[1];
          contract["contractTermination"] = terms[2];
          contract["maintenanceSchedule"] = terms[3];
          contract["lateFeePolicy"] = terms[4];
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hợp đồng đã cập nhật thành công!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật hợp đồng"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Mã hợp đồng", contract['contractId']!, enabled: false),
                    _buildTextField("Đơn vị thuê", tenantController),
                    _buildTextField("Chủ hợp đồng", ownerController),
                    _buildTextField("Thiết bị thuê", equipmentController),
                    _buildTextField("Ngày bắt đầu", startDateController),
                    _buildTextField("Ngày kết thúc", endDateController),
                    _buildTextField("Chi phí", costController, isMoney: true),
                    _buildMultilineTextField("Điều khoản hợp đồng", allTermsController),

                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: saveContract,
                      icon: Icon(Icons.save),
                      label: Text("Lưu thông tin"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMultilineTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        maxLines: null, // Không giới hạn số dòng
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Vui lòng nhập $label";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    dynamic controller, {
    bool enabled = true,
    bool isMoney = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller is TextEditingController ? controller : null,
        enabled: enabled,
        keyboardType: isMoney ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Vui lòng nhập $label";
          }
          return null;
        },
      ),
    );
  }
}
