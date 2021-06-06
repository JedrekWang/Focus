class RssChannel {
  // 表示RSS订阅的频道
  String title;
  String link;
  String desc;
  String updateDate;
  List<RssItem> rssItemList;

}


class RssItem {
  // 表示每个频道里面的每一个项目，ex: 一篇文章，一段视频
  String title;
  String link;
  String desc;
  String creator;
  String pubDate;
}