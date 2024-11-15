import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/chat_controller.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  Widget _gapVertical({required double gap}){
    return SizedBox(height: gap,);
  }

  Widget _gapHorizontal({required double gap}){
    return SizedBox(width: gap,);
  }

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();
    return StreamBuilder(
      stream: controller.chatService.getAllChat(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        controller.chatData = controller.chatService.getAllChatData(data: snapshot.data!.docs);
        if(controller.chatData.isEmpty){
          return Center(
            child: Text(
              'Tidak ada data untuk ditampilkan!',
              style: TextStyle(
                fontSize: 18,
                color: Constants.colorBlack,
              ),
            ),
          );
        }else{
          return ListView.builder(
            itemCount: controller.chatData.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/premium-photo/graphic-designer-digital-avatar-generative-ai_934475-9292.jpg',
                          ),
                        ),
                        _gapHorizontal(gap: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.getTargetName(index),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Constants.colorBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _gapVertical(gap: 10),
                    Container(
                      height: 0.5,
                      color: Constants.colorBlack,
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
