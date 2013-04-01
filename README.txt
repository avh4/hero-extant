Java version:

To build the Java version with maven,

First you will need to build the map-toolkit SNAPSHOT jar:

    git clone https://github.com/avh4/map-toolkit.git
    cd map-toolkit
    mvn clean install
    cd ..

Then build and run hero-extant:

    git clone https://github.com/avh4/hero-extant
    cd hero-extant
    mvn package
    mvn exec:java

The output files are rendered.png and rendered.tmx


Hero Extant
Copyright (C) Ben Golightly & contributors
See License.txt

Version: 20100711

Version Maintainer:
Ben Golightly, golightly.ben@googlemail.com

Updates:
http://www.tophatstuff.co.uk/?p=92


-------------------------------------------------------------------------------
Contents:
-------------------------------------------------------------------------------

Contents:

  [1]: System Requirements
  [2]: Introduction
  [3]: How to Play
  [4]: Options
  [5]: Additional Information


-------------------------------------------------------------------------------
[1]: System Requirements
-------------------------------------------------------------------------------

OS: Microsoft Windows XP SP3, Vista, Windows 7, or Linux with wine.
Minimum screen resolution is 1024x768.
The faster the CPU the better. World generation is very CPU intensive!
Recommend you have at least 256mb of usable free RAM, ideally more.
Most graphics cards should work. Make sure you update your drivers.
Mouse and keyboard required.
Speakers optional.

As a rough guideline:
For maps of size 512x512,   the program will use ~120mb of RAM
For maps of size 1024x1024, the program will use ~160mb of RAM
For maps of size 2048x2048, the program will use ~330mb of RAM
For maps of size 3072x3072, the program will use ~600mb of RAM
For maps of size 4096x4096, the program will use ~1000mb of RAM


-------------------------------------------------------------------------------
[2]: Introduction
-------------------------------------------------------------------------------

Hero Extant is an open-source role-playing game that uses simple 2D graphics to
display a very detailed world. It is currently in the early stages of
development.

This program has a random world generator that exports easy to read data. You
may like to use it to generate maps for your own projects. Worlds are saved as
binary and also rendered as PNG images. You can find saved worlds in the
"local" folder and information on how to read the data in the "docs" folder.

If you use the world generator, you are kindly requested (but not required) to
tell people how the worlds you use were generated, e.g. "This map was generated
with the 'Hero Extant World Generator'". Thank you!


-------------------------------------------------------------------------------
[3]: How to Play
-------------------------------------------------------------------------------

Currently only the world generator is implemented. To use it, launch "hex.exe",
select "Generate New World", choose your parameters, and click "Generate". You
will be given the option to accept or reject your map at certain points in the
generation process.

You can view saved worlds with the "viewer.exe" program.


-------------------------------------------------------------------------------
[4]: Options
-------------------------------------------------------------------------------

Open "cfg.ini" in a text editor, and edit the following sections:

        "graphics":
        
                Set "width" and "height" to any resolution that your monitor
                supports. These values are measured in pixels. Set these values
                to zero to automatically use your current screen resolution.
                  
                Set "depth" to 0, 24, or 32. When set to 0, the program will
                pick a depth automatically.
                  
                Set "fullscreen" to 1 for fullscreen, or 0 for windowed.
                
                The "flags" option determines what window decorations are
                available in windowed mode. 0 is no window decoration, and
                13 will show the Application Bar and the Close and Minimise
                buttons.
                
                Set "vsync" to 1 to force the graphics to match your monitor
                refresh rate. Doing so may reduce your frame rate. Set to 0 to
                disable. Disabling vsync may cause a "tearing" visual effect on
                your display.
        
        "music":
        
                Set "enabled" to 1 to enable music, or 0 to disable.
                
                Set "volume" to a number between 0.0 (quietest) and 1.0
                (loudest) to adjust the music volume.
        
        "settings":
        
                Adjusting "palette" will make the program use a different color
                scheme when drawing the world. Currently only "default.ini" is
                valid.
                
                Adjusting "tileset" will make the program use a different set
                of graphics when drawing the world. Currently only
                "default.ini" is valid.
        
        
        "compression":
        
                Saved data (such as exported worlds) is compressed to save
                space. If you want to use exported maps in your own projects,
                you may want to disable compression to make the data easier
                to read. To enable, set "enabled" to 1, otherwise set it to 0
                to disable.
        


-------------------------------------------------------------------------------
[5]: Additional Information
-------------------------------------------------------------------------------

For more information on how to use this program, for example information on
modding, reading output worlds, etc. please refer to the documents in the
"docs" folder.














