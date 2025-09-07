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
      body: Obx(() {
        if (controller.isLoading.value && controller.page==1) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.isNotEmpty) {
          return Center(child: Text("Error: ${controller.error}"));
        }
        return ListView.builder(
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
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.getUsers,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
