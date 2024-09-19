import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tazkera/config/theme/styles.dart';
import 'package:tazkera/core/utils/firebase_services.dart';
import 'package:tazkera/features/Models/tazkera_models.dart';
import 'package:tazkera/features/widgets/tazkera_message.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class TazkeraScreen extends StatefulWidget {
  const TazkeraScreen({super.key});

  @override
  State<TazkeraScreen> createState() => _TazkeraScreenState();
}

class _TazkeraScreenState extends State<TazkeraScreen> {
  final TextEditingController _controller = TextEditingController();

  final userId = FirebaseService.currentUser!.id;
  final now = DateTime.now();

  late String tazkeraText;

  void sendMessage() {
    final id = _uuid.v4();

    try {
      final tazkeraMessage = TazkeraModels(
        userId: userId,
        id: id.toString(),
        text: _controller.text,
        dateTime: now.toIso8601String(),
      );
      final tazkeraMessageCollection =
          FirebaseService.firestore.collection('tazkeraMessage');
      tazkeraMessageCollection
          .doc(tazkeraMessage.id)
          .set(tazkeraMessage.toJson());
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${error.message} خطأ في التسجيل')),
      );
    } catch (error) {
      // Handle other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tazkeraList = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'و ذكر فان الذكرى تنفع المؤمنين',
          style: TextStyles.font24WhiteBold.copyWith(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                // Replace with your actual message widgets
                TazkeraMessage(
                  sender: 'You',
                  text: 'Hello!',
                  isMe: true,
                ),
                TazkeraMessage(
                  sender: 'Contact Name',
                  text: 'Hi there!',
                  isMe: false,
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: const Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: '...ذكر بآية أو حديث أو حكمة ',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        sendMessage();
                        _controller
                            .clear(); // Clear the text field after sending the message
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("يجب كتابة تذكرة حتي يتم ارسالها")),
                        );
                        ScaffoldMessenger.of(context).clearSnackBars();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
