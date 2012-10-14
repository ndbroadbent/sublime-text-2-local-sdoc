# Complete Project Documentation with Sdoc

This project contains a Sublime Text 2 plugin, sdoc generation script to be run via cron, and a Sinatra server to both serve documentation and open files in your text editor.

From Sublime Text 2, you will be able to place your cursor on a keyword, and jump to the project's sdoc documentation in your browser. While viewing the documentation in your browser, you can click 'open in Sublime Text 2' to view the source of a method.

The SDoc generation script generates complete documentation for your project. This includes your project code, it's Ruby version (either from `.rvmrc` or default ruby), and all of your project's gem dependencies. It also uses my custom fork of sdoc called `sdoc_local_editor`, which will be automatically installed. This adds links to the source sections to 'Open in <editor>'. Clicking this link sends a `POST` request to the Sinatra server, which will open the relevant file/line in Sublime Text 2.


# Requirements

* Ubuntu Linux (for now)
* RVM
* Sublime Text 2
* [SCM Breeze](https://github.com/ndbroadbent/scm_breeze) with `git_index` configured
* Google Chrome

Please send a pull request if you can help expand this list (i.e. OS X, rbenv, other editors.)

# Installation

### Checkout the repo

```bash
git clone https://github.com/ndbroadbent/sublime-text-2-local-sdoc.git ~/.sublime_text_2_local_sdoc
```

### Symlink Sublime Text 2 Plugin

```bash
ln -fs ~/.sublime_text_2_local_sdoc ~/.config/sublime-text-2/Packages/GotoDocumentationWithSdoc
```

### Set up Nginx with Passenger to run Sinatra Server

Symlink sinatra server into somewhere like `/opt/sinatra`:

```
sudo mkdir -p /opt/sinatra
sudo ln -fs ~/.sublime_text_2_local_sdoc/sinatra_server /opt/sinatra/local_sdoc
# Also add log directory
mkdir -p ~/.sublime_text_2_local_sdoc/sinatra_server/log
```

Install passenger and nginx module:

```bash
gem install passenger
passenger-install-nginx-module
# Follow the prompts...
```

Follow this article to add an init.d script so that it boots on startup: http://techoctave.com/c7/posts/16-how-to-host-a-rails-app-with-phusion-passenger-for-nginx

Add the following to the `http {}` section in `/opt/nginx/conf/nginx.conf`:

```
server {
  listen 80;
  server_name sdoc.local;

  access_log /opt/sinatra/local_sdoc/log/access.log;
  error_log /opt/sinatra/local_sdoc/log/error.log;

  root /opt/sinatra/local_sdoc/public;

  # Enforce a trailing slash for urls with no format extension
  rewrite ^([^.]*[^/])$ $1/ permanent;

  passenger_enabled on;
}
```

Edit `/etc/hosts`, and add the following line:

```
127.0.0.1 sdoc.local
```

(Restart networking for change to take effect: `sudo /etc/init.d/networking restart`)

Now you should be able to access `http://sdoc.local` in your browser.


### Install cron task

```bash
cd ~/.sublime_text_2_local_sdoc
bundle install
whenever -f schedule.rb -i
```

### Generate docs

If you want, you can run the sdoc generator manually for the first time, using the following command:

```bash
mkdir -p $HOME/.sdoc && ! [ -e $HOME/.sdoc/GENERATING ] && touch $HOME/.sdoc/GENERATING && git_index --batch-cmd ~/.sublime_text_2_local_sdoc/bin/generate_sdoc; rm -f $HOME/.sdoc/GENERATING
```


### All done!

This is one of those projects

<hr/>

# Original Documentation from Goto Documentation Plugin:

<hr/>

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
