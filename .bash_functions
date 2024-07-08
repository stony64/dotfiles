####################################################
###
### Function
###
####################################################

# Bash-Completion fuer Funktionen hinzufuegen
# Zeigt alle definierten Funktionen an
# Mit `declare -F` werden alle Funktionen aufgelistet, `awk` extrahiert den Namen der Funktionen,
# und `sort` sortiert sie alphabetisch.

function show_functions() {
    echo "Definierte Funktionen:"
    declare -F | awk '{print $3}' | sort
}

## Diese Funktion generiert die Vervollstaendigungsvorschlaege fuer `show_functions`.
## `compgen -W` wird verwendet, um eine Liste moeglicher Vervollstaendigungen zu generieren.
function _show_functions_completion() {
    COMPREPLY=($(compgen -W "$(declare -F | awk '{print $3}')" -- "${COMP_WORDS[COMP_CWORD]}"))
}

complete -F _show_functions_completion show_functions

# Bash-Completion fuer Aliase hinzufuegen
# Zeigt alle definierten Aliase an
## Nutzt `alias` und `sed`, um nur die Aliase anzuzeigen.

function show_aliases() {
    echo "Definierte Aliase:"
    alias | sed 's/alias //'
}

# Aktiviert die Bash-Completion für die Funktion `show_aliases`.
# Verwendet `compgen -W`, um eine Liste der möglichen Vervollständigungen zu generieren.
function _show_aliases_completion() {
    COMPREPLY=($(compgen -W "$(alias | awk '{print $2}' | cut -d= -f1)" -- "${COMP_WORDS[COMP_CWORD]}"))
}

complete -F _show_aliases_completion show_aliases

# Extrahiert Archive basierend auf ihrer Dateierweiterung (.tar.gz, .tar.bz2, .tar.xz, .gz, .tar, .zip, .bz2).
function extract() {
    if [[ "$1" == "--help" || -z "$1" ]]; then
        echo "Verwendung: extract <archivdatei>"
        return 1
    fi

    if [ -f "$1" ]; then
        case $1 in
        *.tar.gz) tar xvzf $1 ;;
        *.tar.bz2) tar xvjf $1 ;;
        *.tar.xz) tar xf $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xvf $1 ;;
        *.zip) unzip $1 ;;
        *.bz2) bzip2 -d $1 ;;
        *) echo "$1 kann mit diesem Befehl nicht extrahiert werden." ;;
        esac
    else
        echo "Entschuldigung, $1 ist kein gueltiges Archiv."
        return 1
    fi
}

# Loescht den Bildschirminhalt durch Ausfuehren des `clear`-Befehls.
function cls() {
    clear
}

# Zeigt den gesamten Befehlsverlauf der aktuellen Shell-Sitzung.
function h() {
    history
}

# Loescht den gesamten Befehlsverlauf der aktuellen Shell-Sitzung und beendet die Shell.
function clear_history() {
    cat /dev/null >~/.bash_history && history -c && exit
}

# Zeigt die Ausgabe des `mount`-Befehls in Spaltenform an, um die aktuell eingehaengten Dateisysteme zu ueberblicken.
function mounted() {
    /bin/mount | column -t
}

# Wechselt ein Verzeichnis nach oben und zeigt den neuen Pfad an.
function ..() {
    builtin cd ..
    pwd
}

# Wechselt zwei Verzeichnisse nach oben und zeigt den neuen Pfad an.
function ...() {
    builtin cd ../..
    pwd
}

# Listet fast alle Dateien im aktuellen Verzeichnis auf, inklusive Klassifikation (z.B. Verzeichnis, ausfuehrbare Datei).
function l() {
    ls --color=auto -F
}

# Listet alle Dateien im aktuellen Verzeichnis auf, inklusive Klassifikation, Groessenangabe und Datum der letzten Aenderung.
function la() {
    ls --color=auto -A -F -h --time-style=+"%Y-%m-%d %H:%M:%S"
}

# Listet alle Dateien im aktuellen Verzeichnis auf, ausfuehrlich mit Klassifikation, Groessenangabe und Datum der letzten Aenderung.
function ll() {
    ls --color=auto -A -F -l -h --time-style=+"%Y-%m-%d %H:%M:%S"
}

# Listet alle Dateien im aktuellen Verzeichnis auf, ausfuehrlich mit Klassifikation, Groessenangabe und Datum der letzten Aenderung,
# sortiert nach Zeit (neueste zuletzt).
function lt() {
    ls --color=auto -A -F -l -h -t -r --time-style=+"%Y-%m-%d %H:%M:%S"
}

# Listet alle versteckten Dateien und Verzeichnisse im aktuellen Verzeichnis auf.
function l.() {
    ls --color=auto -A -F -d .*
}

# Listet alle Verzeichnisse im aktuellen Verzeichnis auf, inklusive Klassifikation und detaillierten Informationen.
function d() {
    dir -lhaF --time-style=+"%Y-%m-%d %H:%M:%S" --color=always | egrep '^d'
}

# Zeigt die 20 groessten Dateien und Verzeichnisse im aktuellen Verzeichnis, sortiert nach Groesse.
function biggest() {
    du -sk * | column -t | sort -nr | head -20
}

# Zeigt die aktuelle Uhrzeit im Format Stunde:Minute:Sekunde an.
function t() {
    date +%H:%M:%S
}

# Sucht nach einem Prozessnamen und zeigt die dazugehoerige Prozessliste an.
function psg() {
    if [[ "$1" == "--help" || -z "$1" ]]; then
        echo "Verwendung: psg <prozessname>"
        return 1
    fi
    ps -ef | grep "$1" | grep -v grep
}

# Zeigt alle aktiven Netzwerkports und die zugehoerigen Prozesse an.
function ports() {
    ss -tulpn
}

# Sucht im Befehlsverlauf nach einem Suchmuster und zeigt die uebereinstimmenden Eintraege an.
function hg() {
    if [[ "$1" == "--help" || -z "$1" ]]; then
        echo "Verwendung: hg <suchmuster>"
        return 1
    fi
    history | grep "$1"
}

# Zeigt alle Anwendungen an, die derzeit mit dem Netzwerk verbunden sind.
function listening() {
    lsof -P -i -n
}

# Gibt die Anzahl der installierten Pakete auf dem System aus.
function pkgnum() {
    dpkg --get-selections | wc -l
}

# Erstellt eine Sicherungskopie der angegebenen Datei.
function bak() {
    if [[ "$1" == "--help" || -z "$1" ]]; then
        echo "Verwendung: bak <dateiname>"
        return 1
    fi
    cp -v "$1" "${1}.bak"
}

# Fuehrt ein Systemupdate und bereinigt die Paketquellen, abhaengig vom Hostnamen.
function au() {
    clear
    local hostname=$(hostname)
    local header="Hostname: $hostname"
    local header_length=${#header}
    local min_width=40 # Mindestbreite fuer den Rahmen

    local border_width=$(((min_width - header_length - 2) / 2)) # Abzug fuer die Raute-Zeichen

    if ((border_width < 0)); then
        border_width=1
    fi

    local border=$(printf '#%.0s' $(seq 1 $((min_width))))

    echo
    echo "$border"
    printf "#%*s#\n" $((min_width - 2)) ""
    printf "#%*s%s%*s#\n" $((border_width)) "" "$header" $((border_width + (min_width - header_length) % 2))
    printf "#%*s#\n" $((min_width - 2)) ""
    echo "$border"
    echo

    if [ "$hostname" = "proxmoxis" ]; then
        apt update && apt upgrade && apt full-upgrade && apt clean && apt autoclean && apt autoremove && pveam update && updatedb && sync
        echo
        echo "Ausfuehrung fuer Host $hostname erledigt! "
        echo
    elif [ "$hostname" = "raspifix" ]; then
        apt update && apt upgrade && apt full-upgrade && apt clean && apt autoclean && apt autoremove && pihole -up && pihole-updatelists && sync
        echo
        echo "Ausfuehrung fuer Host $hostname erledigt! "
        echo
    else
        apt update && apt upgrade && apt full-upgrade && apt clean && apt autoclean && apt autoremove && sync
        echo
        echo "Ausfuehrung fuer Host $hostname erledigt! "
        echo
    fi
}
