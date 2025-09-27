import 'package:flutter/material.dart';
import 'package:pengolahan_data/data/game_store_data.dart';
import 'package:pengolahan_data/pages/profile_page.dart';
import 'package:pengolahan_data/screen/login_page.dart';
import 'package:pengolahan_data/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context){
                  return ProfilePage();
                }),
                );
            },
            icon:Icon (Icons.person)),
          IconButton(
            onPressed:() {
                   Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context){
                  return LoginPage();
                }),
                (route) => false,
                );
            },
            icon:Icon (Icons.logout_outlined, color: Colors.red,)),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            Text("Halo $username",
            style: TextStyle(
              fontSize: 25),
            ),
            //gridview
            Expanded(
              child: GridView.builder(
                gridDelegate: 
              SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              ), 
              itemBuilder:(context, index){
                return _gameStore(context, index);
              },
              itemCount: gameList.length,
              )
            )

          ],
        ),),
    );
  }

  Widget _gameStore(BuildContext content, int index) {  
    return InkWell(
      onTap: () {  
        Navigator.push(
          content,  
          MaterialPageRoute(
            builder: (context) => DetailPage (game: gameList[index]),  
          ),
        );
      },  
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.pinkAccent,
        ),
        child: Column(
        children: [
          Hero(
            tag: 'game_${gameList[index].name}', 
            child: Container(
              height: 120,
              width: double.infinity,
              child: ClipRRect( 
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                gameList[index].imageUrls[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          ),
            Text(gameList[index].name),
            Text("Review: ${gameList[index].reviewAverage}")
          ],
        ),
      ),
    );
  }
}