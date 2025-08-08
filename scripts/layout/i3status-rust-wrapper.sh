#!/bin/bash
#cat /home/dromi/.cache/tmp/layout_nicknames | awk -v line=$(( $(cat /home/dromi/.cache/tmp/layout_index) +1 )) 'NR == line { print }'
cat /home/dromi/.cache/tmp/layout_nicknames | awk -v line=$(( $(cat /home/dromi/.cache/tmp/layout_index) +1 )) '{print $line}'
