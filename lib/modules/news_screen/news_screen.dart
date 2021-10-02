import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/post_cubit.dart';
import 'package:news_application/cubits/post_states.dart';
import 'package:news_application/cubits/title_cubit.dart';
import 'package:news_application/layout/main_layout/main_layout.dart';
import 'package:news_application/models/post/post.dart';
import 'package:news_application/modules/about_application/about_application.dart';
import 'package:news_application/modules/application_setting/application_setting.dart';
import 'package:news_application/modules/post_editing/post_editing.dart';
import 'package:news_application/modules/title_editing/title_editing.dart';
import 'package:news_application/shared/components/components.dart';
import 'package:news_application/shared/components/constants.dart';
import 'package:news_application/shared/components/default_smart_refresher.dart';
import 'package:news_application/shared/components/determine_time/determine_time.dart';
import 'package:news_application/shared/components/image_viewer/image_viewer.dart';
import 'news_details.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _titles = TitleCubit.get(context).titles;
    var _posts = PostCubit.get(context).posts;
    var _favoritePosts = PostCubit.get(context).favoritePostsList;
    List<String> itemsPopupMenuButton = [
      "setting".tr().toString(),
      "about-application".tr().toString(),
      "add-title".tr().toString(),
      "exit".tr().toString(),
    ];
    return defaultScaffold(
      context: context,
      body: SafeArea(
        child: BlocConsumer<PostCubit, PostStates>(
          listener: (context, state) {},
          builder: (context, state) => DefaultTabController(
            length: _titles.length,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    sliver: SliverAppBar(
                      leading: Container(
                          width: 120,
                          child: defaultImageLogo(fit: BoxFit.contain)),
                      leadingWidth: 120,
                      actions: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius)),
                            itemBuilder: (ctx) {
                              List<PopupMenuEntry<int>> list =
                                  <PopupMenuEntry<int>>[];
                              itemsPopupMenuButton
                                  .forEach((itemPopupMenuButton) {
                                list.add(PopupMenuItem(
                                  child: Text(
                                    itemPopupMenuButton,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  value: itemsPopupMenuButton
                                      .indexOf(itemPopupMenuButton),
                                ));
                                list.add(
                                  const PopupMenuDivider(
                                    height: 5,
                                  ),
                                );
                              });
                              return list;
                            },
                            onSelected: (item) {
                              if (item == 0)
                                Navigator.of(context).pushNamed(
                                    ApplicationSetting.applicationSetting);
                              if (item == 1)
                                Navigator.of(context).pushNamed(
                                    AboutApplication.aboutApplication);
                              if (item == 2)
                                Navigator.of(context)
                                    .pushNamed(TitleEditing.titleEditing);

                              // if (item == 3) exit(0);
                            },
                          ),
                        )
                      ],
                      expandedHeight: 120,
                      pinned: true,
                      floating: true,
                      snap: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        isScrollable: true,
                        tabs: _titles
                            .map((title) => Tab(text: title.title))
                            .toList(),
                      ),
                    ),
                  ),
                )
              ],
              body: TabBarView(
                children: _titles
                    .map((_newsTitle) => Container(
                          color: Theme.of(context).canvasColor,
                          child: SafeArea(
                            top: false,
                            bottom: false,
                            child: Builder(
                              builder: (context) {
                                return DefaultSmartRefresher(
                                  onRefresh: PostCubit.get(context).fetchPosts,
                                  onLoading: PostCubit.get(context).onLoading,
                                  child: CustomScrollView(
                                    key: PageStorageKey<String>(
                                        _newsTitle.id!.toString()),
                                    physics: BouncingScrollPhysics(),
                                    slivers: [
                                      SliverOverlapInjector(
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                                  context)),
                                      SliverPadding(
                                        padding: EdgeInsets.all(2.0),
                                        sliver: SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) => childBuilder(
                                                posts: _posts,
                                                title: _newsTitle,
                                                favoritePosts: _favoritePosts,
                                                index: index),
                                            childCount: childCount(
                                                posts: _posts,
                                                title: _newsTitle,
                                                favoritePosts: _favoritePosts),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: defaultFloatingActionButton(
        icon: Icons.edit,
        onPressed: () {
          Navigator.of(context).pushNamed(PostEditing.postEditing);
        },
      ),
    );
  }

  int childCount({posts, title, favoritePosts}) {
    if (title.typeTitle == TypeTitle.MIXED)
      return posts.length;
    else if (title.typeTitle == TypeTitle.CLOUD)
      return posts.where((_post) => _post.type?.id == title.id).length;
    else
      return favoritePosts.length;
  }

  Widget childBuilder({title, posts, index, favoritePosts}) {
    if (title.typeTitle == TypeTitle.MIXED)
      return listItem(posts, index);
    else if (title.typeTitle == TypeTitle.CLOUD)
      return listItem(
          posts.where((_post) => _post.type?.id == title.id).toList(), index);
    else
      return listItem(favoritePosts, index);
  }

  Widget listItem(List<Post> _posts, index) => Builder(builder: (context) {
        return Column(
          children: [
            defaultItemListView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: defaultAutoSizeText(
                                text: "${_posts[index].title}",
                                context: context,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.only(end: 10),
                            width: _posts[index].remoteImageTitle != null
                                ? 120
                                : 0.0,
                            height: _posts[index].remoteImageTitle != null
                                ? 120
                                : 0.0,
                            child: DefaultBoxImage(
                              images: _posts[index].remoteImageTitle != null
                                  ? [_posts[index].remoteImageTitle]
                                  : [],
                              index: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Row(
                        children: [
                          Container(
                            child: DetermineTime(
                              DateTime.parse(_posts[index].date),
                            ),
                          ),
                          Spacer(),
                          _posts[index].isRead
                              ? SizedBox.shrink()
                              : Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(NewsDetails.newsDetailsScreen,
                      arguments: _posts[index]);
                }),
            defaultDivider()
          ],
        );
      });
}
