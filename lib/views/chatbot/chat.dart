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
      "text":
      "Welcome to Pharaonic Civilization Assistant 👋\nAsk me about Pharaohs, Temples, Museums, Statues and Obelisks.",
    },
  ];

  bool isLoading = false;

  Future<void> sendMessage() async {
    if (controller.text.trim().isEmpty) return;

    String userMessage = controller.text.trim();

    setState(() {
      messages.add({
        "isBot": false,
        "text": userMessage,
      });

      isLoading = true;
    });

    controller.clear();

    scrollToBottom();

    String response = await geminiService.askQuestion(userMessage);

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
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text(
          "Civilization AI",
          style: TextStyle(
            color:Theme.of(context).iconTheme.color,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: Stack(
        children: [

          /// Background
          Positioned.fill(
            child: Image.asset(
              "assets/backgrounds/photoChat.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(.45),
            ),
          ),

          SafeArea(
            child: Column(
              children: [

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];

                      return msg["isBot"]
                          ? BotMessage(text: msg["text"])
                          : UserMessage(text: msg["text"]);
                    },
                  ),
                ),

                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [

                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primaryGold,
                          child: Icon(
                            Icons.smart_toy,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Civilization AI is typing...",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.95),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Row(
                    children: [

                      Expanded(
                        child: TextField(
                          controller: controller,
                          onSubmitted: (_) => sendMessage(),

                          style: TextStyle(
                            color: Colors.black87,
                          ),

                          cursorColor: AppColors.primaryGold,

                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Ask about Ancient Egypt...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: sendMessage,

                        child: Container(
                          width: 45,
                          height: 45,

                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffF8E7A1),
                                Color(0xffD4AF37),
                                Color(0xff9E6B1A),
                              ],
                            ),
                          ),

                          child: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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