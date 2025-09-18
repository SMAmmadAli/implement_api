import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:api_practice/api_service/api_service.dart';
import 'package:api_practice/dto/home_screen_dto.dart';

part 'home_page_api_state.dart';

class HomePageApiCubit extends Cubit<HomePageApiState> {
  final ApiService apiService;

  HomePageApiCubit(this.apiService) : super(HomePageApiInitial());

  Future<void> fetchPosts() async {
    emit(HomePageApiLoading());
    try {
      final posts = await apiService.fetchPosts();
      emit(HomePageApiLoaded(posts));
    } catch (e) {
      emit(HomePageApiError(e.toString()));
    }
  }
}
