####################################################
###
### Aliases
###
####################################################

# IPv6-Adresse abrufen
alias ip6='curl --connect-timeout 5 ifconfig.co'

# Verzeichnisbaum anzeigen, mit Verzeichnissen zuerst
alias tree='tree -F --dirsfirst'

# Fortschritt von dd anzeigen
alias dd='dd status=progress'

# Tippfehler fuer 'exit' korrigieren
alias exi='exit'
alias exti='exit'

# rm mit Bestaetigung verwenden
alias rm='rm -i'

# Rekursives Erstellen von Verzeichnissen mit Anzeige der erstellten Verzeichnisse
alias mkdir='mkdir -pv'

# Zeigt die letzten 20 Zeilen einer Datei an
alias tail='tail -n 20'

# Zeigt die ersten 20 Zeilen einer Datei an
alias head='head -n 20'

# Alias fuer 'ps' mit Anzeige aller Prozesse in Baumstruktur hinzufuegen
alias ps='ps auxf'

# Alias fuer 'du' mit human-readable Format und sortierter Ausgabe hinzufuegen
alias du='du -h --max-depth=1 | sort -hr'

# Alias fuer 'df' mit human-readable Format und Auslassung von tmpfs und devtmpfs hinzufuegen
alias df='df -hT -x tmpfs -x devtmpfs'

# Alias fuer 'uptime' hinzufuegen
alias uptime='uptime -p'

# Alias fuer 'journalctl' mit Farbausgabe und Anzeige der letzten 20 Eintruege hinzufuegen
alias journal='journalctl --no-pager -n 20 --output=short-precise | less -R'

# Alias fuer 'nano' mit Syntaxhervorhebung und automatischem Einruecken hinzufuegen
alias nano='nano -c'

# Alias fuer 'wget' mit Fortsetzen des Downloads bei Unterbrechungen hinzufuegen
alias wget='wget -c'

# Alias fuer 'curl' mit Fortsetzen des Downloads bei Unterbrechungen hinzufuegen
alias curl='curl -C -'

# Alias fuer 'less' mit Farbausgabe und Unterstuetzung fuer Mausrad hinzufuegen
alias less='less -R'

# Alias fuer 'grep' mit Farbausgabe und Anzeige von Zeilennummern hinzufuegen
alias grep='grep --color=auto -n'

# Alias fuer 'pgrep' mit Anzeige der Prozess-IDs hinzufuegen
alias pgrep='pgrep -l'

# Kernel-Nachrichten mit Farbunterstuetzung und lesbarer Zeitstempel
alias dmesg='dmesg --color=auto -H'

# bashrc neu laden
alias reload='source ~/.bashrc'

# Farbsupport fuer ls und nuetzliche Aliase hinzufuegen
if command -v dircolors &>/dev/null; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
