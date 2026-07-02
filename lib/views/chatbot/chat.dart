import 'package:flutter/material.dart';

import '../../core/services/gemini_service.dart';
import '../../core/theme/AppColors.dart';
import 'bot_message.dart';
import 'user_message.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final GeminiService geminiService = GeminiService();

  List<Map<String, dynamic>> messages = [
    {
      "isBot": true,
      "text": "Welcome to Pharaonic Civilization Assistant 👋\nAsk me about Pharaohs, Temples, Museums, Statues and Obelisks.",
    },

  ];

  bool isLoading = false;

  Future<void> sendMessage() async {

    if (controller.text.trim().isEmpty) {
      return;
    }

    String userMessage =
    controller.text.trim();

    setState(() {
      messages.add({
        "isBot": false,
        "text": userMessage,
      });

      isLoading = true;
    });

    controller.clear();

    scrollToBottom();

    String response = await
    geminiService.askQuestion(
      userMessage,
    );

    setState(() {

      messages.add({
        "isBot": true,
        "text": response,
      });

      isLoading = false;
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(
      const Duration(milliseconds: 300), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration:
            Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Chat",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                return msg["isBot"] ? BotMessage(text: msg["text"]) : UserMessage(text: msg["text"]);
              },
            ),
          ),

          if (isLoading)
            Padding(padding: EdgeInsets.only(bottom: 10),
              child: CircularProgressIndicator(),
            ),

          Container(
            padding:
            EdgeInsets.all(12),
            decoration:
            BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),

            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted:
                        (_) {
                      sendMessage();
                    },

                    decoration: InputDecoration(
                      hintText: "What would you like to know?",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.image_outlined),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.code),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.mic_none),
                ),

                CircleAvatar(
                  backgroundColor:
                  Colors.grey.shade300,
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.arrow_upward),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}