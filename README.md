#Installation

This script controls Dell IPMI enabled servers. Install the following packages to get started:

- `apt-get install lm-sensors`
- `apt-get install ipmitool`

Then install a cronjob that executes the `fancontrol.sh` script every minute
