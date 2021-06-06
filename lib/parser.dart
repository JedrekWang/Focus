import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart';

import 'models.dart';

class RssParser {
  String rssUrl;

  RssParser(this.rssUrl);

  RssItem handleItem(XmlNode node) {
    RssItem item = RssItem();
    item.title = node.getElement("title").innerText;
    item.link = node.getElement("link").innerText;
    item.desc = node.getElement("description").innerText;
    item.creator = node.getElement("dc:creator").innerText;
    item.pubDate = node.getElement("pubDate").innerText;

    return item;
  }

  RssChannel handleChannel(XmlNode node) {
    RssChannel channel = RssChannel();
    channel.title = node.getElement("title").innerText;
    channel.link = node.getElement("link").innerText;
    channel.desc = node.getElement("description").innerText;
    channel.updateDate = node.getElement("lastBuildDate").innerText;
    var items = node
        .findAllElements("item")
        .map((element) => handleItem(element))
        .toList();
    channel.rssItemList = items;
    return channel;
  }

  parseRss() async {
    var httpClient = HttpClient();
    // ignore: close_sinks
    var request = await httpClient.getUrl(Uri.parse(rssUrl));
    var response = await request.close();
    if (response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      List<RssChannel> channelList = XmlDocument.parse(responseBody)
          .findAllElements("channel")
          .map((element) => handleChannel(element))
          .toList();
      return channelList;
    } else {
      throw Exception("parse failed");
    }
  }
}
