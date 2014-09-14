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
Usage: prefs.py <command> [options] [<args>...]

Options:
    -h, --help          show this help message and exit.
    --backup            backup user settings to repository.
    --restore           restore user settings from repository.

Commands:
    sublime             Sublime Text preferences actions.

See 'prefs <command> --help' for further information on a specific command.
"""
from __future__ import absolute_import

import re
import os.path
import shlex
import subprocess

from docopt import docopt
from subprocess import call


root = os.path.abspath(os.path.dirname(__file__))


class Preference(object):

    userdir = os.path.expanduser('~')

    def log(self, message):
        print message

    def execute(self, cmd, cwd=root, **options):
        process = subprocess.Popen(shlex.split(cmd), cwd=cwd, **options)
        stdout, stderr = process.communicate()
        return stdout, stderr


    def backup(self):
        raise NotImplementedError


    def restore(self):
        raise NotImplementedError



class Manager(object):

    basedir = os.path.abspath(os.path.dirname(__file__))

    def __init__(self, docstring=__doc__, options_first=True, **kwargs):
        self.args = docopt(docstring, options_first=options_first, **kwargs)
        self.cmd  = self.args['<command>']


    @property
    def argv(self):
        argv = [self.args['<command>']]
        if self.args.has_key('<args>'):
            argv += self.args['<args>']
        return argv


    @classmethod
    def get_commands(cls):
        """Find all available management commands.

        Returns: list of commands under `tornext.commands`.
        """
        pattern = re.compile(r'^([a-zA-Z]+)(\w?)(\.py)')
        return [py[:-3] for py in os.listdir(cls.basedir) \
                if pattern.match(py) and not py.startswith('prefs')]


    def dispatch(self):
        """Dynamically dispatch the given command to concrete python script.
        """
        if self.cmd in self.commands:
            py = os.path.join(self.basedir, '%s.py' % self.cmd)
            exit(call(['python', py] + self.argv))

if __name__ == '__main__':
    Manager().dispatch()
