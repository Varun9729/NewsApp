import 'dart:convert';

import 'package:http/http.dart' as http;

class Article {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
 

  Article(
      {this.author,
      this.content,
      this.description,
      this.title,
      this.url,
      this.urlToImage,
      });
}

class News {
  List<Article> news = [];
  Future<void> getNews() async {
    
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=c620bb23e60e4eb8bdb6f611b00b41f3";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
class CategoryNewsClass {
  List<Article> news = [];
  Future<void> getNews(String category) async {
    
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=c620bb23e60e4eb8bdb6f611b00b41f3";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

