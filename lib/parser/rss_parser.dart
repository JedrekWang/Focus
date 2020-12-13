import "package:xml/xml.dart";
import 'dart:io';
import 'package:mustache/mustache.dart';
import 'dart:convert' show HtmlEscape;

class RSSItem {
  final String title;
  final String creator;
  final String pbuDate;
  final String desc;

  RSSItem(this.title, this.creator, this.desc, {this.pbuDate});
}

class RSSParser {
  File rssFile;

  RSSParser(String path) {
    this.rssFile = File(path);
  }

  List<RSSItem> parseRSSItems() {
    final document = XmlDocument.parse(this.rssFile.readAsStringSync());
    final titles = document.findAllElements('title');
    final creators = document.findAllElements('dc:creator');
    final descriptions = document.findAllElements('description');
    var items = List<RSSItem>();
    for (int i = 0; i < titles.length - 1; i++) {
      items.add(RSSItem(titles.elementAt(i).text, creators.elementAt(i).text,
          descriptions.elementAt(i).text));

    }
    return items;
  }
}
//
// main() {
//   final file = new File('D:\\Code\\dart_sample\\zhihu.xml');
//   final document = XmlDocument.parse(file.readAsStringSync());
//   final titles = document.findAllElements('title');
//   final creators = document.findAllElements('dc:creator');
//   final descriptions = document.findAllElements('description');
//
//   File template_file = File("D:\\Code\\dart_sample\\template.html");
//   final content = template_file.readAsStringSync();
//   var template = new Template(content, htmlEscapeValues: false);
//   for (int i = 0; i < titles.length - 1; i++) {
//     var title = titles.elementAt(i).text;
//     var creator = creators.elementAt(i).text;
//     var desc = descriptions.elementAt(i).text;
//     var output = template
//         .renderString({'title': title, 'author': creator, "content": desc});
//     File new_file = File("D:\\Code\\dart_sample\\out\\${i}.html");
//     new_file.writeAsStringSync(output);
//   }
// }
