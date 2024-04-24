import 'package:flutter/material.dart';

class FilmDetail extends StatefulWidget {
  const FilmDetail({super.key});

  @override
  State<FilmDetail> createState() => _FilmDetailState();
}

class _FilmDetailState extends State<FilmDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          'Film Detail',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/edit');
          }, icon: const Icon(Icons.edit))
        ],
      ),
      body: const Placeholder(),
    );
  }
}
