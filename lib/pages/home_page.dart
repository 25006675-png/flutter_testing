import 'package:flutter/material.dart';
// Import the service we just created
import 'package:flutter_template/services/gemini_service.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; 
  bool _loading = false;

  // No more API Key or HTTP logic here!

  Future<void> sendMessage(String prompt) async {
    if (prompt.trim().isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": prompt});
      _loading = true;
    });

    try {
      // ONE LINE: Ask the service for the answer
      final String reply = await GeminiService().sendMessage(prompt);

      setState(() {
        _messages.add({"role": "assistant", "text": reply});
      });
      
    } catch (e) {
      setState(() {
        _messages.add({"role": "assistant", "text": e.toString()});
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  // No more _extractReplyFromResponse function needed here!

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMessage(Map<String, String> msg) {
    final bool isUser = msg["role"] == "user";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(msg["text"] ?? "", style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Chat (Gemini)")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, i) => _buildMessage(_messages[i]),
              ),
            ),
            if (_loading)
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  "Waiting for AI...",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) {
                        final t = value.trim();
                        if (t.isNotEmpty) {
                          _controller.clear();
                          sendMessage(t);
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _loading
                        ? null
                        : () {
                            final text = _controller.text.trim();
                            if (text.isEmpty) return;
                            _controller.clear();
                            sendMessage(text);
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}