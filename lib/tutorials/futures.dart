/*
Future Part-I

String fetchLatestNews(){
  var news = fetchFromServer();
  return "[From Server]: $news";
}

// Future is Dart Async Programming Concept
// Something which will be delayed to be received, we return it as Future
Future<String> fetchFromServer(){
  return Future.delayed(  // explicit delay from us as developer
    Duration(seconds:3),
    ()=> "The next-gen Xbox will ship in November" // cosidering this will come from server
  );
}

// main function represents main UI thread in our Flutter App
void main() {
  print("App Started");
  String latestNews = fetchLatestNews();
  print("Latest News is: $latestNews");
  print("App Finished");

}
*/


/*

Future Part-II

// Future is Dart Async Programming Concept
// Something which will be delayed to be received, we return it as Future
// A function giving future in return is itself running parallely with the main
Future<void> fetchFromServer(){
  return Future.delayed(  // explicit delay from us as developer
    Duration(seconds:3),
    ()=> print("The next-gen Xbox will ship in November"));
}

// main function represents main UI thread in our Flutter App
void main() {
  print("App Started");
  print("Fetching News");
  fetchFromServer();
  print("News Displayed");
  print("App Finished");

}


*/


/*

Future Part-III

Future<String> fetchLatestNews() async{
  print("fetchLatestNews started");
  var news = await fetchFromServer(); // till time fetchFromServer will not give us the result,fetchLatestNews will be on halt and will not execute further
  print("fetchLatestNews finished");
  return "[From Server]: $news";
}

// Function becomes asynchronous i.e. it will run paralley to the main
// it runs in background and ensures something will begien in Future
Future<String> fetchFromServer(){
  return Future.delayed(  // explicit delay from us as developer
      Duration(seconds:3),
          ()=> "The next-gen Xbox will ship in November" // cosidering this will come from server
  );
}


// main function represents main UI thread in our Flutter App
void main() async{
  print("App Started");
  print("Fetching News From Server");
  var latestNews = await fetchLatestNews();
  print("Latest News is: $latestNews");
  print("App Finished");

}
 */