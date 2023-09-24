dotfiles
===

A big script for placing dotfiles and configuration around a new Manjaro system in order to get it reasonably configured.

(I lost all of my Linux stuff years ago so I'm starting again from scratch!)

Installation
---

1. Install the sway community edition of Manjaro. Anything other than 22.1.2 may need tweaking. Manually set up partitions in calamares and pick LUKS encryption for the root partition; `greetd` will autologin so the decryption passphrase will be your login.
2. Check out this repository and edit `install.sh`. For my privacy the public version of this script creates an SSH key with my GitHub noreply address. Edit it to be my actual email address. I don't think this leaks out through git commit signatures. 
3. Run `install.sh` as rileyann.
4. Reboot.
