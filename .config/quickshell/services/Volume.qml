pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import qs

Singleton {
    id: root
    
    PwObjectTracker {
        objects: [microphone, sound]
    }
    
    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    property var microphone: Pipewire.defaultAudioSource
    property var sound: Pipewire.defaultAudioSink

    property bool isMicMuted: microphone.audio.muted 
    property bool isSoundMuted: sound.audio.muted

    property real soundVolume: sound?.audio.volume ?? 0

    function toggleSoundMute() {
        sound.audio.muted = !sound.audio.muted
    }

    function toggleMicMute() {
        microphone.audio.muted = !microphone.audio.muted
    }

    function setMicVolume(volume: real) {
        volume = Math.max(0, Math.min(volume, 1.5))
        microphone.audio.muted = false 
        microphone.audio.volume = volume
    }

    function setVolume(volume: real) {
        volume = Math.max(0, Math.min(volume, 1.5))
        sound.audio.muted = false
        sound.audio.volume  = volume
    }

    Connections { // Protection against sudden volume changes
        target: sound?.audio ?? null
        property bool lastReady: false
        property real lastVolume: 0
        function onVolumeChanged() {
            if (!Config.audio.enableProtection)
                return;
            const newVolume = sound.audio.volume;
            // when resuming from suspend, we should not write volume to avoid pipewire volume reset issues
            if (isNaN(newVolume) || newVolume === undefined || newVolume === null) {
                lastReady = false;
                lastVolume = 0;
                return;
            }
            if (!lastReady) {
                lastVolume = newVolume;
                lastReady = true;
                return;
            }
            const maxAllowedIncrease = Config.audio.maxAllowedIncrease / 100; 
            const maxAllowed = Config.audio.maxAllowed / 100;

            if (newVolume - lastVolume > maxAllowedIncrease) {
                sound.audio.volume = lastVolume;
                //root.sinkProtectionTriggered(Translation.tr("Illegal increment"));
            } else if (newVolume > maxAllowed || newVolume > Config.audio.hardMaxValue) {
                //root.sinkProtectionTriggered(Translation.tr("Exceeded max allowed"));
                sound.audio.volume = Math.min(lastVolume, maxAllowed);
            }
            lastVolume = sound.audio.volume;
        }
    }

}