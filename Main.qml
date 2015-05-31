import QtQuick 2.0
import Ubuntu.Components 1.1

MainView {
  objectName: "mainView"
  applicationName: 'poonal.rene-so36'
  useDeprecatedToolbar: false
  width: units.gu(70)
  height: units.gu(100)
  automaticOrientation : true

  PageStack {
    id: pageStack
    Component.onCompleted: push(listPage)

    Page {
      id: noticePage
      title: 'Log...'
      Text {
        id: noticeContent
        width: parent.width - units.gu(2)
        wrapMode: Text.WordWrap
        text: ''
      }
    }

    Page {
      id: listPage
      title: "Poonal"
      head.contents: Image {
          fillMode: Image.PreserveAspectFit
          source: "poonal-header.png"
      }
      UbuntuListView {
        id: listView
        anchors.fill: parent
        model: FeedListModel{id: feedListModel}
        delegate: ArticleDelegate{}

        PullToRefresh {
          refreshing: listView.model.status === feedListModel.Loading
          onRefresh: listView.model.reload()
        }
      }
    }

    Page {
      id: articlePage
      title: "Artikel"
      visible: false

      Flickable {
        id: content
        anchors.fill: parent
        contentHeight:  articleContentText.height + units.gu(6)
        leftMargin: units.gu(1)

        Column {
          id: headerColumn
          width: parent.width
          height: units.gu(2)

          Text {
            id: articleHeading
            width: parent.width - units.gu(2)
            wrapMode: Text.WordWrap
            onLinkActivated: Qt.openUrlExternally(link)
            font.italic: true
            verticalAlignment: Text.AlignVCenter
            text: ''
          }
        }

        Column {
          width: parent.width
          anchors.top: headerColumn.bottom
          anchors.topMargin: units.gu(2)

          Text {
            id: articleContentText
            width: parent.width - units.gu(2)
            wrapMode: Text.WordWrap
            onLinkActivated: Qt.openUrlExternally(link)
            text: ''
          }
        }
      }
    }
  }
}
