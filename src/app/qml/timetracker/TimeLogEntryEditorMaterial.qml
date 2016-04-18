import QtQuick 2.4
import Qt.labs.controls 1.0
import TimeLog 1.0
import "Util.js" as Util
import "Texts.js" as Texts

Column {
    id: delegateEditor

    property date startTimeAfter: new Date(0)
    property date startTimeBefore: new Date()
    property var startTimeCurrent: new Date()

    property alias category: categoryPicker.category
    property var startTime: new Date()
    property alias comment: commentArea.text

    property bool acceptable: !!category

    property bool singleColumn: false

    QtObject {
        id: d

        property int durationTime: Util.calcDuration(startTime, startTimeBefore)
    }

    spacing: 10

    CategoryPicker {
        id: categoryPicker
    }

    LabelControl {
        text: Texts.labelText(qsTranslate("entry editor", "Start date"))
    }

    DatePicker {
        id: calendar

        property alias origDate: delegateEditor.startTimeCurrent

        minimumDate: new Date(startTimeAfter.valueOf() + 1000)
        maximumDate: new Date(startTimeBefore.valueOf() - 1000)

        onOrigDateChanged: selectedDate = origDate
    }

    LabelControl {
        text: Texts.labelText(qsTranslate("entry editor", "Start time"))
    }

    TimeEditor {
        id: timeEditor

        startDateCurrent: calendar.selectedDate
        minDateTime: new Date(startTimeAfter.valueOf() + 1000)
        maxDateTime: new Date(startTimeBefore.valueOf() - 1000)

        onStartTimeCurrentChanged: {
            if (delegateEditor.startTime != startTimeCurrent) {
                delegateEditor.startTime = startTimeCurrent
            }
        }
    }

    LabelControl {
        text: Texts.labelText(qsTranslate("entry editor", "Duration"))
    }

    LabelControl {
        elide: Text.ElideRight
        text: TimeTracker.durationText(d.durationTime)
    }

    TextAreaControl {
        id: commentArea

        property alias origComment: delegateEditor.comment

        width: parent.width
        placeholderText: Texts.labelText(qsTranslate("entry editor", "Comment"))
    }

    onStartTimeCurrentChanged: {
        if (timeEditor.startTimeCurrent != startTimeCurrent) {
            timeEditor.startTimeCurrent = startTimeCurrent
        }
    }
}