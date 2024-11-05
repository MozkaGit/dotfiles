#+TITLE: dotfiles

This repo contains my dotfile configuration, allowing for a consistent computing experience across multiple machines.
These days I primarily use GNU/Linux via the [[https://fedoraproject.org/][Fedora Linux distribution]].

I manage the various configuration files in this repo using [[https://www.gnu.org/software/stow/][GNU Stow]].  This allows me to set up symlinks for all of my dotfiles using a single command:

#+begin_src sh
stow .
#+end_src

