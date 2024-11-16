import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_kripto/app/modules/controllers/notification_controller.dart';

import '../../../utils/constants.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationController controller = Get.find();

    Widget gapVertical({required double gap}){
      return SizedBox(height: gap,);
    }

    Widget gapHorizontal({required double gap}){
      return SizedBox(width: gap,);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Constants.colorBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 12,
        ),
        child: StreamBuilder(
          stream: controller.conversationService.getAllRequest(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            controller.notifData = controller.conversationService.getData(data: snapshot.data!.docs);
            if(controller.notifData.isEmpty){
              return Center(
                child: Text(
                  'Tidak ada notifikasi untuk ditampilkan!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Constants.colorBlack,
                  ),
                ),
              );
            }else{
              return ListView.builder(
                itemCount: controller.notifData.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Permintaan untuk mengobrol!',
                                    style:  TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Constants.colorBlack,
                                    ),
                                  ),
                                  gapVertical(gap: 3),
                                  Text(
                                    '${controller.notifData[index].personName[0]} mengajak kamu untuk memulai obrolan.',
                                    style:  TextStyle(
                                      fontSize: 12,
                                      color: Constants.colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            gapHorizontal(gap: 10),
                            IconButton(
                              onPressed: (){
                                controller.hapusUndangan(index: index);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Constants.colorRed,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                controller.terimaUndangan(index: index);
                              },
                              icon: Icon(
                                Icons.add_circle,
                                color: Constants.colorGreen,
                              ),
                            ),
                          ],
                        ),
                        gapVertical(gap: 5),
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
        ),
      ),
    );
  }
}
