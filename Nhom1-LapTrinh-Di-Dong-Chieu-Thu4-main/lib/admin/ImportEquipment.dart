import 'package:flutter/material.dart';

class PhieuNhapScreen extends StatefulWidget {
  const PhieuNhapScreen({super.key});

  @override
  State<PhieuNhapScreen> createState() => _PhieuNhapScreenState();
}

class _PhieuNhapScreenState extends State<PhieuNhapScreen> {
  final List<Map<String, dynamic>> _devices = [
    {"name": "", "type": "", "quantity": 1},
  ];

  void _addNewDevice() {
    setState(() {
      _devices.add({"name": "", "type": "", "quantity": 1});
    });
  }

  void _removeDevice(int index) {
    setState(() {
      _devices.removeAt(index);
    });
  }

  void _submit() {
    // Xử lý logic lưu dữ liệu
    for (var d in _devices) {
      print("Tên: ${d['name']}, Loại: ${d['type']}, SL: ${d['quantity']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Phiếu nhập thiết bị",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.devices, color: Colors.blue),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Tên thiết bị",
                                  ),
                                  onChanged:
                                      (value) =>
                                          _devices[index]["name"] = value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.category, color: Colors.green),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Loại thiết bị",
                                  ),
                                  onChanged:
                                      (value) =>
                                          _devices[index]["type"] = value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.numbers, color: Colors.orange),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Số lượng",
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged:
                                      (value) =>
                                          _devices[index]["quantity"] =
                                              int.tryParse(value) ?? 0,
                                ),
                              ),
                              if (_devices.length > 1)
                                IconButton(
                                  onPressed: () => _removeDevice(index),
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _addNewDevice,
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Thêm thiết bị",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text(
                      "Xác nhận nhập",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
