// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:movies_app/features/now_playing_movies/bloc/now_playing_movies_bloc.dart';
// import 'package:movies_app/features/now_playing_movies/now_playing_movies_screen.dart';
//
// import 'now_playing_movies_screen_test.mocks.dart';
//
// @GenerateMocks([NowPlayingMoviesBloc])
// void main() {
//
//   late final NowPlayingMoviesBloc mockBloc;
//
//   setUpAll(() {
//     mockBloc = MockNowPlayingMoviesBloc();
//   });
//
//   testWidgets('When State is Initial then show Loading Indicator',
//     (WidgetTester widgetTester) async {
//
//       when(mockBloc.stream).thenAnswer((_) => Stream<NowPlayingMoviesState>
//         .value(NowPlayingInitialState()));
//       when(mockBloc.state).thenAnswer((_) => NowPlayingInitialState());
//
//       await widgetTester.pumpWidget(const MaterialApp(
//         home: Scaffold(body: NowPlayingMoviesScreen(),),
//       ));
//   });
// }