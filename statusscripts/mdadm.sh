#!/bin/sh -eu
# Ma_Sys.ma MDADM Status Script for Monit 1.0.0, Copyright (c) 2021 Ma_Sys.ma.
# For further info send an e-mail to Ma_Sys.ma@web.de.

cat /proc/mdstat
grep -qF _ /proc/mdstat
