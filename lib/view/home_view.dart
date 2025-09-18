// import 'package:api_practice/api_service/api_service.dart';
// import 'package:api_practice/dto/home_screen_dto.dart';
// import 'package:flutter/material.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final ApiService _apiService = ApiService();
//   final List<HomeScreenModel> _posts = [];
//   int _currentPage = 0;
//   final int _perPage = 10;
//   bool _isLoading = false;
//   bool _hasMore = true;
//   final ScrollController _scrollController = ScrollController();
//   final int _totalPosts = 100;

//   @override
//   void initState() {
//     super.initState();
//     _loadMorePosts();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//               _scrollController.position.maxScrollExtent &&
//           !_isLoading &&
//           _hasMore) {
//         _loadMorePosts();
//       }
//     });
//   }

//   Future<void> _loadMorePosts() async {
//     if (_isLoading || !_hasMore) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final start = _currentPage * _perPage;
//       final posts = await _apiService.fetchPosts(start, _perPage);
//       setState(() {
//         _posts.addAll(posts);
//         _currentPage++;
//         _hasMore = _posts.length < _totalPosts;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Paginated Posts')),
//       body: Column(
//         children: [
//           // Header section (part of Column)
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             color: Colors.blueGrey[50],
//             child: const Text(
//               'Welcome to the Posts App',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           // ListView.builder wrapped in Expanded to take available space
//           Expanded(
//             child: Stack(
//               children: [
//                 // ListView.builder for paginated posts
//                 RefreshIndicator(
//                   onRefresh: () async {
//                     setState(() {
//                       _posts.clear();
//                       _currentPage = 0;
//                       _hasMore = true;
//                     });
//                     await _loadMorePosts();
//                   },
//                   child: ListView.builder(
//                     controller: _scrollController,
//                     itemCount: _posts.length + (_isLoading ? 1 : 0),
//                     itemBuilder: (context, index) {
//                       if (index == _posts.length) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       final post = _posts[index];
//                       return ListTile(
//                         title: Text(post.title ?? 'No Title'),
//                         subtitle: Text('ID: ${post.id}'),
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               title: Text(post.title ?? 'No Title'),
//                               content: Text(post.body ?? 'No Body'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text('Close'),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 // Overlay a Floating Action Button or other widget using Stack
//                 if (_isLoading)
//                   const Positioned(
//                     bottom: 16,
//                     right: 16,
//                     child: CircularProgressIndicator(),
//                   ),
//                 Positioned(
//                   bottom: 16,
//                   right: 16,
//                   child: Container(width: 30, height: 160, color: Colors.red),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:api_practice/api_service/api_service.dart';
// import 'package:api_practice/dto/home_screen_dto.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final ApiService _apiService = ApiService();
//   late Future<List<HomeScreenModel>> _postsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _postsFuture = _apiService.fetchPosts(); // simple call
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Posts")),
//       body: FutureBuilder<List<HomeScreenModel>>(
//         future: _postsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No posts found"));
//           } else {
//             final posts = snapshot.data!;
//             return ListView.builder(
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 return ListTile(
//                   title: Text(post.title ?? "No Title"),
//                   subtitle: Text(post.body ?? "No Body"),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:api_practice/view/cubit/home_page_api_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_practice/api_service/api_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomePageApiCubit(ApiService())..fetchPosts(), // call at start
      child: Scaffold(
        appBar: AppBar(title: const Text("Posts with Cubit")),
        body: BlocBuilder<HomePageApiCubit, HomePageApiState>(
          builder: (context, state) {
            if (state is HomePageApiLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomePageApiError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is HomePageApiLoaded) {
              final posts = state.posts;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ListTile(
                    title: Text(post.title ?? "No Title"),
                    subtitle: Text(post.body ?? "No Body"),
                  );
                },
              );
            }
            return const Center(child: Text("Press button to fetch posts"));
          },
        ),
      ),
    );
  }
}
