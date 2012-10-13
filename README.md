# Goto Documentation with Sdoc

A Sublime Text 2 plugin that provides a command to jump to documentation for the current word,
extended to support sdoc generated on your local machine.

Includes a script to generate sdoc for all your projects, a scheduled task to keep documentation up-to-date,
and a sinatra server to serve the documentation.

For an even better experience, install my custom sdoc

## Supports

 * PHP
 * JS / CoffeeScript
 * Python
 * Clojure
 * Go
 * Smarty
 * Ruby on Rails

Submit a patch adding more and I'll include it.

## Using

Open the command palette (cmd-shift-p) and choose "Goto Documentation" while your cursor is on a word.

Make a keybind by adding the following to your `User/Default (OSX).sublime-keymap`:

	{ "keys": ["super+shift+h"], "command": "goto_documentation" }

(I don't like plugins automatically adding keybinds, okay.)

## Installing

First, you need to have `git` installed and in your `$PATH`. Afterwards you may need to restart Sublime Text 2 before the plugin will work.

### OSX

    $ cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/
    $ git clone git://github.com/kemayo/sublime-text-2-goto-documentation.git GotoDocumentation

### Linux (Ubuntu like distros)

    $ cd ~/.config/sublime-text-2/Packages/
    $ git clone git://github.com/kemayo/sublime-text-2-goto-documentation.git GotoDocumentation

### Windows 7 / XP:

    Not supported, sorry.
