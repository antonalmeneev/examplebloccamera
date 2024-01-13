import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:examplebloccamera/data/providers/photo_provider.dart';
import 'package:examplebloccamera/models/photo.dart';

part 'photos_event.dart';

part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotoProvider? photoProvider;

  PhotosBloc({@required this.photoProvider}) : super(PhotosInitial()) {
    on<PhotosEvent>((event, emit) async {
      if (event is PhotosLoaded) {
        emit(PhotosLoadInProgress());
        try {
          final photos = await photoProvider!.loadPhotos();
          emit(PhotosLoadSuccess(photos: photos));
        } on Exception catch (error) {
          emit(PhotosLoadFailure(error: error.toString()));
        }
      } else if (event is PhotosAdded) {
        if (state is PhotosLoadSuccess) {
          final photos =
              List<Photo>.from((state as PhotosLoadSuccess).photos as Iterable)
                ..add(event.photo as Photo);
          emit(PhotosLoadInProgress());
          try {
            await photoProvider!.addPhoto(event.photo as Photo);
            emit(PhotosLoadSuccess(photos: photos));
          } on Exception catch (error) {
            emit(PhotosLoadFailure(error: error.toString()));
          }
        }
      } else if (event is PhotosDeleted) {
        if (state is PhotosLoadSuccess) {
          final photos =
              List<Photo>.from((state as PhotosLoadSuccess).photos as Iterable)
                ..remove(event.photo);

          emit(PhotosLoadInProgress());
          try {
            await photoProvider!.deletePhoto(event.photo as Photo);
            emit(PhotosLoadSuccess(photos: photos));
          } on Exception catch (error) {
            emit(PhotosLoadFailure(error: error.toString()));
          }
        }
      }
    });
  }

  // @override
  // void add(PhotosEvent event) {
  //   // TODO: implement add
  //   super.add(event);
  // }
  //
  // @override
  // Stream<PhotosState> mapEventToState(
  //   PhotosEvent event,
  // ) async* {
  //   if (event is PhotosLoaded)
  //     yield* _mapPhotosLoadedToState();
  //   else if (event is PhotosAdded)
  //     yield* _mapPhotosAddedToState(event);
  //   else if (event is PhotosDeleted) yield* _mapPhotosDeletedToState(event);
  // }
  //
  // Stream<PhotosState> _mapPhotosLoadedToState() async* {
  //   yield PhotosLoadInProgress();
  //   try {
  //     final photos = await photoProvider!.loadPhotos();
  //     yield PhotosLoadSuccess(photos: photos);
  //   } on Exception catch (error) {
  //     yield PhotosLoadFailure(error: error.toString());
  //   }
  // }
  //
  // Stream<PhotosState> _mapPhotosAddedToState(PhotosAdded event) async* {
  //   if (state is PhotosLoadSuccess) {
  //     final photos =
  //         List<Photo>.from((state as PhotosLoadSuccess).photos as Iterable)
  //           ..add(event.photo as Photo);
  //     yield PhotosLoadInProgress();
  //     try {
  //       await photoProvider!.addPhoto(event.photo as Photo);
  //       yield PhotosLoadSuccess(photos: photos);
  //     } on Exception catch (error) {
  //       yield PhotosLoadFailure(error: error.toString());
  //     }
  //   }
  // }
  //
  // Stream<PhotosState> _mapPhotosDeletedToState(PhotosDeleted event) async* {
  //   if (state is PhotosLoadSuccess) {
  //     final photos =
  //         List<Photo>.from((state as PhotosLoadSuccess).photos as Iterable)
  //           ..remove(event.photo);
  //
  //     yield PhotosLoadInProgress();
  //     try {
  //       await photoProvider!.deletePhoto(event.photo as Photo);
  //       yield PhotosLoadSuccess(photos: photos);
  //     } on Exception catch (error) {
  //       yield PhotosLoadFailure(error: error.toString());
  //     }
  //   }
  // }
}
