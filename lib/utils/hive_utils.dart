import 'package:corporatica_task/Models/photo_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initHive() async {
  //intializing Hive directory
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  Hive.registerAdapter<PhotoModel>('Photo', PhotoModel.fromJson);
}
