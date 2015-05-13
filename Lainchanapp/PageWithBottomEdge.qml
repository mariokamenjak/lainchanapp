// PageWithBottomEdge.qml
/*
  This file is part of instantfx
  Copyright (C) 2014 Stefano Verzegnassi

    This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License 3 as published by
  the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
  along with this program. If not, see http://www.gnu.org/licenses/.
*/

import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Web 0.2
import QtQuick.Window 2.0
import Ubuntu.Connectivity 1.0
import Ubuntu.Layouts 0.1

Page {
    id: page

    //readonly property alias head: header
    default property alias containerData: container.data

    property alias bottomEdgePanelData: bottomEdgeContainer.data
    property alias bottomEdgeTitle: tipLabel.text

    property real bottomEdgePageOpacity: 0.85

    property bool bottomEdgeEnabled: true

    /*CustomHeader {
        id: header

        Connections {
            target: bottomEdge
            onPositionChanged: {
                if (bottomEdge.position < (bottomEdge.height / 2))
                    header.opacity = (bottomEdge.position / bottomEdge.height) * 2
                if (bottomEdge.position > (bottomEdge.height / 2))
                    header.opacity = 1
            }
        }
    }*/


    Layouts {
         objectName: "layouts"
         id: layouts
         anchors.fill: parent
         layouts: [
             ConditionalLayout {
                 name: "big"
                 when: layouts.width > units.gu(137)
                 Column {

                     anchors.fill:parent
                     Row{
                         height:parent.height
                         width:parent.width




                     ItemLayout {
                         item: "webview1"
                         ItemLayout {
                             item: "pbar1"
                             width: parent.width
                             height:units.gu(0.1)
                             anchors {
                                             top: parent.top
                                         }

                         }
                         width: parent.width
                         anchors {
                                         top: parent.top
                                         bottom: parent.bottom
                                     }


                     }
                     }
                     ItemLayout {
                                  item: "hint"
                                  visible: page.bottomEdgeEnabled
                                  //color: Qt.rgba(0.0, 0.0, 0.0, 0.3)

                                  // Size from the official PageWithBottomEdge component
                                  width: tipLabel.paintedWidth + units.gu(6)
                                  height: units.gu(4)


                                  y: page.height - units.gu(3) + (bottomEdge.height - bottomEdge.position)
                                  anchors.horizontalCenter: parent.horizontalCenter



                              }
                     ItemLayout {
                                      item: "panel"
                                      width: parent.width
                                      height: units.gu(10)
                                      anchors {
                                               // left: parent.left
                                               //right: parent.right
                                               bottom: parent.bottom
                                      }


                                  }
                     Panel {
                             id: panel
                             align:Qt.AlignRight
                             anchors {
                                 //left: parent.left
                                 right: parent.right
                                 top: parent.top
                             }
                             width: units.gu(100)
                             height: units.gu(100)
                             Rectangle {
                                 color: Theme.palette.normal.overlay
                                 anchors.fill: parent
                                 WebView {



                                     id: webviewirc
                                     /*QtObject {
                                             id: internal

                                             readonly property var downloadMimeTypesBlacklist: [
                                                 "application/x-shockwave-flash", // http://launchpad.net/bugs/1379806
                                             ]
                                         }*/
                                                 width: parent.width
                                                 height: units.gu(90)
                                                 filePicker: filePickerLoader.item
                                                 //onLoadFinished: area.contentY = -1 // workaround to force webview repaint
                                                 Component.onCompleted: {
                                                     url = "https://lainchan.org/irc"

                                                 }

                                 }
                                 Text
                                 {
                                     anchors.bottom: parent.bottom
                                     anchors.left: parent.left
                                     text: "Clcik anywhere on the white space and drag it back right."
                                 }
                             }
                     }

                 }


             },
             ConditionalLayout {
                 name: "small"
                 when: layouts.width < units.gu(137)
                 Column {

                     anchors.fill:parent



                     ItemLayout {
                         item: "webview1"
                         ItemLayout {
                             item: "pbar1"
                             width: parent.width
                             height:units.gu(0.1)
                             anchors {
                                             top: parent.top
                                         }

                         }
                         width: parent.width
                         anchors {
                                         top: parent.top
                                         bottom: parent.bottom
                                     }
                     }
                     Row{
                         height:parent.height
                         width:parent.width


                     ItemLayout {
                                  item: "hint"
                                  visible: page.bottomEdgeEnabled
                                  //color: Qt.rgba(0.0, 0.0, 0.0, 0.3)

                                  // Size from the official PageWithBottomEdge component
                                  width: tipLabel.paintedWidth + units.gu(6)
                                  height: units.gu(4)


                                  y: page.height - units.gu(3) + (bottomEdge.height - bottomEdge.position)
                                  anchors.horizontalCenter: parent.horizontalCenter


                              }
                     ItemLayout {
                                      item: "panel"
                                      width: parent.width
                                      height: units.gu(10)
                                      anchors {
                                               // left: parent.left
                                               //right: parent.right
                                               bottom: parent.bottom
                                      }


                                  }
                     }


                 }

             }
         ]
         ProgressBar {
                 id: determinateBar
                 minimumValue: 0
                 maximumValue: 100
                 value:webview.loadProgress
                 Layouts.item:"pbar1"
                 width:parent.width
                 height:units.gu(0.1)
             }
         WebView {



             id: webview
             /*QtObject {
                     id: internal

                     readonly property var downloadMimeTypesBlacklist: [
                         "application/x-shockwave-flash", // http://launchpad.net/bugs/1379806
                     ]
                 }*/
                         width: parent.width
                         height: parent.height
                         filePicker: filePickerLoader.item
                         Layouts.item: "webview1"
                         //onLoadFinished: area.contentY = -1 // workaround to force webview repaint
                         Component.onCompleted: {
                             url = "https://lainchan.org/"

                         }

                         onDownloadRequested: {
                                 /*if (!request.suggestedFilename && request.mimeType &&
                                     internal.downloadMimeTypesBlacklist.indexOf(request.mimeType) > -1) {
                                     return
                                 }*/
                             console.log('Downloading image: ')

                                 if (downloadLoader.status == Loader.Ready) {
                                     var headers = { }
                                     if(request.cookies.length > 0) {
                                         headers["Cookie"] = request.cookies.join(";")
                                     }
                                     if(request.referrer) {
                                         headers["Referer"] = request.referrer
                                     }
                                     headers["User-Agent"] = webview.context.userAgent
                                     downloadLoader.item.downloadMimeType(request.url, request.mimeType, headers, request.suggestedFilename)
                                 }
                             }
                         Loader {
                                 id: filePickerLoader

                                    function sizeweb(){
                                     var size="ContentPickerDialog.qml"
                                     if(webview.width>units.gu(137)){
                                             size="FilePickerDialog.qml"
                                         }
                                    if(webview.width<units.gu(137))
                                     {
                                         size="ContentPickerDialog.qml"
                                     }
                                         return size
                                     }
                                 source: sizeweb()
                                 //source:"FilePickerDialog.qml"
                                 asynchronous: true
                             }
                         Loader {
                                 id: downloadLoader
                                 source: "Downloader.qml"
                                 asynchronous: true
                             }

                     }



    Item {
        id: container

        clip: true

        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    // tip
    UbuntuShape {
        id: tip

        visible: page.bottomEdgeEnabled
        color: Qt.rgba(0.0, 0.0, 0.0, 0.3)

        // Size from the official PageWithBottomEdge component
        width: tipLabel.paintedWidth + units.gu(6)
        height: units.gu(4)
        Layouts.item:"hint"

        y: page.height - units.gu(3) + (bottomEdge.height - bottomEdge.position)
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: tipLabel

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            text: "test"

            fontSize: "x-small"
            height: units.gu(2)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    // bottom edge panel
    Panel {
        id: bottomEdge

        enabled: page.bottomEdgeEnabled
        visible: page.bottomEdgeEnabled
        locked: !page.bottomEdgeEnabled
        triggerSize: units.gu(1.2)

        height: units.gu(10)
        Layouts.item: "panel"

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }


        Rectangle {
            Layouts.item: "rectanglepanel1"
            height: 1
            color: "black"
            opacity: bottomEdgePageOpacity * (page.height - bottomEdge.position) / page.height

            anchors.fill: parent
        }

        Item {
            id: bottomEdgeContainer
            Layouts.item: "itemc"

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                //bottom: closeButton.top
            }
        }
        Column{
                    width: units.gu(30)

                Row
                {
                    Button {
                        objectName: "button"
                        iconSource: "refresh.png"
                        width: units.gu(7)


                        //text: i18n.tr("Osvježi")

                        onClicked: {
                            webview.reload()
                        }
                    }
                    Button {
                        objectName: "button"
                        width: units.gu(7)
                        iconSource: "backward.png"


                        //text: i18n.tr("Natrag")

                        onClicked: {
                            webview.goBack()
                        }
                    }
                    Button {
                        objectName: "button"
                        width: units.gu(7)
                        iconSource: "forward.png"


                        //text: i18n.tr("Naprijed")

                        onClicked: {
                            webview.goForward()
                        }
                    }
                    Button {
                        objectName: "button"
                        width: units.gu(12)
                        //iconSource: "forward.png"


                        text: i18n.tr("Home")

                        onClicked: {
                            webview.url="https://lainchan.org/"
                        }
                    }
                }

                  Row
                  {
                      Button {
                          objectName: "button"
                          width: units.gu(10)
                          //iconSource: "forward.png"


                          text: i18n.tr("/cyb")

                          onClicked: {
                              webview.url="https://lainchan.org/cyb/index.html"
                          }
                      }

                      Button {
                          objectName: "button"
                          width: units.gu(12)
                          //iconSource: "forward.png"


                          text: i18n.tr("/lambda")

                          onClicked: {
                              webview.url="https://lainchan.org/%CE%BB/index.html"
                          }
                      }
                      Button {
                          objectName: "button"
                          width: units.gu(12)
                          //iconSource: "forward.png"


                          text: i18n.tr("/tech")

                          onClicked: {
                              webview.url="https://lainchan.org/tech/index.html"
                          }
                      }

                  }
                  Row
                  {
                      Text {
                          id: text1
                          text: NetworkingStatus.online ? "  Online" : "  Not online"
                          font.family: "Helvetica"
                          //font.pointSize: 24

                          function color1()
                          {
                              var color
                              if(NetworkingStatus.online==true)
                              {
                                  color="orange"
                              }
                              else
                              {
                                  color="purple"
                              }

                              return color
                          }
                          color:color1()

                      }
                      Text {
                          text: NetworkingStatus.limitedBandwith ? "  Bandwith limited" : "  Bandwith not limited"
                          font.family: "Helvetica"
                          //font.pointSize: 24
                          function color2()
                          {
                              var color
                              if(NetworkingStatus.limitedBandwith==false)
                              {
                                  color="orange"
                              }
                              else
                              {
                                  color="purple"
                              }

                              return color
                          }
                          color:color2()
                      }
                  }
}
    }
}

}
