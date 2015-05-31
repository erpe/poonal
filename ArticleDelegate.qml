import QtQuick 2.0
import Ubuntu.Components.ListItems 1.0 as ListItem

ListItem.Subtitled {
    id: container

   function formatDate(date) {
      return date.split("+")[0];
    }

    text: title
    subText: formatDate(pubDate)
    selected: false
    progression: true
    //iconName: "view-expand"
    onClicked: {
        articleHeading.text = formatDate(pubDate)
        articlePage.title = title
        articleContentText.text =  description
        pageStack.push(articlePage, index )
    }
}
