import 'package:flutter/material.dart';

class ChatBoxScreen extends StatefulWidget {
  const ChatBoxScreen({super.key});

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}


class _ChatBoxScreenState extends State<ChatBoxScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {
      'sender': 'user',
      'text': 'Chào anh, máy chiếu không hoạt động.',
      'time': '10:30'
    },
    {
      'sender': 'admin',
      'text': 'Chào bạn, máy chiếu không lên hình hay có vấn đề khác?',
      'time': '10:31'
    },
    {
      'sender': 'user',
      'text': 'Máy chiếu không lên hình, chỉ có tiếng nhưng không có hình ảnh.',
      'time': '10:32'
    },
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        'sender': 'user',
        'text': _controller.text.trim(),
        'time': TimeOfDay.now().format(context)
      });
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      appBar: AppBar(
        title: const Text("Chat cùng SmartEduManage ", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A90E2),
       //leading: Icon(Icons.arrow_back_ios, color: Colors.white,),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['time'],
                          style: TextStyle(
                            fontSize: 11,
                            color: isUser ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Nhập nội dung...",
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF4A90E2)),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
