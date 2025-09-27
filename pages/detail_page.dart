import 'package:flutter/material.dart';
import 'package:pengolahan_data/models/game_store.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailPage extends StatelessWidget {
  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tidak bisa membuka link: $url")),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }
  final GameStore game;
  const DetailPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(  
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Hero(
              tag: 'game_${game.name}',  
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(game.imageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

  
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text("Release: ${game.releaseDate}", style: TextStyle(color: Colors.white70)),
                  Text("Price: ${game.price}", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(" ${game.reviewAverage} (${game.reviewCount} reviews)", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            Text("Tags:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: game.tags.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                    ),
                    child: Text(
                      game.tags[index],
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            Text("About:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              game.about,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                  _launchUrl(context, game.linkStore);
                print("Opening ${game.linkStore}");  
              },
        
              label: Text("Buka di Store"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),

            if (game.imageUrls.length > 1) ...[
              Text("More Images:", style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: PageView.builder(
                  itemCount: game.imageUrls.length - 1, 
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(game.imageUrls[index + 1]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}