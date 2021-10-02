import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/post_states.dart';
import 'package:news_application/models/post/post.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitialState());
  List<Post> posts = [];
  List<Post> favoritePostsList = [];
  String? nextPage;

  static PostCubit get(context) => BlocProvider.of(context);

  Future<void> insertPost({required Post post}) async {}

  Future<void> fetchPosts(
      {uri =
          'http://192.168.1.101:8000/api/v1/post/fetch-posts?API_PASSWORD=PVd09uByztpJ8clnnTCc4J'}) async {
    await Future.delayed(Duration(seconds: 2));
    emit(PostFetchPostState());

  }

  Future<void> onLoading() async {
    if (nextPage != null) await fetchPosts(uri: nextPage);
    print(nextPage);
    emit(PostLoadedState());
  }
}
