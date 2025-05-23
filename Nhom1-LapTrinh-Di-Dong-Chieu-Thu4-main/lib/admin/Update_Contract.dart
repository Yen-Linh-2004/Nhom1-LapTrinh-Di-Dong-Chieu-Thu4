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
    tenantController = TextEditingController(text: contract["tenantName"]);
    ownerController = TextEditingController(text: contract["ownerName"]);
    equipmentController = TextEditingController(text: contract["equipment"]);
    startDateController = TextEditingController(text: contract["startDate"]);
    endDateController = TextEditingController(text: contract["endDate"]);
    costController = TextEditingController(text: contract["cost"]);
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
      backgroundColor: Color(0xFFF4F6F8),
      appBar: AppBar(
        title: Text("Cập nhật hợp đồng", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.blue,
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: () => Navigator.pop(context),
      ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("Thông tin chung"),
                  _buildTextField("Mã hợp đồng", contract['contractId']!, enabled: false),
                  _buildTextField("Đơn vị thuê", tenantController),
                  _buildTextField("Chủ hợp đồng", ownerController),
                  _buildTextField("Thiết bị thuê", equipmentController),
                  _buildTextField("Ngày bắt đầu", startDateController),
                  _buildTextField("Ngày kết thúc", endDateController),
                  _buildTextField("Chi phí", costController, isMoney: true),

                  SizedBox(height: 16),
                  _sectionTitle("Điều khoản"),
                  _buildMultilineTextField("Điều khoản hợp đồng", allTermsController),

                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: saveContract,
                      icon: Icon(Icons.save_alt, color: Colors.white),
                      label: Text("Lưu hợp đồng", style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildMultilineTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.all(14),
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

  Widget _buildTextField(String label, dynamic controller,
      {bool enabled = true, bool isMoney = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller is TextEditingController ? controller : null,
        enabled: enabled,
        keyboardType: isMoney ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: enabled ? Colors.grey[100] : Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.all(14),
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
