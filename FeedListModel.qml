import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components 1.1

XmlListModel {
  id: feedListModel
  source: "http://www.npla.de/poonal?format=feed&type=rss"
  query: "/rss/channel/item"

  namespaceDeclarations: "declare namespace dc='http://purl.org/dc/elements/1.1/'; declare namespace content='http://purl.org/rss/1.0/modules/content/';"

  XmlRole { name: "title"; query: "title/string()"; }
  XmlRole { name: "pubDate"; query: "pubDate/string()"; }
  XmlRole { name: "description"; query: "description/string()"; }
  XmlRole { name: "category"; query: "category/string()"; }

  onStatusChanged: {
    if (status === XmlListModel.Loading) 
      console.log("Loading...")
      noticeContent.text = "Loading..."
      pageStack.push(noticePage)
    if (status === XmlListModel.Ready) {
      console.log("Loaded " + source)
      if (status === XmlListModel.Error) {
        console.log("XmlError: " + errorString())
        noticeContent.text = "Error loading: " + errorString()
        pageStack.push(noticePage)
      } else {
        pageStack.clear()
        pageStack.push(listPage)
      }
    }
  }
}
