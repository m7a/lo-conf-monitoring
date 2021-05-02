#!/bin/sh -eu
# Ma_Sys.ma Docker Status Script for Monit 1.0.0, Copyright (c) 2021 Ma_Sys.ma.
# For further info send an e-mail to Ma_Sys.ma@web.de.

dockerinfo="$(LANG=en_US.UTF-8 docker ps)"
printf '%s\n' "$dockerinfo"
printf '%s\n' "$dockerinfo" | ! grep -qF "unhealthy"
