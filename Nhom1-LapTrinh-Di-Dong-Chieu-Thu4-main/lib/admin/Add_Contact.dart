import 'package:flutter/material.dart';
import 'package:code_baocao/model/database_helper.dart';
import 'package:code_baocao/model/Contact_db.dart';

class AddContractPage extends StatefulWidget {
  @override
  _AddContractPageState createState() => _AddContractPageState();
}

class _AddContractPageState extends State<AddContractPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController contractIdController = TextEditingController();
  final TextEditingController tenantController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController equipmentController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  final TextEditingController paymentTermsController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void dispose() {
    contractIdController.dispose();
    tenantController.dispose();
    ownerController.dispose();
    equipmentController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    costController.dispose();
    warrantyController.dispose();
    paymentTermsController.dispose();
    super.dispose();
  }

  Future<void> saveContract() async {
    if (_formKey.currentState!.validate()) {
      try {
        final hopDong = HopDong(
          maHD: contractIdController.text,
          tenDVThue: tenantController.text,
          maCHD: ownerController.text.isNotEmpty ? ownerController.text : null,
          ngayBD: startDateController.text.isNotEmpty ? startDateController.text : null,
          ngayKT: endDateController.text.isNotEmpty ? endDateController.text : null,
          thanhTien: double.tryParse(costController.text),
          trangThaiTT: paymentTermsController.text.isNotEmpty ? paymentTermsController.text : null,
          maNV: 'NV001', // Replace with logged-in user's MaND
          ngayTT: null,
          diaChiThue: null,
        );

        await _dbHelper.insertHopDong(hopDong.toMap());

        // Save equipment to CHITIETHD if provided
        if (equipmentController.text.isNotEmpty) {
          await _dbHelper.insertChiTietHD({
            'MaHD': contractIdController.text,
            'MaTB': equipmentController.text, // Assumes equipmentController.text is MaTB
            'SoLuong': 1, // Add a field for quantity if needed
            'DonGia': double.tryParse(costController.text),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hợp đồng đã được thêm thành công!")),
        );

        contractIdController.clear();
        tenantController.clear();
        ownerController.clear();
        equipmentController.clear();
        startDateController.clear();
        endDateController.clear();
        costController.clear();
        warrantyController.clear();
        paymentTermsController.clear();

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi khi lưu hợp đồng: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thêm Hợp Đồng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
                    _buildTextField("Mã hợp đồng", contractIdController),
                    _buildTextField("Đơn vị thuê", tenantController),
                    _buildTextField("Chủ hợp đồng", ownerController),
                    _buildTextField("Thiết bị thuê", equipmentController),
                    _buildTextField("Ngày bắt đầu (YYYY-MM-DD)", startDateController),
                    _buildTextField("Ngày kết thúc (YYYY-MM-DD)", endDateController),
                    _buildTextField("Chi phí", costController, isMoney: true),
                    _buildTextField("Bảo hành", warrantyController),
                    _buildTextField1(
                      "Điều khoản thanh toán",
                      paymentTermsController,
                      maxLines: 3,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: saveContract,
                      icon: Icon(Icons.save),
                      label: Text("Lưu hợp đồng"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
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

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isMoney = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isMoney ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Vui lòng nhập $label";
          }
          if (isMoney && double.tryParse(value) == null) {
            return "Vui lòng nhập số hợp lệ";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextField1(
    String label,
    TextEditingController controller, {
    int maxLines = 3,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
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