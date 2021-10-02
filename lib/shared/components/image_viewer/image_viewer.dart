import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/files_cubit.dart';
import 'package:news_application/cubits/files_states.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../components.dart';
import '../constants.dart';
import '../download_button.dart';
import 'interactive_image.dart';

class PhotoViewer extends StatefulWidget {
  PhotoViewer(
      {Key? key,
      required this.images,
      required Function(DismissDirection) this.onDismissed,
      this.icon,
      this.onPressed})
      : super(key: key);
  final List<dynamic>? images;
  final IconData? icon;
  final Function? onPressed;

  @override
  _PhotoViewerState createState() => _PhotoViewerState();

  final Function onDismissed;
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: CarouselSlider(
            items: [
              if (widget.images != null)
                for (var image in widget.images!)
                  defaultDismissible(
                    direction: image.runtimeType == String
                        ? DismissDirection.none
                        : DismissDirection.down,
                    key: image.toString(),
                    onDismissed: (_) {
                      widget.images?.removeAt(widget.images!.indexOf(image));
                      setState(() {});
                    },
                    child: DefaultBoxImage(
                      images: widget.images!,
                      index: widget.images!.indexOf(image),
                    ),
                  ),
              if (widget.onPressed != null && widget.icon != null)
                IconButton(
                  onPressed: () async {
                    widget.onPressed!();
                    setState(() {});
                  },
                  icon: Icon(widget.icon),
                )
            ],
            options: CarouselOptions(
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              viewportFraction: 1,
              height: 215,
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultBoxImage extends StatelessWidget {
  const DefaultBoxImage({Key? key, required this.images, required this.index})
      : super(key: key);
  final List<dynamic> images;
  final index;

  @override
  Widget build(BuildContext context) {
    var value=FilesCubit.get(context);
    if (images.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: Card(
          color: Theme.of(context).backgroundColor.withOpacity(0.5),
          margin: EdgeInsets.all(0.0),
          child: Stack(
            children: [
              if (images[index].runtimeType == String)
                BlocConsumer<FilesCubit,FileStates>(
                listener: (context, state) {
                },
                      builder: (context, state) =>  Stack(
                            children: [
                              DownloadButton(
                                  remoteUrl: images[index],
                                  folder: 'Yemen Net'),
                              if (value.fileInDatabase(images[index]) !=
                                  null)
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => InteractiveImage(
                                              images: images,
                                              index: index,
                                            )));
                                  },
                                  child: defaultPhotoView(
                                      value: File(value
                                          .fileInDatabase(images[index])!),
                                      onPressed: () {}),
                                ),
                            ],
                          )) else defaultPhotoView(
                      value: images[index], onPressed: () {}),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
