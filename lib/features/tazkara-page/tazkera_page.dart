import 'package:flutter/material.dart';
import 'package:tazkera/config/theme/colors.dart';
import 'package:tazkera/core/utils/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tazkera/features/Models/tazkera_models.dart';
import 'package:tazkera/features/Models/user_models.dart';
import 'package:date_format/date_format.dart'; // استيراد مكتبة date_format

class TazkeraPage extends StatefulWidget {
  const TazkeraPage({super.key});

  @override
  State<TazkeraPage> createState() => _TazkeraPageState();
}

class _TazkeraPageState extends State<TazkeraPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _addTazkera() async {
    if (_titleController.text.isNotEmpty && _textController.text.isNotEmpty) {
      UserModels currentUser = FirebaseService.currentUser!;

      TazkeraModels newTazkera = TazkeraModels(
        userId: currentUser.id,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        text: _textController.text,
        username: currentUser.name,
        timestamp: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('tazkera')
          .doc(newTazkera.id)
          .set(newTazkera.toJson());
      _titleController.clear();
      _textController.clear();
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorsManager.moreLighterGray,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'ذكر',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.green,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                textAlign: TextAlign.right,
                cursorColor: ColorsManager.green,
                decoration: InputDecoration(
                  labelText: 'العنوان',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(color: ColorsManager.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: ColorsManager.green,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: ColorsManager.green,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _textController,
                textAlign: TextAlign.right,
                maxLines: 3,
                cursorColor: ColorsManager.green,
                decoration: InputDecoration(
                  labelText: 'النص',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(color: ColorsManager.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: ColorsManager.green,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: ColorsManager.green,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('tazkera')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('لا توجد بيانات متاحة'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index].data();
                        final tazkera = TazkeraModels.fromJsonMap(data);
                        String formattedDate = formatDate(
                            tazkera.timestamp.toDate(),
                            [dd, '/', mm, '/', yyyy] // تنسيق التاريخ
                            );
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListTile(
                              title: Text(
                                tazkera.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.darkBlue,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    tazkera.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: ColorsManager.gray,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'كتب بواسطة: ${tazkera.username}',
                                        style: const TextStyle(
                                          color: Color(0xFF2C5A53),
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        "$formattedDate",
                                        style: const TextStyle(
                                          color: Color(0xFF2C5A53),
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTazkera,
          backgroundColor: ColorsManager.green,
          child: const Icon(
            Icons.add,
            color: ColorsManager.moreLightGray,
          ),
        ),
      ),
    );
  }
}
