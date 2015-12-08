#!/usr/bin/python3

import os
import sys

IGNORED_FILES = (".git", "install.py")

# Obtain ID of the station
ID_FILE = os.path.expanduser("~/.id")
station_id = None
if os.path.exists(ID_FILE):
    with open(ID_FILE) as fd:
        try:
            station_id = eval(fd.read())
        except:
           print("> ERROR reading ~/.id file")
else:
    print("> Missing .id file in HOME. Unknown station")

if station_id:
    print("> Station location: {location}, pc {pc}, label {label}".
          format(**station_id))


homedir = os.path.expanduser("~")
print("> Home folder is: ", homedir)
progname = sys.argv[0]
print("> Install script invoked as: ", progname)
dotfiles_dir = os.path.abspath(os.path.dirname(progname))
backup_dir = dotfiles_dir + "_old"
print("> Assuming dotfile folder is: ", dotfiles_dir)
print("> Backup folder is: ", backup_dir)

# Create the backup folder if not there yet
if not os.path.exists(backup_dir):
    os.mkdir(backup_dir)

# Get all dotfiles
dotfiles = os.listdir(dotfiles_dir)

# Filter ignored files
for dotf in dotfiles:
    if dotf in IGNORED_FILES:
        dotfiles.remove(dotf)

# Find matching files in HOME that are not already symlinks to
# the files in dotfiles_dir.
# Backup different files
for dotf in dotfiles:
    dotfile_fullp = os.path.join(homedir, dotfiles_dir, dotf)
    matching_file = os.path.join(homedir, "."+dotf)
    if os.path.exists(matching_file):
        print("Found a matching file in HOME: ", matching_file)
        if os.path.islink(matching_file):
            if os.path.realpath(matching_file) == os.path.realpath(dotfile_fullp):
                print("{} is already a symlink to a file in dotfiles_dir. Skipping.".format(dotf))
                #dotfiles.remove(dotf)
                continue
        if os.system("diff -q {} {} > /dev/null".format(dotfile_fullp, matching_file)):
            print("Files differ - will backup to " + backup_dir)
            bkp_dest = os.path.join(backup_dir, os.path.basename(matching_file))
            ver = 0
            bkp_base = bkp_dest
            while os.path.exists(bkp_dest):
                ver += 1
                bkp_dest = "{};{}".format(bkp_base, ver)
            os.rename(matching_file, bkp_dest)
            os.symlink(dotfile_fullp, matching_file)
        else:
            print("Files are the same. Will delete the one in HOME and will link it to the one in dotfiles_dir")
            os.remove(matching_file)
            os.symlink(dotfile_fullp, matching_file)
    else:
	# Detect a broken symlink
        if os.path.islink(matching_file):
            print("Detected a broken symlink: " + matching_file)
            os.remove(matching_file) 
        print("Will install a new file in HOME: ", dotf)
        os.symlink(dotfile_fullp, matching_file)

