Simple password picker to access passwords with few keystrokes.

This is intended to be used with some key binding in your window manager or desktop.

It is password manager agnostic, so you can use your own, as long as it has a command
line tool that can list all entries in its database and for a given entry name output
its password to stdout. Simply adjust `password-picker.sh`.

### Requirements
* Zenity
* xclip
* dmenu
* Python 3

Only if you use KeePass and the included `keepass-client`:
* pykeepass (`sudo pip3 install pykeepass`)

### How To
1. Bind `<path>/password-picker.sh <path-to-keepass-db>` to the shortcut you want to use.
   I use i3 and have this in my `.i3/config`:
   ```
   bindsym $mod+z exec "<path>/password-picker.sh <path>/password-database.kdbx"
   ```
1. Hit your shortcut
1. Enter your master password
1. Select the entry in the dmenu
1. Your password is now in the clipboard
1. After 30 seconds the password is removed from the clipboard, if it is still there.

## Caveats
* **You should be aware, that this is a very simple bash script, which temporarily enjoys storing passwords in
shell variables, passing them as arguments to the commands or piping them to other processes.**
