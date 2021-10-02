import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flowder/flowder.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/file_manager/file_manager.dart';
import 'files_states.dart';

class FilesCubit extends Cubit<FileStates> {
  FilesCubit():super(FileInitialState());

  static FilesCubit get(context)=>BlocProvider.of(context);

  List<FileManager> fileManagerList = [];
  Map<String,double> value={};
  late DownloaderUtils options;
  late DownloaderCore core;
  late final String path;

  Future<dynamic> downloadFile(
      {required String url,
        required String folder,
        String extension = 'jpg'}) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) await Permission.storage.request();

    String _filePath =
        '/storage/emulated/0/$folder/${DateTime.now()}.$extension';
    options = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total);
        progressValue(remoteUrl: url, value: progress);
        emit(FileLoadingState());
      },
      file: File(_filePath),
      progress: ProgressImplementation(),
      onDone: () async {
        insertImageToDownload(
            remoteUrl: url, localUrl: _filePath);
        emit(FileLoadedState());
      },
      deleteOnCancel: true,
      /* client: Dio(BaseOptions(
            baseUrl: url,
            receiveTimeout: 1000,
            connectTimeout: 1000,
            sendTimeout: 1000))*/
    );
    core = await Flowder.download(url, options);
  }
  // Future<void> initPlatformState() async {
  //   if (!mounted) return;
  // }
  Future<void> insertImageToDownload(
      {required String remoteUrl,
        required String? localUrl}) async {
    fileManagerList.add(
        FileManager(remoteUrl: remoteUrl, localUrl: localUrl));
  }

  String? fileInDatabase(imageUrl) {
    FileManager? localPath = fileManagerList
        .firstWhereOrNull((file) {
      return file.remoteUrl == imageUrl;
    });

    return localPath?.localUrl;
  }

  void progressValue({remoteUrl,value}){
    if(this.value.containsKey(remoteUrl))
      this.value.update(remoteUrl, (_) => value);
    else
      this.value[remoteUrl]=value;

  }
  void cancelDownload({required String remoteUrl}){
    if(this.value.containsKey(remoteUrl))
      this.value.remove(remoteUrl);
      core.cancel();
  }
}