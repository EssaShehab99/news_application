import 'package:news_application/cubits/files_cubit.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class DownloadButton extends StatelessWidget {
  DownloadButton(
      {Key? key,
      required this.remoteUrl,
      required this.folder,
      this.extension = 'jpg'})
      : super(key: key);

  final String folder;
  final String remoteUrl;
  final String extension;

  @override
  Widget build(BuildContext context) {
    FilesCubit fileManager= Provider.of<FilesCubit>(context, listen: false);

    return Center(
      child:  CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 4.0,
          backgroundColor: Colors.black.withOpacity(0.0),
          percent: fileManager.value[remoteUrl] ?? 0.0,
          center: TextButton(
            onPressed: () async {
              if (fileManager.value.containsKey(remoteUrl) == true &&
                  fileManager.value[remoteUrl]! > 0) {
                fileManager.cancelDownload(remoteUrl: remoteUrl);
              } else {
                if (fileManager.fileInDatabase(remoteUrl) == null &&
                    fileManager.value.containsKey(remoteUrl) != true) {
                  fileManager.downloadFile(url: remoteUrl, folder: folder);
                }
              }
            },
            style: TextButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.black.withOpacity(0.3),
                minimumSize: Size(50, 50)),
            child: Icon(
              fileManager.value.containsKey(remoteUrl) == true
                  ? Icons.stop
                  : Icons.download,
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}
