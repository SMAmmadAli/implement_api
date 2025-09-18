part of 'home_page_api_cubit.dart';

@immutable
sealed class HomePageApiState {}

/// initial state jab kuch bhi load nahi hua
final class HomePageApiInitial extends HomePageApiState {}

/// jab API call ho rahi ho
final class HomePageApiLoading extends HomePageApiState {}

/// jab API success ho jaye
final class HomePageApiLoaded extends HomePageApiState {
  final List<HomeScreenModel> posts;
  HomePageApiLoaded(this.posts);
}

/// jab API fail ho jaye
final class HomePageApiError extends HomePageApiState {
  final String message;
  HomePageApiError(this.message);
}
