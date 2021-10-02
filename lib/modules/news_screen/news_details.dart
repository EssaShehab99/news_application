import 'package:easy_localization/src/public_ext.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/post_cubit.dart';
import 'package:news_application/cubits/post_states.dart';
import 'package:news_application/layout/main_layout/main_layout.dart';
import 'package:news_application/models/post/post.dart';
import 'package:news_application/modules/post_editing/post_editing.dart';
import 'package:news_application/shared/components/components.dart';
import 'package:news_application/shared/components/constants.dart';
import 'package:news_application/shared/components/image_viewer/image_viewer.dart';
import 'package:easy_localization/easy_localization.dart' as localization;

class NewsDetails extends StatelessWidget {
  const NewsDetails({Key? key}) : super(key: key);
  static String newsDetailsScreen = "/newsDetailsScreen";

  @override
  Widget build(BuildContext context) {
    Post post = ModalRoute.of(context)!.settings.arguments as Post;
    return defaultScaffold(
      title: "details".tr().toString(),
      context: context,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop({"isDelete": false, "id": ""});
        },
        icon: Icon(Icons.arrow_back_sharp),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            var isDelete = await defaultConfirmDialog(context: context);
            isDelete == true
                ? Navigator.of(context).pop({"isDelete": isDelete, "id": ''})
                : null;
          },
          icon: Icon(Icons.delete),
        ),
      ],
      body: BlocConsumer<PostCubit, PostStates>(
        listener: (context, state) {},
        builder: (context, state) => SingleChildScrollView(
          padding: const EdgeInsets.all(padding),
          child: Column(
            children: [
              Container(
                child: defaultSelectableText(
                  text: post.title.trim(),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                height: post.remoteImageTitle != null ? 250 : 0,
                child: DefaultBoxImage(
                  images: post.remoteImageTitle != null
                      ? [post.remoteImageTitle]
                      : [],
                  index: 0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                width: double.infinity,
                child: defaultSelectableText(
                  text: localization.DateFormat(timeFormat)
                      .format(DateTime.parse(post.date)),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                child: defaultSelectableText(
                  text: post.detail?.trim() ?? '',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Divider(
                thickness: 1.0,
              ),
              PhotoViewer(
                images: post.remoteImageList,
                onDismissed: (_) {},
              ),
              SizedBox(height: 40,),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  child: StarButton(
                    isStarred: PostCubit.get(context).checkFavoritePost(id: post.id!),
                    valueChanged: (favoriteStatus) {
                      PostCubit.get(context).favoritePost(
                          post: post,
                          favoriteStatus: favoriteStatus);
                    },
                  )),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
      floatingActionButton: defaultFloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(PostEditing.postEditing,
              arguments: Post(
                  id: post.id,
                  title: post.title,
                  detail: post.detail,
                  date: post.date,
                  type: post.type,
                  isRead: post.isRead,
                  isSync: post.isSync,
                  isFavorite: post.isFavorite,
                  remoteImageTitle: post.remoteImageTitle,
                  remoteImageList: post.remoteImageList));
        },
        icon: Icons.edit,
      ),
    );
  }
}
