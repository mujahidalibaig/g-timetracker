import QtQuick 2.4
import QtQuick.Layouts 1.1
import TimeLog 1.0

Item {
    property string title: qsTranslate("main window", "Recent")

    ReverseProxyModel {
        id: timeLogModel

        sourceModel: TimeLogRecentModel {
            timeTracker: TimeTracker
        }
    }

    ColumnLayout {
        anchors.fill: parent

        TimeLogView {
            id: timeLogView

            Layout.fillHeight: true
            Layout.fillWidth: true
            reverse: true
            model: timeLogModel

            onInsert: timeLogModel.insertItem(modelIndex, newData)
            onAppend: timeLogModel.appendItem(newData)
            onRemove: timeLogModel.removeItem(modelIndex)
        }

        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
            implicitHeight: 50

            PushButton {
                anchors.centerIn: parent
                text: qsTranslate("TimeLogView", "Add")
                onClicked: timeLogView.itemAppend()
            }
        }
    }
}