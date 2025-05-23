import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController(text: "Nguyễn TRọng Yến Linh");
  TextEditingController emailController = TextEditingController(text: "yenlinh@gmail.com");
  TextEditingController phoneController = TextEditingController(text: "0123 456 789");
  
  DateTime selectedDate = DateTime(2004, 03, 09);
  String selectedGender = "Nữ";  
  File? _image;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa thông tin", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Ảnh đại diện
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null ? FileImage(_image!) : AssetImage("assets/images/image.png") as ImageProvider,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Họ và tên
            buildTextField("Họ và Tên", nameController, Icons.person),
            // Email
            buildTextField("Email", emailController, Icons.email),
            // Số điện thoại
            buildTextField("Số điện thoại", phoneController, Icons.phone),
            // Ngày sinh
            buildDateField(),
            // Giới tính
            buildGenderField(),
            SizedBox(height: 20),
            // Nút lưu thông tin
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Cập nhật thông tin
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Thông tin đã được cập nhật!")),
                  );
                },
                child: Text("Lưu thay đổi"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget buildDateField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        readOnly: true,
        controller: TextEditingController(text: DateFormat("dd/MM/yyyy").format(selectedDate)),
        decoration: InputDecoration(
          labelText: "Ngày sinh",
          prefixIcon: Icon(Icons.cake, color: Colors.blueAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.blueAccent),
            onPressed: () => _selectDate(context),
          ),
        ),
      ),
    );
  }

  Widget buildGenderField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        items: ["Nam", "Nữ"].map((gender) {
          return DropdownMenuItem(value: gender, child: Text(gender));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedGender = value!;
          });
        },
        decoration: InputDecoration(
          labelText: "Giới tính",
          prefixIcon: Icon(Icons.wc, color: Colors.blueAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
