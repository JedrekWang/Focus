import 'dart:io';
import 'dart:convert';

class RssLoader {

  // 订阅源url
  String rssUrl;

  RssLoader(this.rssUrl);

  Future loadRssUrl() async {
    var httpClient = HttpClient();
    // ignore: close_sinks
    var request = await httpClient.getUrl(Uri.parse(rssUrl));
    var response = await request.close();
    if (response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      // responseBody = json.decode(responseBody);
      print(responseBody);
      return responseBody;
    } else {
      print("error");
    }
    return "";
  }

}