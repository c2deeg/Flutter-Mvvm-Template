import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/UserModel.dart';
import '../../data/UserRepository.dart';


class UserViewController extends GetxController {
  final UserRepository _repository = UserRepository();


  var users = <UserModel>[].obs;
  var isLoading = false.obs;
  var error = "".obs;
  var page = 1;
  final int limit = 10;
  var hasMore = true.obs;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  Future<void> getUsers({bool loadMore = false}) async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    error.value = "";

    try {
       debugPrint("checking--------${page}");
      final result = await _repository.fetchUsers();

      if (result.isEmpty) {
        hasMore.value = false;
      } else {
        if (loadMore) {
          users.addAll(result); // append for pagination
        } else {
          users.assignAll(result); // first page / refresh
        }
        page++;
      }
      // var totalCount = 0;
      // if(users.length==totalCount){
      //   hasMore.value = false;
      // }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login()  async{
    try{
      final result = await _repository.login("email", "password");
    }catch(e){

    }finally{

    }
  }

  //code latest
  Future<void> refreshUsers() async {
    page = 1;
    hasMore.value = true;
    await getUsers();
  }
}
