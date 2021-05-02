#!/bin/sh -eu
# Ma_Sys.ma ZFS Status Script for Monit 1.0.0, Copyright (c) 2021 Ma_Sys.ma.
# For further info send an e-mail to Ma_Sys.ma@web.de.

zpoolstatus="$(LANG=en_US.UTF-8 zpool status)"
printf '%s\n' "$zpoolstatus"
printf '%s\n' "$zpoolstatus" | ! grep -qE "(DEGRADED|UNAVAIL)"
