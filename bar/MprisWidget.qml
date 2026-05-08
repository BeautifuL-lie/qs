import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import qs.color as Color

Item {
    readonly property MprisPlayer player: {
        const players = Mpris.players.values;
        if (players.length > 0)
            return players[0];
        else
            return null;
    }
    readonly property string songTitle: player?.trackTitle
    readonly property string songArtist: player?.trackArtist

    width: 250
    height: 32
    clip: true

    Text {
        id: txt

        width: parent.width
        horizontalAlignment: Text.AlignRight
        anchors.verticalCenter: parent.verticalCenter
        visible: player !== null && songTitle !== "" && songArtist !== ""
        text: "󰎇 " + songArtist + " - " + songTitle
        font.pixelSize: 10
        font.family: "JetBrainsMono Nerd Font Propo"
        elide: Text.ElideRight
        color: Color.Matugen.colors.on_background

    }


}
