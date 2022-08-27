import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movies_app/data/movie_repository/movie_remote_service.dart';
import 'package:movies_app/data/movie_repository/movie_repository.dart';
import 'package:movies_app/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movies_app/features/movie_detail/movie_detail_screen.dart';
import 'package:movies_app/features/now_playing_movies/bloc/now_playing_movies_bloc.dart';
import 'package:movies_app/features/now_playing_movies/models/movies_model.dart';

import '../../core/design_system/colors.dart';
import '../../core/design_system/design_system.dart';
import '../../core/di/di.dart';

class NowPlayingMoviesScreen extends StatelessWidget {
  const NowPlayingMoviesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NowPlayingMoviesBloc>(
        create: (_) => locator<NowPlayingMoviesBloc>()..add(GetNowPlayingMoviesEvent()),
        child: const _MovieListingBody(),
      ),
    );
  }
}

class _MovieListingBody extends StatelessWidget {
  const _MovieListingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      builder: (BuildContext bCtx, NowPlayingMoviesState state) {
        if (state.isLoadingState || state.isInitState) {
          return const Center(child: MLoadingIndicator(),);
        } else if (state.isFailedState) {
          return SizedBox(child: ErrorView(error: state.fetchedError),);
        } else if (state.isSucceedState) {
          return _MoviesView(movies: state.fetchedMovies);
        }
        return const SizedBox();
      }
    );
  }
}

class _MoviesView extends StatefulWidget {
  final List<MovieModel> movies;
  const _MoviesView({Key? key, required this.movies}) : super(key: key);

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<_MoviesView> {

  late int currentIdx;

  @override
  void initState() {
    currentIdx = (widget.movies.length / 2).ceil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            widget.movies.elementAt(currentIdx).fullImageUrl,),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        )
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MColors.primaryColor,
                  MColors.primaryColor,
                  MColors.primaryColor,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [
                  0.0, 0.2, 0.3, 0.9
                ]
              ),

            ),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.movies[currentIdx].title, textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),),
                    const MGap.v12(),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _InformationCubic(
                              width: 60, height: 60, color: MColors.primaryColor.withOpacity(0.3),
                              child: Text(
                                widget.movies[currentIdx].releaseDate.year.toString(),
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white, fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                          const MGap.h12(),
                          _InformationCubic(
                              width: 60, height: 60, color: MColors.primaryColor.withOpacity(0.3),
                              child: Text(
                                widget.movies[currentIdx].adult ? '18+' : '13+',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white, fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                          const MGap.h12(),
                          _InformationCubic(
                              height: 60, width: 70, color: Colors.amber,
                              child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: widget.movies[currentIdx].voteAverage.toStringAsFixed(1),
                                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                      TextSpan(
                                          text: '/10',
                                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                    ]
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),

              _MoviesPageView(movies: widget.movies, onPageChanged: setCurrentMovie,),
            ],
          )
        ],
      ),
    );
  }

  void setCurrentMovie(int index) {
    setState(() {
      currentIdx = index;
    });
  }
}

class _InformationCubic extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color color;
  const _InformationCubic({Key? key, required this.width, required this.height, required this.child, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width, height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: child,

    );
  }
}


class _MoviesPageView extends HookWidget {
  final List<MovieModel> movies;
  final Function(int index)? onPageChanged;
  const _MoviesPageView({Key? key, required this.movies, this.onPageChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageCtrl = usePageController(viewportFraction: 0.6,
      initialPage: (movies.length / 2).ceil());

    return SizedBox(
      height: MediaQuery.of(context).size.height/ 2.5,
      width: double.infinity,
      child: PageView.builder(
          controller: pageCtrl,
          itemCount: movies.length,
          onPageChanged: onPageChanged,
          itemBuilder: (_, int index) {
            return InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MovieDetailScreen(movieId: movies[index].id))),
              child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (_, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: AnimatedBuilder(
                          animation: pageCtrl,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(movies[index].fullImageUrl),
                                  fit: BoxFit.fill
                              ),
                            ),
                          ),
                          builder: (BuildContext ctx, Widget? child) {
                            return child!;
                          }
                        )
                      ),
                      if (state is LoadingMovieDetailState)...[
                        const MLoadingIndicator()
                      ]
                    ],
                  );
                },
              ),
            );
          }
      ),
    );
  }
}



// class _MoviesView extends StatelessWidget {
//   final List<MovieModel> movies;
//   const _MoviesView({Key? key, required this.movies}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: ListView.separated(
//         itemCount: movies.length,
//         separatorBuilder: (_, __) => const MGap.v12(),
//         itemBuilder: (BuildContext context, int index) => _MovieItemView(
//           movie: movies[index], key: ValueKey(movies[index].id),)
//       ),
//     );
//   }
// }

// class _MovieItemView extends StatelessWidget {
//   final MovieModel movie;
//   const _MovieItemView({Key? key, required this.movie}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieDetailScreen(movieId: movie.id,))),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 4,
//             child: AspectRatio(
//               aspectRatio: 8/ 12,
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(movie.fullImageUrl),
//                     fit: BoxFit.cover
//                   )
//                 ),
//               ),
//             )
//           ),
//           const MGap.h12(),
//           Expanded(
//             flex: 8,
//             child: Column(
//               children: [
//                 Text(movie.title),
//                 Text(movie.popularity.toString()),
//                 Text('${movie.voteAverage.toString()} / 10 (${movie.voteCount.toString()})')
//               ],
//             )
//           ),
//         ],
//       ),
//     );
//   }
// }

