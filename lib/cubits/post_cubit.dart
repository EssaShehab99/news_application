import 'package:bloc/bloc.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/post_states.dart';
import 'package:news_application/models/post/post.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitialState());
  List<Post> posts = [];
  List<Post> favoritePostsList = [];
  String? nextPage;

  static PostCubit get(context) => BlocProvider.of(context);

  Future<void> insertPost({required Post post}) async {
    posts.insert(0, post);
    await Future.delayed(Duration(seconds: 5));
    emit(PostLoadedState());
  }

  Future<void> fetchPosts(
      {uri =
          'http://192.168.1.101:8000/api/v1/post/fetch-posts?API_PASSWORD=PVd09uByztpJ8clnnTCc4J'}) async {

    emit(PostFetchPostState());

  }

  Future<void> onLoading() async {
    if (nextPage != null) await fetchPosts(uri: nextPage);
    print(nextPage);

    // emit(PostLoadedState());
  }

  bool checkFavoritePost({required int id}) {
    print('id favorite screen :' + id.toString());
    return favoritePostsList.firstWhereOrNull((element) => element.id == id) ==
            null
        ? false
        : true;
  }

  void favoritePost({required Post post, required bool favoriteStatus}) {
    if (favoriteStatus)
      favoritePostsList.add(post);
    else
      favoritePostsList.remove(post);
  }
}
