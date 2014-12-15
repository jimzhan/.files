#! /bin/sh
# ----------------------------------------------------------------------
# (C) Copyright 2014 Jim Zhan <jim.zhan@me.com>.
# ----------------------------------------------------------------------
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------

offline=`dig 114.114.114.114 +time=1 +short 189.cn A | grep -c "no servers could be reached"`
if [[ "$offline" == "0" ]]; then
  if [ ! -f $HOME/.online ]; then
    touch $HOME/.online
  fi
else
  if [ -f $HOME/.online ]; then
    rm $HOME/.online
  fi
fi
