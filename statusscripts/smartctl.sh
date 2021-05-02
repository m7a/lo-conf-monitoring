#!/bin/sh -eu
# Ma_Sys.ma Script to Check SMART data with Monit 1.0.0,
# Copyright (c) 2021 Ma_Sys.ma.
# For further info send an e-mail to Ma_Sys.ma@web.de.

smartoutput="$(LANG=en_US.UTF-8 smartctl -H -A "$@")"
printf '%s\n' "$smartoutput"
printf '%s\n' "$smartoutput" | grep -qF ": PASSED"
