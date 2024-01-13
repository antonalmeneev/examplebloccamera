import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examplebloccamera/blocs/blocs.dart';
import 'package:examplebloccamera/models/photo.dart';

class DetailsScreen extends StatelessWidget {
  static String route = "/details";

  @override
  Widget build(BuildContext context) {
    final Photo? photo = ModalRoute.of(context)!.settings.arguments as Photo;

    deletePhoto() {
      BlocProvider.of<PhotosBloc>(context).add(PhotosDeleted(photo: photo));
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(photo!.name.toString()),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => deletePhoto(),
          )
        ],
      ),
      body: Center(
        child: photo.path != null
            ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                child: Image.file(File(photo!.path.toString()), fit: BoxFit.cover))
        )
            : Container(),
      ),
    );
  }
}