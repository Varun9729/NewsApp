import 'package:flutter/material.dart';
import 'package:thenewsapplication/data.dart';
import 'package:thenewsapplication/news.dart';
import 'package:thenewsapplication/views/article_view.dart';
import 'package:thenewsapplication/views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var newsList;
  bool isLoading = true;
  List<CategoryModel> categories = [];
  // List<ArticleModel> articles = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();

    categories = getCategories;
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
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
            ))
          : SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              ImageURL: categories[index].imageURL,
                              categoryName: categories[index].categoryName,
                            );
                          },
                        ),
                      ),

                      //NEWS FEED
                      Container(
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
                    ],
                  )
                  // CATEGORIES

                  ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String ImageURL, categoryName;

  CategoryTile({this.ImageURL, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(category: categoryName.toLowerCase(),)
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                ImageURL,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black38.withOpacity(0.42),
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
            context, MaterialPageRoute(builder: (context) => ArticleView(postURL: postURL,)));
      },
      child: Container(
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
