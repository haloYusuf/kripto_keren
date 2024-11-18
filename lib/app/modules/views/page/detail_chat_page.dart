import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/detail_chat_controller.dart';
import 'package:tugas_akhir_kripto/app/utils/constants.dart';

class DetailChatPage extends StatelessWidget {
  const DetailChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailChatController controller = Get.find();

    Widget gapVertical({required double gap}){
      return SizedBox(height: gap,);
    }

    Widget gapHorizontal({required double gap}){
      return SizedBox(width: gap,);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.getTargetName(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Constants.colorBlack,
              ),
            ),
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://img.freepik.com/premium-photo/graphic-designer-digital-avatar-generative-ai_934475-9292.jpg',
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: controller.getAllMessage(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }

                  controller.getAllDecryptContent(data: snapshot.data!.docs);
                  if(controller.chatData.isEmpty){
                    return Center(
                      child: Text(
                        'Tidak ada chat untuk ditampilkan!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Constants.colorBlack,
                        ),
                      ),
                    );
                  }else{
                    controller.scrollToBottom();
                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.chatData.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: controller.isSender(index: index) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.isSender(index: index) ? controller.getUsername() : controller.getTargetName(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 3 / 4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: controller.isSender(index: index) ?
                                  const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ) :
                                  const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  color: const Color(0xFFA6FFD7),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  controller.chatData[index].content,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Text(
                                controller.getDateTimeChat(index),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            gapVertical(gap: 5),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.contentController,
                    minLines: 1,
                    maxLines: 3,
                    textInputAction: TextInputAction.send,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Masukkan pesan ...',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (v){
                      controller.sendMessage();
                    },
                  ),
                ),
                gapHorizontal(gap: 10),
                IconButton(
                  onPressed: (){
                    controller.dismissKeyboard();
                    controller.sendMessage();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Constants.colorGreen,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
