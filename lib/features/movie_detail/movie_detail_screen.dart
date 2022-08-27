import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/design_system/design_system.dart';
import 'package:movies_app/data/movie_repository/movie_remote_service.dart';
import 'package:movies_app/data/movie_repository/movie_repository.dart';
import 'package:movies_app/features/movie_detail/bloc/movie_detail_bloc.dart';

import '../../core/design_system/colors.dart';
import '../../core/di/di.dart';
import 'models/movie_detail_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailScreen({ Key? key, required this.movieId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      body: BlocProvider<MovieDetailBloc>(
        create: (_) => locator<MovieDetailBloc>()..add(GetMovieDetailEvent(movieId)),
        child: const _MovieDetailBody(),
      ),
    );
  }
}

class _MovieDetailBody extends StatelessWidget {
  const _MovieDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (_, state) {
          if (state.isLoadingState || state.isInitialState) {
            return const Center(
              child: MLoadingIndicator(),
            );
          } else if (state.isFailedState) {
            return ErrorView(error: state.fetchedError!);
          } else if (state.isSucceedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(state.fetchedMovie!.fullImageUrl, fit: BoxFit.cover,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        const MGap.v12(),
                        Text(state.fetchedMovie!.title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.fetchedMovie!.releaseDate.year.toString(), textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            const MGap.h04(),
                            const Text(' - ', style: TextStyle(color: Colors.white)),
                            const MGap.h04(),
                            Text('${state.fetchedMovie!.voteAverage.toStringAsFixed(1)} / 10', style: TextStyle(color: Colors.white)),
                            // Text(state.fetchedMovie!.)
                          ],
                        ),
                        _GenresChips(genres: state.fetchedMovie!.genres,),
                        const MGap.v12(),
                        Text(state.fetchedMovie!.overview!, style: TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return SizedBox();
        }
    );
  }
}

class _GenresChips extends StatelessWidget {
  final List<Genres> genres;
  const _GenresChips({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 08,
      alignment: WrapAlignment.center,
      children: genres.map((genre) =>
          Chip(label: Text(genre.name), key: ValueKey(genre.id),),).toList(),
    );
  }
}



