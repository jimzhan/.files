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

Commands:
    backup              backup user settings to repository.
    restore             restore user settings from repository.

See 'prefs <command> --help' for further information on a specific command.
"""
import os.path

from prefs import Preference


class Sublime(Preference):

    base = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'Sublime')

    def backup(self):
        self.log('Start backing up Sublime Text...')
        src = os.path.join(self.userdir, 'Library/Application\ Support/Sublime\ Text\ 3')

        Packages = 'Packages'
        InstalledPackages = 'Installed\ Packages'

        # initialize first backup
        if not (os.path.islink(os.path.join(src, Packages)) \
                and os.path.islink(os.path.join(src, InstalledPackages))):
            self.log('Adding initial backup for Sublime Text...')
            self.execute('mv %s %s %s' % (os.path.join(src, InstalledPackages), os.path.join(src, Packages), self.base))
            self.execute('git add ./*')
            self.execute('git commit -a -m "Sublime settings backup"')
            self.execute('git push')
            self.execute('ln -s %s %s' % (os.path.join(self.base, Packages), os.path.join(src, Packages)))
            self.execute('ln -s %s %s' % (os.path.join(self.base, InstalledPackages), os.path.join(src, InstalledPackages)))
        else:
            self.log('Commiting changes for Sublime Text...')
            self.execute('git add %s' % self.dst)
            self.execute('git commit -a -m "Sublime settings updates"')
            self.execute('git push')

