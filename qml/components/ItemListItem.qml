import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

ListItem {
    height: layout.height
    id: itemListItem

    function getDateString () {
        return (new Date (timestamp)).toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
    }

    ListItemLayout {
        id: layout
        title.text: "<b>" + name + "</b>" + " (" + getDateString() + ")"
        subtitle.text: calories + " " + i18n.tr("kilocalories")
        Icon {
            source: calories > 0 ? "../../assets/meal.svg" : "../../assets/sports.svg"
            width: units.gu(6)
            height: units.gu(6)
            SlotsLayout.position: SlotsLayout.Leading
        }
    }

    // Delete Button
    leadingActions: ListItemActions {
        actions: [
        Action {
            iconName: "delete"
            onTriggered: {
                db.transaction(
                    function(tx) {
                        tx.executeSql('DELETE FROM Items WHERE Timestamp = "' + timestamp + '"')
                    }
                )
                calculate ()
            }
        }
        ]
    }
}
