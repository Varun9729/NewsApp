import 'package:flutter/material.dart';
import 'package:thenewsapplication/news.dart';
import 'package:thenewsapplication/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newsList;
  bool isLoading = true;

@override
void initState() { 
  super.initState();
  getCategoryNews();
  
}

void getCategoryNews() async {
    CategoryNewsClass news = CategoryNewsClass();
    await news.getNews(widget.category);
    newsList = news.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News"),
            Text(
              "App",
              style: TextStyle(color: Colors.orangeAccent),
            )
          ],
        ),
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.orangeAccent,
            )):SingleChildScrollView(
              child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: newsList.length,
                              itemBuilder: (context, index) {
                                return NewsTile(
                                    ImageURL: newsList[index].urlToImage ?? "",
                                    title: newsList[index].title ?? "",
                                    postURL: newsList[index].url ?? "",
                                    description:
                                        newsList[index].description ?? "");
                              }),
                        ),
            ),
      
    );
  }
}


class NewsTile extends StatelessWidget {
  final String ImageURL, title, description, postURL;
  NewsTile(
      {@required this.ImageURL,
      @required this.title,
      @required this.description,
      @required this.postURL});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArticleView(postURL:postURL ,)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xff707070),
                  width: 1,
                ),
                image: DecorationImage(
                    image: NetworkImage(ImageURL), fit: BoxFit.fill),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.black.withOpacity(0.49),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      child: Center(
                        child: Text(
                          description,
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                  fontFamily: "League",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
