import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/title_states.dart';
import 'package:news_application/models/title/news_title.dart';

class TitleCubit extends Cubit<TitleStates> {
  TitleCubit() : super(TitleInitialState());

  static TitleCubit get(context)=>BlocProvider.of(context);
  List<NewsTitle> titles=[];
  Future<void> fetch()async {
    await Future.delayed(Duration(seconds: 5));

  }
  Future<void> insertTitle({required String title})async {}
  Future<void> onLoading()async {}
}
