import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {

   GetStorage storage =GetStorage();

   Future<StorageService> init() async {
     storage = GetStorage();
     return this;
   }

   void write(String key, dynamic value) {
     storage.write(key, value);
   }

    read(String key) {
     return storage.read(key);
   }

   void erase(String key) {
     storage.remove(key);
   }
   void clearAll() {
     storage.erase();
   }
}