
import 'package:ets_ppb/services/film_db.dart';
import 'package:flutter/material.dart';
import 'package:ets_ppb/model/film.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Film>? films;
  bool isLoading = false;

  Future refresh() async {
    setState(() {
      isLoading = true;
    });

    films = await FilmDatabase.instance.readAll();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  void dispose() {
    FilmDatabase.instance.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          'My Film List',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: (isLoading) ? const CircularProgressIndicator() :
        (films!.isEmpty) ?
            const Text(
              'Please Add Your Favorite Film First',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w400
              ),
            ):
        Expanded(
          child: ListView.builder(
            itemCount: films!.length,
            itemBuilder: (context, index){
              return Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(films![index].cover),
                  ),
                  title: Center(
                    child: Text(
                      films![index].title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      films![index].description,
                      style: const TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await FilmDatabase.instance.delete(index);
                      refresh();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/detail', arguments: index);
                  },
                ),
              );
            }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
