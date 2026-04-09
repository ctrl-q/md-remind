#!/bin/bash
set -e
set -o pipefail
set -o nounset

urlencode(){
	jq -Rr '@uri' <<< "${1}"
}
# Default values
_title="${1:-}"
_due_date="${2:-}"
_time_limit="${3:-}"
_priority_text="${4:-}"

# Parse named arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --title)
            _title="$2"; shift 2;;
        --due-date|-d)
            _due_date="$2"; shift 2;;
        --time-limit|-t)
            _time_limit="$2"; shift 2;;
        --priority-text|-p)
            _priority_text="$2"; shift 2;;
        --)
            shift; break;;
        *)
            shift;;
    esac
done

readonly title="${_title}"
readonly due_date="${_due_date}"
readonly time_limit="${_time_limit}"
readonly priority_text="${_priority_text}"

notify(){
	notify-send --app-name=md-remind 'Error' "$@"
}

trap notify ERR

if [ -n "${title}" ] && [ -n "${due_date}" ]; then
	task="- [ ] ${title}"

 	if [ -n "${time_limit}" ]; then
		task+=" [time-limit::${time_limit}]"
	fi

	task+=" ⏳ $(date '+%F' --date "${due_date}")"

	case "${priority_text,,}" in
		highest) task+=" 🔺";;
		high) task+=" ⏫";;
		medium) task+=" 🔼";;
		low) task+=" 🔽";;
		lowest) task+=" ⏬";;
		*) ;;
	esac
	echo "Appending \"${task}\" to ${NOTES_DIR:-${HOME}/Documents/notes}/${f:-TODO.md}"
	echo "${task}" >> "${NOTES_DIR:-${HOME}/Documents/notes}/${f:-TODO.md}"
	notify-send --app-name=md-remind Success "Appended \"${task}\" to ${NOTES_DIR:-${HOME}/Documents/notes}/${f:-TODO.md}"

else
	xdg-open "obsidian://create-task?task-description=$(urlencode ${title})&due-date=$(urlencode ${due_date})"
	notify-send --app-name=md-remind Success "Opened Obsidian to create task"
fi
