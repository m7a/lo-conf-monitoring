#!/bin/sh -eu
# Ma_Sys.ma Script to Check SMART data with Monit 1.0.0,
# Copyright (c) 2021 Ma_Sys.ma.
# For further info send an e-mail to Ma_Sys.ma@web.de.

# SNYOPSIS USAGE $0 [--advanced statefile] DEVICE

adv_output_file=
if [ "$1" = "--advanced" ]; then
	adv_output_file="$2"
	shift 2
fi

smartoutput="$(LANG=en_US.UTF-8 smartctl -H -A "$@")"
printf '%s\n' "$smartoutput"
[ -z "$adv_output_file" ] || printf '%s\n' "$smartoutput" > "$adv_output_file"
printf '%s\n' "$smartoutput" | grep -qF ": PASSED"
