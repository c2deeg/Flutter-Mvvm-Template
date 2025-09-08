import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UserViewController.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserViewController());
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.getUsers();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black
              ),
              decoration: InputDecoration(
                hintText: 'Enter Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10)
              ),

            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // your action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                ),
                child: const Text("Rounded Button",style: TextStyle(color: Colors.white),),
              ),
            ),
          ),

          Obx(() {
            if (controller.isLoading.value && controller.page==1) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.error.isNotEmpty) {
              return Center(child: Text("Error: ${controller.error}"));
            }
            return Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: controller.users.length + 1, // +1 for loader
                itemBuilder: (context, index) {
                  if (index < controller.users.length) {
                    final user = controller.users[index];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    );
                  } else {
                    // loader at bottom
                    return controller.isLoading.value
                        ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                        : const SizedBox();
                  }
                },
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.getUsers,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
