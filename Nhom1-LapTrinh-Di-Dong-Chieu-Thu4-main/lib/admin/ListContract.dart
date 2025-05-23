import 'package:code_baocao/admin/Detail_Contact.dart';
import 'package:code_baocao/admin/Add_Contact.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ContractListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ContractListPageState createState() => _ContractListPageState();
}

class _ContractListPageState extends State<ContractListPage> {
  final List<Map<String, String>> contracts = [
    {"id": "001", "title": "Hợp đồng cho thuê máy lạnh", "status": "Đang thuê", "date": "12/03/2024"},
    {"id": "002", "title": "Hợp đồng cho thuê máy chiếu", "status": "Hết hạn", "date": "10/02/2024"},
    {"id": "003", "title": "Hợp đồng cho thuê thiết bị hỗ trợ giảng dạy", "status": "Hủy", "date": "01/01/2024"},
  ];

  String selectedFilter = "Tất cả";
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> getFilteredContracts() {
    return contracts.where((contract) {
      bool matchesFilter = selectedFilter == "Tất cả" || contract["status"] == selectedFilter;
      bool matchesSearch = contract["title"]!.toLowerCase().contains(searchController.text.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Danh sách hợp đồng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Tìm kiếm hợp đồng...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["Tất cả", "Đang thuê", "Hết hạn", "Hủy"].map((filter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: selectedFilter == filter,
                      selectedColor: Colors.blueAccent,
                      onSelected: (selected) {
                        setState(() => selectedFilter = filter);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: getFilteredContracts().length,
                itemBuilder: (context, index) {
                  final contract = getFilteredContracts()[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(contract["id"]!)),
                      title: Text(contract["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Ngày ký: ${contract["date"]}\nTrạng thái: ${contract["status"]}"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContractDetailPage(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContractPage()),
          );
        },
        child: Icon(Icons.add), // Di chuyển child vào đúng vị trí
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
