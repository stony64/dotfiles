# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Wenn nicht interaktiv, nichts tun
[[ $- != *i* ]] && return

####################################################
###
### Configuration
###
####################################################

# Keine doppelten Zeilen in der History, loescht Duplikate oder Zeilen, die mit Leerzeichen beginnen.
HISTCONTROL=ignoreboth:erasedupes

# Ignoriert bestimmte Befehle in der History
HISTIGNORE="${HISTIGNORE:+$HISTIGNORE:}'la:ll:lah:lat:;a:-:fg:bg:j:git +(s|si)*( ):rma:fol:.+(.):ps:ps -A:[bf]g:exit:mc:au:cd *'"

# Historie an die Datei anhaengen, nicht ueberschreiben
shopt -s histappend

# Nach jedem Befehl die Historie anhaengen und neu laden
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Historienlaenge festlegen (siehe HISTSIZE und HISTFILESIZE in bash(1))
HISTSIZE=8192
HISTFILESIZE=16384

# Fenstergroesse nach jedem Befehl pruefen und ggf. LINES und COLUMNS aktualisieren
shopt -s checkwinsize

# Das Muster "**" in einem Pfaderweiterungskontext wird alle Dateien und null oder mehr Verzeichnisse und Unterverzeichnisse matchen
shopt -s globstar

# `less` freundlicher fuer Nicht-Textdateien machen, siehe lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# Variable setzen, die den chroot identifiziert (wird im Prompt unten verwendet)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

####################################################
###
### Terminal Colors
###
####################################################

# Konfiguriert die Shell-Prompts mit oder ohne Farben, je nach Terminalkapazitaet und Benutzerpraeferenzen.

# Fancy Prompt setzen (ohne Farben, es sei denn, Farben werden gewuenscht)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Fuer einen farbigen Prompt, wenn das Terminal dies unterstuetzt; standardmaessig deaktiviert
force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
    if command -v tput &>/dev/null && tput setaf 1 &>/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [[ "$color_prompt" == yes ]]; then
    if [[ $(id -u) -eq 0 ]]; then
        # Root-Prompt (rot)
        PS1="\[\e[38;5;196m\]\u\[\e[38;5;81m\]@\[\e[38;5;77m\]\h \[\e[38;5;226m\]\w \[\033[0m\]$ "
    else
        # Benutzer-Prompt (blau)
        PS1="\[\e[38;5;39m\]\u\[\e[38;5;81m\]@\[\e[38;5;77m\]\h \[\e[38;5;226m\]\w \[\033[0m\]$ "
    fi
else
    # Standard-Prompt ohne Farben
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Wenn dies ein xterm ist, den Titel auf user@host:dir setzen
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

####################################################
###
### Aliases and Functions
###
####################################################

# Laedt zusuetzliche Aliase und Funktionen aus separaten Dateien (~/.bash_aliases und ~/.bash_functions), falls vorhanden.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Aktiviert programmierbare Vervollstaendigung, falls verfuegbar und POSIX-Modus nicht aktiv ist.

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi



