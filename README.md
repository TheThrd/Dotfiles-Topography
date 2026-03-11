# Dotfiles-Topography
A set of dotfiles made for cachyos hyprland based off a topography map image I generated using python.

This is not guaranteed to work on all machines, and will require a little bit of self setup during the install process (because I'm not that good of a programmer).
Please understand this before trying to install, but questions are welcome and I'll try answer what I can.

# Installing
These instructions are just what I **think** you need, if there's an issue with the install process please contact me so I can make corrections.

## Getting started
Ensure you have hyprland installed, this won't be here because I'm lazy but it's not too difficult.
First you need to download a few dependencies for the installation. These are only the specific ones needed, not the hyprland required ones, install any alongside if they are not replaced by the ones that are required.

(In your terminal)
``` bash
sudo pacman -S git rofi dunst waybar hyprpaper
```

## Installing and moving files
Now you need to clone the actual repository:
```bash
git clone https://github.com/TheThrd/Dotfiles-Topography.git
```
Using this we can move each file to its respective location
### Main config
```bash
mv ~/Dotfiles-Topography/hypr ~/.config/hypr
```
### Dunst (notifications)
```bash
mv ~/Dotfiles-Topography/dunst ~/.config/dunst
```
### Rofi (open apps easily - currently largely unconfigured)
```bash
mv ~/Dotfiles-Topography/rofi ~/.config/rofi
```
### Waybar (status bar)
```bash
mv ~/Dotfiles-Topography/waybar ~/.config/waybar
```
### Extra scripts
This is required for laptop multimedia keys
```bash
mv ~/Dotfile-Topography/scripts ~/.scripts
```

## Extra - background
This is for if you want to generate your own background similar to mine, the script works for any colours, you just have to modify it yourself.

This takes a bit of setup to do, but it should be okay.

### Ensure Python/pip is installed
```bash
sudo pacman -S python python-pip
```

### Using the script
First we create an environment for some pip packages that the script uses
```bash
python -m venv .venv
```
Then enter the venv
```bash
source .venv/bin/activate.fish
```
Install the needed packages for the program
```bash
pip install numpy perlin-noise pillow
```
Now run the python script
```bash
python ~/Dotfiles-Topography/background.py
```
It will prompt you for some configurations, these are the ones I use for my main monitor:
width: 1920
height: 1200
scale: 150
steps: 24

Width and height should be your monitor resolution, but I recommend using smaller values at first since the script is very slow. (eg, I used 1920x100 to test values).
Scale determines how 'zoomed in' the topography is, the larger your dpi is the higher I recommend this.
Steps determines how many different colour bands there are.

After the script runs, a preview should popup with the result, you can either save it there or type 'y' into the terminal and provide a file name (just the name, the file extension will automatically be .png and may not work if a different one is placed).
If you do not want the background, just type 'n' or exit the terminal.

After that, the file should be saved in ~/Dotfiles-Topography by default (I haven't tested but I assume so since it uses the cwd)

## Configuring
I recommend going into all the main configs (especially hyprpaper) to set your own wallpapers, keybinds, etc
Rofi may be configured in the future depending on how much I can be bothered.

For my cursor setup, use [hypr-dynamic-cursors](https://github.com/VirtCode/hypr-dynamic-cursors)
Note that this is not maintained or created by me, so all instructions should be followed from there.

## One last thing
My sddm theme is currently not available as it is extremely janky (I just ripped apart one of the default themes and added my own style to it), I would say use cosmic greeter or some other sddm theme (or even customise your own) for a nicer look.
I might? make a more permanent replacement, which I will add here maybe

## Thank you for using my dotfiles!
The install process might have been difficult and bug-riden, but I will refine based on feedback given.
