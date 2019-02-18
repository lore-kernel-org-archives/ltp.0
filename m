From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Feb 2019 22:55:27 +0100
Subject: [LTP] [PATCH] add cpuplugd
In-Reply-To: <20190214131545.5517-1-elas@linux.vnet.ibm.com>
References: <20190214131545.5517-1-elas@linux.vnet.ibm.com>
Message-ID: <20190218215527.GA6149@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> ---
>  testcases/commands/cpuplugd/README.md         |  39 +++
>  testcases/commands/cpuplugd/cmm.conf          |  16 +
>  testcases/commands/cpuplugd/cpu.conf          |  14 +
>  testcases/commands/cpuplugd/cpuplugd.conf     |  21 ++
>  testcases/commands/cpuplugd/cpuplugd.sh       | 311 ++++++++++++++++++
>  testcases/commands/cpuplugd/cpuplugd_1.sh     | 197 +++++++++++
>  testcases/commands/cpuplugd/cpuplugdcmm.conf  |  16 +
>  testcases/commands/cpuplugd/cpuplugdtemp.conf |  21 ++
>  8 files changed, 635 insertions(+)
>  create mode 100644 testcases/commands/cpuplugd/README.md
>  create mode 100644 testcases/commands/cpuplugd/cmm.conf
>  create mode 100644 testcases/commands/cpuplugd/cpu.conf
>  create mode 100644 testcases/commands/cpuplugd/cpuplugd.conf
>  create mode 100644 testcases/commands/cpuplugd/cpuplugd.sh
>  create mode 100644 testcases/commands/cpuplugd/cpuplugd_1.sh
>  create mode 100644 testcases/commands/cpuplugd/cpuplugdcmm.conf
>  create mode 100644 testcases/commands/cpuplugd/cpuplugdtemp.conf

> diff --git a/testcases/commands/cpuplugd/README.md b/testcases/commands/cpuplugd/README.md
> new file mode 100644
> index 000000000..e72162dfd
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/README.md
> @@ -0,0 +1,39 @@
> +# TOOL_s390_kernel_1
A bit strange title :).

> +
> +cpuplugd: Daemon that manages CPU and memory resources based on a set of rules.  
> +Depending on the workload CPUs can be enabled or disabled.  
> +The amount of memory can be increased or decreased exploiting the Cooperative Memory Management (CMM1) feature.
> +
> +## Getting started
> +
> +The test case contains the following scripts:
> +
> +- **cmm.conf** _configuration file_
> +- **cpu.conf** _configuration file_
> +- **cpuplugd.conf** _configuration file_
> +- **cpuplugd.sh** _verification of cpuplugd tool_
> +- **cpuplugdcmm.conf** _configuration file_
> +- **cpuplugdtemp.conf** _configuration file_
> +- **mon_fsstatd.sh** _mon tool tests_
You haven't included mon_fsstatd.sh.
> +
> +## Prerequisites
> +
> +z/VM guest must be prepared to be populated with SLES guest OS, all scripts must be available on some local server via http to be fetched from zVM guest when ready.
SLES is not the only s390x distro. Can you please remove SLES and openQA
specific comments?
> +
> +## Installation
> +
> +OpenQA deploys SLE onto a z/VM guest automatically.
> +
> +## Running the tests
> +
> +Transfer test case to the target system and run locally:  
> +`./cpuplugd.sh`  
Trailing whitespace (will be deleted by git, but better to avoid it).
> +`./mon_fsstatd.sh`

Instead of these instructions please provide command definition in some runtest
file.
> +
> +## Versioning
> +
> +Tested already on SLES12.3.
> +
> +## License
> +
> +The files in this directory are licensed under the "FSF All Permissive License" except if indicated otherwise in the file.
Well, LTP uses GPL v2+, can you respect it?

> diff --git a/testcases/commands/cpuplugd/cmm.conf b/testcases/commands/cpuplugd/cmm.conf
> new file mode 100644
> index 000000000..d94a0700d
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cmm.conf
> @@ -0,0 +1,16 @@
> +# Copyright (C) 2018 IBM Corp.
> +# 
> +# Copying and distribution of this file, with or without modification,
> +# are permitted in any medium without royalty provided the copyright
> +# notice and this notice are preserved.  This file is offered as-is,
> +# without any warranty.
Can you please use GPL v2+ defined via SPDX-License-Identifier?
# SPDX-License-Identifier: GPL-2.0-or-later
Than this disclaimer is not needed.

> +
> +
> +UPDATE="1"
> +
> +CMM_MIN="5000"
> +CMM_INC="100"
> +CMM_MAX="20000"
> +
> +MEMPLUG="swaprate < 200"
> +MEMUNPLUG="swaprate > 5000"
> diff --git a/testcases/commands/cpuplugd/cpu.conf b/testcases/commands/cpuplugd/cpu.conf
> new file mode 100644
> index 000000000..167ad6001
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpu.conf
> @@ -0,0 +1,14 @@
> +# Copyright (C) 2018 IBM Corp.
> +# 
> +# Copying and distribution of this file, with or without modification,
> +# are permitted in any medium without royalty provided the copyright
> +# notice and this notice are preserved.  This file is offered as-is,
> +# without any warranty.
> +
> +
> +CPU_MIN="1"
> +CPU_MAX="3"
> +UPDATE="1"
> +
> +HOTPLUG="(loadavg > onumcpus + 0.75) & (idle < 10.0)"
> +HOTUNPLUG="(loadavg < onumcpus - 0.25) | (idle > 50)"
> diff --git a/testcases/commands/cpuplugd/cpuplugd.conf b/testcases/commands/cpuplugd/cpuplugd.conf
> new file mode 100644
> index 000000000..dd3190b7d
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpuplugd.conf
> @@ -0,0 +1,21 @@
> +# Copyright (C) 2018 IBM Corp.
> +# 
> +# Copying and distribution of this file, with or without modification,
> +# are permitted in any medium without royalty provided the copyright
> +# notice and this notice are preserved.  This file is offered as-is,
> +# without any warranty.
> +
> +
> +CPU_MIN="1"
> +CPU_MAX="3"
> +UPDATE="1"
> +
> +HOTPLUG="(loadavg > onumcpus + 0.75) & (idle < 10.0)"
> +HOTUNPLUG="(loadavg < onumcpus - 0.25) | (idle > 50)"
> +
> +CMM_MIN="0"
> +CMM_INC="10"
> +CMM_MAX="10"
> +
> +MEMPLUG="swaprate < 200"
> +MEMUNPLUG="swaprate > 5000"
> diff --git a/testcases/commands/cpuplugd/cpuplugd.sh b/testcases/commands/cpuplugd/cpuplugd.sh
> new file mode 100644
> index 000000000..2089431f2
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpuplugd.sh
> @@ -0,0 +1,311 @@
> +# Copyright (C) 2018 IBM Corp.
> +# 
> +# Copying and distribution of this file, with or without modification,
> +# are permitted in any medium without royalty provided the copyright
> +# notice and this notice are preserved.  This file is offered as-is,
> +# without any warranty.
> +
> +
> +#!/usr/bin/env bash
Please don't use env. In fact #!/bin/bash shebang isn't good enough, LTP expects #!/bin/sh
shebang and POSIX compliant shell scripts (you expect /bin/sh being symlink to
bash, but some distros use dash as default shell).

See some info about bashisms:
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style
http://mywiki.wooledge.org/Bashism
+ use checkbashisms.pl to identify them
https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl

You also mix tab and space indent. Can you convert few tabs to spaces?

> +###############################################################################
> +# The following changes were made in order to fix the cpuplugd daemon status
> +# verification and also to perform it before trying to stop the daemon:
> +#
> +# - serviceruns and assert_cpuplugd_not_running functions eliminated;
> +# - stop_cpuplugd function rebuilt;
> +# - assert_cpuplugd_running, assert_cpuplugd_not_running and serviceruns
> +# functions merged into new rebuilt assert_cpuplugd_running function;
> +# - changed all assert_cpuplugd_running function calls to use 2 arguments;
> +# - inserted assert_cpuplugd_running function calls before trying to stop
> +# cpuplugd daemon.
> +#
> +# Changes
> +# -------
> +# 07.03.2018  Corrections for SLES15 (no PID file when
> +#                     running in interactive mode)
> +#
> +###############################################################################
Why this changelog? We use git.

> +TST_CNT=11
> +TST_TESTFUNC=cpuplugd_test
> +. tst_test.sh
> +
> +number_of_cpus=$(lscpu | grep -wF "CPU(s):" | awk 'FNR == 1 {print $2}')
lscpu is unnecessary dependency (if used it'd be good to have it in
TST_NEEDS_CMDS variable). How about using /proc/cpuinfo?
number_of_cpus=$(grep -c ^processor /proc/cpuinfo)

> +(( SLEEP_X = number_of_cpus * 2 ))
Bashism, use:
SLEEP_X=$((number_of_cpus * 2))
> +
> +# inherit all variables to subprocesses
> +set -a
This is ugly, why do you need it?

> +
> +readonly CMM_MOD="$(grep "CONFIG_CMM=" /boot/config-$(uname -r) | cut -d= -f2 | tr '[:upper:]' '[:lower:]')"
Why readonly? You set CMM_MOD only once

> +
> +for f in lib/*.sh; do source $f; done
> +source ./cpuplugd_1.sh || exit 1
This is most likely wrong. Which libraries are you trying to load?
Instead of exit 1 there should be tst_brk TBROK or tst_brk TCONF in some setup
function.
> +
> +init_tests
This function is not defined. I guess you haven't added some files.
> +
> +cpuplugd_run()
> +{
> +
> +        $1
> +        if [ $? -eq $2 ]; then
> +                tst_res TPASS "'$1' returned '$2'. Test passed"
Test passed is redundant.

> +        else
> +                tst_res TFAIL "'$1' did not return '$2'. Test failed"
> +        fi
> +}
> +
> +cpuplugd_test1()
> +{
> +    echo "Cpuplugd version"
Please use tst_res TINFO "Cpuplugd version"

> +    cpuplugd=$(cpuplugd -v | head -n 1 | cut -d":" -f2 | cut -d" " -f10)
Functions should use local keyword for all used variables

Apply for most of the code.

> +    cpuplugd_run "cpuplugd -v" 0 
> +    echo "Cpuplugd version $cpuplugd"
> +}

...

> +cpuplugd_test5()
> +{
> +    echo "Run Daemon without CPU_MIN entry"
> +    prepare_incomplete_cpu_test_config CPU_MIN
> +    if isVM; then
Where is isVM defined?

> +        if [[ "${CMM_MOD}" = "m" || -z "${CMM_MOD}" ]]; then
[[ are a bashism, please use this form ([ does not allow ||, need to use -o):
        if [ "$CMM_MOD" = "m" -o -z "$CMM_MOD" ]; then

Also even ${VAR} is not wrong, it's mostly unnecessary ($VAR is enough).
Apply for most of the code.

> +            cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +        elif [[ "${CMM_MOD}" = "y" ]]; then
> +            cpu_test_with_error_in_cpuplgdtest_conf 0 1
> +        fi
> +    else
> +        cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +    fi
> +}
Also this code repeats 3 times, put it into function (it could probably go into
cpu_test_with_error_in_cpuplgdtest_conf itself):
    if isVM; then
        if [[ "${CMM_MOD}" = "m" || -z "${CMM_MOD}" ]]; then
            cpu_test_with_error_in_cpuplgdtest_conf 1 1
        elif [[ "${CMM_MOD}" = "y" ]]; then
            cpu_test_with_error_in_cpuplgdtest_conf 0 1
        fi
    else
        cpu_test_with_error_in_cpuplgdtest_conf 1 1
    fi
There could be also some simplification:
local nowarn=1
isVM && [ "$CMM_MOD" = "y" ] && nowarn=0
cpu_test_with_error_in_cpuplgdtest_conf $nowarn 1

> +
> +cpuplugd_test6()
> +{
> +    echo "Run Daemon without CPU_MAX entry"
> +    prepare_incomplete_cpu_test_config CPU_MAX
> +    cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +}
> +cpuplugd_test7()
> +{
> +    echo "Run Daemon without HOTPLUG entry"
> +    prepare_incomplete_cpu_test_config HOTPLUG
> +    if isVM; then
> +        if [[ "${CMM_MOD}" = "m" || -z "${CMM_MOD}" ]]; then
> +            cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +        elif [[ "${CMM_MOD}" = "y" ]]; then
> +            cpu_test_with_error_in_cpuplgdtest_conf 0 1
> +        fi
> +    else
> +        cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +    fi
> +}
> +cpuplugd_test8()
> +{
> +    echo "Run Daemon without HOTUNPLUG entry"
> +    prepare_incomplete_cpu_test_config HOTUNPLUG
> +    if isVM; then
> +        if [[ "${CMM_MOD}" = "m" || -z "${CMM_MOD}" ]]; then
> +            cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +        elif [[ "${CMM_MOD}" = "y" ]]; then
> +            cpu_test_with_error_in_cpuplgdtest_conf 0 1
> +        fi
> +    else
> +        cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +    fi
> +}
> +
> +#
> +# Good path test for CPU plugging
> +#
> +# Run daemon with only cpu configuration in configuration file
> +# CPU Hotplug  with  3 Active cpus and CPU_MIN=1 and CPU_MAX=3
> +# Verify that number of CPUs is reduced after daemon is started
> +# and restored after daemon is stopped.
> +#
> +
Please remove extra spaces and lines with '#' only.
> +cpuplugd_test9()
> +{
Again, echo, not using local, [[ ]], ... here.
> +	echo  "Run Daemon with only cpu configuration"
> +
> +        assert_cpuplugd_running 1 1
> +
> +        cpusbefore=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +        echo "running daemon with only cpu config" > cpuf
> +        echo "start cpuplugd -V -c cpu.conf -f "
> +        cpuplugd  -V -c cpu.conf -f >> cpuf &
> +        sleep 2
> +
> +        assert_cpuplugd_running 0 1
> +        RC=$?
> +        echo "Let Daemon run for few seconds, so that it does the hotplugging"
> +        sleep ${SLEEP_X}
> +
> +        cpusrunning=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +
> +        if [[ ${RC} -eq 0 ]]; then
> +            stop_cpuplugd
> +        fi
> +
> +        sleep 2
> +        cpusafter=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +        i=0
> +
> +        if (( "$cpusbefore" != "$cpusrunning" )) && (( "$cpusbefore" == "$cpusafter" )); then
(( )) is another bashism. Use simple [ ]
> +            i=1
> +        fi
> +
> +        assert_warn $i 1  "Verify that number of CPUs before, while and after the daemon runs changes: cpusbefore=$cpusbefore, cpusduring=$cpusrunning, cpusafterter=$cpusafter"
> +}
> +
> +cpuplugd_test10()
> +{
> +#
> +# Memory Hotplug tests (z/VM only)
> +#
> +   if isVM; then
How about put else block first and return after. Than if block could be shifted
left:

	if !isVM; then
        # if it is LPAR, Memory Hotplug cannot be done
        assert_exec 1 "modprobe vmcp"
assert_exec is not defined.

        tst_res TINFO "This is LPAR. Skip CMM Tests"
		return
	fi

	tst_res TINFO "Run Daemon without loading CMM module"
	if [ "$CMM_MOD" != "m" ]; then
		assert_warn 0 0 "This test is not possible to be performed since CMM was builtin within the kernel and cannot be unloaded."
	else
	...

> +    #
> +    # Run several tests with incomplete/broken configuration.
> +    # Correct behavior for the daemon is not to start.
> +    #
> +
> +        echo "Run Daemon without loading CMM module"
> +            if [[ "${CMM_MOD}" != "m" ]]; then
> +                assert_warn 0 0 "This test is not possible to be performed since CMM was builtin within the kernel and cannot be unloaded."
> +            else
> +                assert_cpuplugd_running 1 0
> +                RC=$?
> +
> +                if [[ ${RC} -eq 0 ]]; then
> +                   stop_cpuplugd
> +                fi
> +
> +                rmmod cmm
> +                lsmod | grep -q cmm
> +                assert_warn $? 1 "Verify that CMM module is not loaded"
> +
> +                cpuplugd -V -c cmm.conf -f >> cmm.log &
> +                echo "Daemon should fail to run as CMM module is not loaded"
> +                sleep 2
> +
> +                assert_cpuplugd_running 1 1
> +                RC=$?
> +
> +                rm -rf cmm.log
> +
> +                if [[ ${RC} -eq 0 ]]; then
> +                    stop_cpuplugd
> +                fi
> +            fi
> +        
> +
> +        echo "Run Daemon without CMM_MIN entry"
> +            prepare_incomplete_cmm_test_config CMM_MIN
> +            cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +        
> +
> +        echo "Run Daemon without CMM_MAX entry"
> +            prepare_incomplete_cmm_test_config CMM_MAX
> +            cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +        
> +
> +        echo "Run Daemon without CMM_INC entry"
> +            prepare_incomplete_cmm_test_config CMM_INC
> +            cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +        
> +
> +        echo "Run Daemon without MEMPLUG entry"
> +            prepare_incomplete_cmm_test_config MEMPLUG
> +            cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +        
> +
> +        echo "Run Daemon without MEMUNPLUG entry"
> +            prepare_incomplete_cmm_test_config MEMUNPLUG
> +            cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +        
> +
> +#
> +# Good path test for CMM plugging
> +#
> +        echo "Run Daemon with only CMM configuration"
> +            if [[ "${CMM_MOD}" = "m" ]]; then
> +                modprobe cmm
> +            fi
> +
> +            echo 1000 > /proc/sys/vm/cmm_pages
> +            sleep 1
> +
> +            cmm_pages_before=$(cat /proc/sys/vm/cmm_pages)
> +            cpusbefore=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +            cpuplugd -V -c cmm.conf -f  >> cmm.log &
> +            sleep 2
> +
> +            assert_cpuplugd_running 0 1
> +            RC=$?
> +            sleep 4
> +
> +            cmm_pages_running=$(cat /proc/sys/vm/cmm_pages)
> +            cpusrunning=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +
> +            if [[ ${RC} -eq 0 ]]; then
> +                stop_cpuplugd
> +            fi
> +
> +            sleep 2
> +
> +            cmm_pages_after=$(cat /proc/sys/vm/cmm_pages)
> +            cpusafter=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +            i=0
> +
> +            if (( "$cmm_pages_before" != "$cmm_pages_running" )) && (( "$cmm_pages_before" == "$cmm_pages_after" )); then
> +                if (( "$cpusbefore" == "$cpusrunning" )) && (( "$cpusbefore" == "$cpusafter" )); then
> +                    i=1
> +                fi
> +            fi
> +
> +            assert_warn $i 1  "Verify that the number of cmm_pages before, while and after the daemon runs changes:                 cmm_pages_before=$cmm_pages_before, cmm_pages_running=$cmm_pages_running, cmm_pages_after=$cmm_pages_after. CPU hotplugging should not happen and cpu configuration should remain constant: cpus_before=$cpusbefore, cpus_during=$cpusrunning, cpus_after=$cpusafter"
> +        
> +    else
> +        # if it is LPAR, Memory Hotplug cannot be done
> +        assert_exec 1 "modprobe vmcp"
> +        echo "This is LPAR. Skip CMM Tests"
> +    fi
> +}
> +
> +cpuplugd_test11()
> +{
> +    echo "Doing the cleanup tasks ..."
> +    cpuplugd_run "service cpuplugd stop" 0
> +    
> +    if [[ "${CMM_MOD}" = "m" ]]; then
> +        cpuplugd_run "rmmod cmm" 0
> +    fi
> +
> +    cpuplugd_run "rm -rf cpuf cmm log cmm.log cpuplugdtest.conf te.tes out.txt.tmp" 0
> +    
> +}
> +
> +tst_run
> diff --git a/testcases/commands/cpuplugd/cpuplugd_1.sh b/testcases/commands/cpuplugd/cpuplugd_1.sh
> new file mode 100644
> index 000000000..32d596377
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpuplugd_1.sh
> @@ -0,0 +1,197 @@
> +# Copyright (C) 2018 IBM Corp.
> +# 
> +# Copying and distribution of this file, with or without modification,
> +# are permitted in any medium without royalty provided the copyright
> +# notice and this notice are preserved.  This file is offered as-is,
> +# without any warranty.
> +
> +
> +#!/usr/bin/env bash
Again, wrong shebang.
> +
> +for f in lib/*.sh; do source $f; done
Again, wrong loading.
> +
> +assert_cpuplugd_running() {
> +    local NOT_RUNNING=${1}
> +    local WARN=${2}
local not_running="$1"
local warn="$2"
> +
> +    if [[ ${NOT_RUNNING} -eq 0 ]]; then
> +        MESSAGE="cpuplugd is running"
> +    elif [[ ${NOT_RUNNING} -eq 1 ]]; then
> +        MESSAGE="cpuplugd is not running"
> +    fi
> +
> +    ps -e | grep -q cpuplugd
> +    RC=$?
> +
> +    if [[ ${WARN} -eq 1 ]]; then
> +    	if [ ${RC} -eq ${NOT_RUNNING} ]; then
> +        	    tst_res TPASS "${MESSAGE}"
> +	    else
> +        	    tst_res TFAIL "${MESSAGE}"
> +	    fi
> +    fi
> +
> +    return ${RC}
> +}
> +
> +stop_cpuplugd() {
> +    echo "stop cpuplugd"
> +    # With Sles15 there is no PID file for cpuplugd
> +    # when running in the foreground
> +    # if ( isSles15 ); then
What is isSles15? Please remove any commented blocks.

> +    #     if [ -e /run/cpuplugd.pid ]; then
> +    #        kill $(cat /run/cpuplugd.pid)
> +    #     else
> +    #        kill $(ps -e | grep -i cpuplugd | awk '{print $1}')
> +    #     fi
> +    # else
> +    #     kill $(cat /var/run/cpuplugd.pid)
> +    # fi
> +    #########################################################
> +    # updated start                                   #
> +    #########################################################
> +        if [ -e /run/cpuplugd.pid ]; then
> +           kill $(cat /run/cpuplugd.pid)
> +    elif [ -e /var/run/cpuplugd.pid ]; then
> +       kill $(cat /var/run/cpuplugd.pid)
> +        else
> +	   kill $(ps -e | grep -i cpuplugd | awk '{print $1}')
> +        fi
> +    #########################################################
> +    # updated end                                     #
> +    #########################################################
> +
> +    until ! assert_cpuplugd_running 1 0; do
> +        echo "cpuplugd is still running"
> +        sleep 1
> +    done
> +
> +    echo "check cpuplugd is not running"
> +    if [ $? -eq 0 ]; then
> +            tst_res TPASS "Test passed"
> +    else
> +            tst_res TFAIL "Test failed"
> +    fi
> +
> +}
...


Kind regards,
Petr
