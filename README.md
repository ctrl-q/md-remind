# md-remind

CLI tool to create Markdown todo tasks with due dates, time limits, and priorities.

Appends a task to a Markdown file (default: `$NOTES_DIR/TODO.md`) or, when title or due date are missing, opens Obsidian to create the task interactively.

## Usage

```sh
md-remind --title "Buy groceries" --due-date "tomorrow" --priority high
md-remind --title "Write report" -d "2024-12-31" -t "2h" -p medium
```

## Options

| Flag | Description |
|------|-------------|
| `--title` | Task title |
| `--due-date`, `-d` | Due date (parsed by `date`) |
| `--time-limit`, `-t` | Time estimate |
| `--priority-text`, `-p` | Priority: `highest`, `high`, `medium`, `low`, `lowest` |

## Dependencies

`bash`, `jq`, `libnotify`; optionally `obsidian`, `xdg-utils`
