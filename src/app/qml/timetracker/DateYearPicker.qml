import QtQuick 2.0
import QtQuick.Controls 1.4

Row {
    property var beginDate: new Date()
    property var endDate: new Date()

    spacing: 10

    ComboBox {
        id: periodSelector

        model: [
            "current",
            "previous",
            "select..."
        ]

        onCurrentIndexChanged: {
            switch (currentIndex) {
            case 0:
                endDate = new Date()
                beginDate = new Date(new Date(new Date().setFullYear(endDate.getFullYear(), 0 , 1)).setHours(0, 0, 0, 0))
                break
            case 1:
                endDate = new Date(new Date(new Date().setMonth(0, 1)).setHours(0, 0, 0, 0) - 1000)
                beginDate = new Date(new Date(new Date(endDate).setMonth(0, 1)).setHours(0, 0, 0, 0))
                break
            }
        }
    }

    TextField {
        id: dateField

        visible: periodSelector.currentIndex == 2

        anchors.verticalCenter: parent.verticalCenter
        inputMask: "9999"
        text: beginDate.toLocaleDateString(Qt.locale(), "yyyy")

        onEditingFinished: {
            beginDate = Date.fromLocaleString(Qt.locale(), text, "yyyy")
            endDate = new Date(new Date(new Date(beginDate).setFullYear(beginDate.getFullYear() + 1, 0, 1)).setHours(0, 0, 0, 0) - 1000)
        }
    }
}