
function path_remove() {
    PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

function path_append() {
    path_remove "$1"
    PATH="${PATH:+"$PATH:"}$1"
}

function path_prepend() {
    path_remove "$1"
    PATH="$1${PATH:+":$PATH"}"
}
