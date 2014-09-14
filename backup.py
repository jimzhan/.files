#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright © 2014 Jim Zhan <jim.zhan@me.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""
Usage: backup.py <command> [options] [<args>...]

Options:
    -h, --help          show this help message and exit.

Commands:
    sublime         backup & commit Sublime settings to the repository.

See 'backup <command> --help' for further information on a specific command.
"""
from __future__ import absolute_import

import re
import os.path
import shlex
import subprocess

from docopt import docopt
from subprocess import call


root = os.path.abspath(os.path.dirname(__file__))
user = os.path.expanduser('~')


backups = {
    'Sublime': [
        'cp -rp $HOME/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages $HOME/.dotfiles/Sublime/',
        'cp -rp $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages $HOME/.dotfiles/Sublime/',
        'cd $HOME/.dotfiles && git commit -a -m "Sublime settings backup" && git push'
    ]
}

restores = {
    'Sublime': [
    ]
}


def execute(cmd, cwd=root, **options):
    process = subprocess.Popen(shlex.split(cmd), cwd=cwd, **options)
    stdout, stderr = process.communicate()
    return stdout, stderr

def backup_sublime():
    log('Start backing up Sublime Text...')
    dst = os.path.join(root, 'Sublime/')
    src = os.path.join(user, 'Library/Application\ Support/Sublime\ Text\ 3')

    Packages = 'Packages'
    InstalledPackages = 'Installed\ Packages'

    # initialize first backup
    if not (os.path.islink(os.path.join(src, Packages)) \
            and os.path.islink(os.path.join(src, InstalledPackages))):
        execute('mv %s %s %s' % (os.path.join(src, InstalledPackages), os.path.join(src, Packages), dst))
        execute('git add ./*')
        execute('git commit -a -m "Sublime settings backup"')
        execute('git push')
        execute('ln -s %s %s' % (os.path.join(dst, Packages), os.path.join(src, Packages)))
        execute('ln -s %s %s' % (os.path.join(dst, InstalledPackages), os.path.join(src, InstalledPackages)))
    else:
        execute('git commit -a -m "Sublime settings updates"')
        execute('git push')



def log(message):
    print(message)


def backup():
    log('Start backing up Sublime Text...')
    src = '$HOME/Library/Application\ Support/Sublime\ Text\ 3'



def restore():
    pass


class Manager(object):

    basedir = os.path.dirname(__file__)

    def __init__(self, docstring=__doc__, options_first=True, **kwargs):
        self.args = docopt(docstring, options_first=options_first, **kwargs)
        self.cmd  = self.args['<command>']


    @property
    def argv(self):
        argv = [self.args['<command>']]
        if self.args.has_key('<args>'):
            argv += self.args['<args>']
        return argv


    @property
    def commands(self):
        """Find all available management commands.

        Returns: list of commands under `tornext.commands`.
        """
        pattern = re.compile(r'^([a-zA-Z]+)(\w?)(\.py)')
        return [py[:-3] for py in os.listdir(self.basedir) if pattern.match(py)]


    def dispatch(self):
        """Dynamically dispatch the given command to concrete python script.
        """
        if self.cmd in self.commands:
            py = os.path.join(self.basedir, '%s.py' % self.cmd)
            exit(call(['python', py] + self.argv))

if __name__ == '__main__':
    backup_sublime()
