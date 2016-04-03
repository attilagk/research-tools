#!/bin/sh

# CONFIGURATION SCRIPT FOR BUILDING VIM FROM SOURCE.
#
# Use the following command to get the freshest version from the repository
# (mercurial):
#hg clone https://vim.googlecode.com/hg/ vim
#
# MORE INFO:
# http://kowalcj0.wordpress.com/2013/11/19/how-to-compile-and-install-latest-version-of-vim-with-support-for-x11-clipboard-ruby-python-2-3/
# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
#
# A NOTE ON PYTHON/PYTHON3:
# Either the python2 or the python3 interpreter should be enabled.
# The Automatic LaTeX Plugin (ATP) v12.5 failed with the python3.4 but works with
# the python2.7 interpreter.  For this reason vim74 was compiled with
# python2.7.
#
# A NOTE ON THE 'CLIENTSERVER' VIM FEATURE
# The ubuntu/debian vim74 binary lacks the 'clientserver' feature.
# This feature is required by ATP, and this motivated me to build vim74 from
# source.  The present configure options imply the 'clientserver' feature, so
# no explicit option is necessary to specify this feature.

# Configuring
# (the script needs to be called from within the vim directory)

./configure \
--with-features=huge \
--enable-cscope \
--enable-perlinterp \
--enable-pythoninterp \
#--enable-python3interp \
--enable-rubyinterp \
--enable-gui=auto \
--enable-gtk2-check \
--enable-gnome-check \
--enable-multibyte \
--with-x \
--with-compiledby="attila.gulyas.kovacs@gmail.com" \
--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu
#--with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu


# Compiling and installing

#make   #build
#sudo make install  #install; default directory is /usr/local/bin
#which vim
#sudo update-alternatives --install "/usr/bin/vim" "vim" "/usr/local/bin/vim" 1
#sudo update-alternatives --install "/usr/bin/vi" "vi" "/usr/local/bin/vim" 1
#sudo update-alternatives --config vim
#sudo update-alternatives --config vi
#ll /usr/bin/vim
#ll /usr/bin/vi
