import 'package:ets_ppb/model/film.dart';
import 'package:ets_ppb/services/film_db.dart';
import 'package:flutter/material.dart';

class EditFilm extends StatefulWidget {
  const EditFilm({super.key});

  @override
  State<EditFilm> createState() => _EditFilmState();
}

class _EditFilmState extends State<EditFilm> {
  String? title, link, description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          'Edit Film',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget> [
          TextField(
            decoration: InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            onChanged: (query){
              setState(() {
                title = query;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Image Link',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            onChanged: (query){
              setState(() {
                link = query;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            onChanged: (query){
              setState(() {
                description = query;
              });
            },
          ),
          ElevatedButton(
              onPressed: () async {
                Film film = Film(title: title.toString(), added: DateTime.now(), cover: link.toString(), description: description.toString());
                await FilmDatabase.instance.update(film);
                Navigator.pushReplacementNamed(context, 'home');
              },
              child: const Text('submit')
          )
        ],
      ),
    );
  }
}
