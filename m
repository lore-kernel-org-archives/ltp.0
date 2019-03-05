From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Mar 2019 15:49:40 +0100
Subject: [LTP] [PATCH] contributing cpuplugd and mon_fsstatd tests
In-Reply-To: <20190305141225.4422-1-elas@linux.vnet.ibm.com>
References: <20190305141225.4422-1-elas@linux.vnet.ibm.com>
Message-ID: <20190305144940.GE13703@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  runtest/s390x_tests                           |   3 +
>  testcases/commands/cpuplugd/README.md         |  35 ++
>  testcases/commands/cpuplugd/cmm.conf          |  10 +
>  testcases/commands/cpuplugd/cpu.conf          |   8 +
>  testcases/commands/cpuplugd/cpuplugd.conf     |  15 +
>  testcases/commands/cpuplugd/cpuplugd.sh       | 477 ++++++++++++++++++
>  testcases/commands/cpuplugd/cpuplugdcmm.conf  |  10 +
>  testcases/commands/cpuplugd/cpuplugdtemp.conf |  15 +
>  testcases/commands/cpuplugd/mon_fsstatd.sh    | 164 ++++++

The *.conf files should be put into data directory and treated as
data files.

See:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#212-datafiles

Or check the testcases/commands/file/ test for a reference usage.

>  9 files changed, 737 insertions(+)
>  create mode 100644 runtest/s390x_tests
>  create mode 100644 testcases/commands/cpuplugd/README.md
>  create mode 100644 testcases/commands/cpuplugd/cmm.conf
>  create mode 100644 testcases/commands/cpuplugd/cpu.conf
>  create mode 100644 testcases/commands/cpuplugd/cpuplugd.conf
>  create mode 100644 testcases/commands/cpuplugd/cpuplugd.sh
>  create mode 100644 testcases/commands/cpuplugd/cpuplugdcmm.conf
>  create mode 100644 testcases/commands/cpuplugd/cpuplugdtemp.conf
>  create mode 100644 testcases/commands/cpuplugd/mon_fsstatd.sh
> 
> diff --git a/runtest/s390x_tests b/runtest/s390x_tests
> new file mode 100644
> index 000000000..b05b2f58b
> --- /dev/null
> +++ b/runtest/s390x_tests
> @@ -0,0 +1,3 @@
> +# Those tests are designed to be executed in s390x environment (zVM or LPAR)
> +cpuplugd cpuplugd.sh
> +mon_fsstatd mon_fsstatd.sh
> diff --git a/testcases/commands/cpuplugd/README.md b/testcases/commands/cpuplugd/README.md
> new file mode 100644
> index 000000000..6cf33f212
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/README.md
> @@ -0,0 +1,35 @@
> +# cpuplugd mon_fsstatd tools test
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
> +
> +## Prerequisites
> +
> +z/VM guest or LPAR must be prepared to be populated with guest OS
> +
> +## Installation
> +
> +Scripts are to be copied into the target test system
> +
> +## Running the tests
> +
> +runtest/s390x_tests contains all the necessary commands to be executed:
> +`./cpuplugd.sh`
> +`./mon_fsstatd.sh`
> +
> +## License
> +
> +The files in this directory are licensed under the GPL v2+ license.
> diff --git a/testcases/commands/cpuplugd/cmm.conf b/testcases/commands/cpuplugd/cmm.conf
> new file mode 100644
> index 000000000..59e71f726

As pointed out previously, we do not fancy separate README files. Test
descriptions should be put into top level comment in the test source
code.

> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cmm.conf
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
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
> index 000000000..6a84d8177
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpu.conf
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +CPU_MIN="1"
> +CPU_MAX="3"
> +UPDATE="1"
> +
> +HOTPLUG="(loadavg > onumcpus + 0.75) & (idle < 10.0)"
> +HOTUNPLUG="(loadavg < onumcpus - 0.25) | (idle > 50)"
> diff --git a/testcases/commands/cpuplugd/cpuplugd.conf b/testcases/commands/cpuplugd/cpuplugd.conf
> new file mode 100644
> index 000000000..09d76b993
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpuplugd.conf
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
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
> index 000000000..2a3b2964f
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpuplugd.sh
> @@ -0,0 +1,477 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#!/bin/sh
> +
> +TST_CNT=11
> +TST_TESTFUNC=cpuplugd_test
> +. tst_test.sh
> +
> +number_of_cpus=$(grep -c ^processor /proc/cpuinfo)

The number of (online) processors should be retrieved with:

$(tst_getconf _NPROCESSORS_ONLN)

> +SLEEP_X=$((number_of_cpus*2))
> +CMM_MOD="$(grep "CONFIG_CMM=" /boot/config-$(uname -r) | cut -d= -f2 | tr '[:upper:]' '[:lower:]')"

There is no guarantee that there si /boot/config-$(uname -r) file
present on the system.

We do have library function for kernel config parsing but it's available
for C code only. I can create a patch that would add a shell helper
binary though and send it to the mailing list so that you can rebase
your work on the top of that.

> +load_vmcp(){
> + local GUESTNAME=""
> +
> + if [ ! -e /proc/sysinfo ] ; then
> +  echo "Cannot access /proc/sysinfo" >&1
> +  exit 1
> + fi
> +
> + GUESTNAME="$(cat /proc/sysinfo | grep -i VM00.Name | sed 's/^.*:[[:space:]]*//g;s/[[:space:]]//g' | tr '[a-z]' '[A-Z]')"
> +
> + if [ -n "$GUESTNAME" ];then
> +      `vmcp q cpus > /dev/null 2>&1`
> +      if [ $? -ne 0 ];then
> +       modprobe vmcp >/dev/null 2>&1
> +       echo "Module vmcp loaded"
> +      fi
> +      return 0
> + fi
> + return 1
> +}
> +
> +isVM(){
> +   local GUESTNAME=""
> +   local GUESTNO=""
> +
> +   if [ ! -e /proc/sysinfo ] ; then
> +    echo "Cannot access /proc/sysinfo" >&1
> +    exit 1
> +   fi
> +
> +   GUESTNAME="$(cat /proc/sysinfo | grep -i VM00.Name | sed 's/^.*:[[:space:]]*//g;s/[[:space:]]//g' | tr '[a-z]' '[A-Z]')"
> +
> +   if [ -z "$GUESTNAME" ];then
> +    return 1
> +   fi
> +   if [ -n "$GUESTNAME" ];then
> +      load_vmcp
> +      return 0
> +   fi
> +   return 1
> +}

This code is copy&pasted between the two tests, is should be put into a
library instead.

> +assert_cpuplugd_running() {
> +    local NOT_RUNNING="$1"
> +    local WARN="$2"
> +
> +    if [ "$NOT_RUNNING" -eq "0" ]; then
> +        MESSAGE="cpuplugd is running"
> +    elif [ "$NOT_RUNNING" -eq "1" ]; then
> +        MESSAGE="cpuplugd is not running"
> +    fi
> +
> +    ps -e | grep -q cpuplugd
> +    local RC=$?
> +
> +    if [ "$WARN" -eq "1" ]; then
> +            if [ "$RC" -eq "$NOT_RUNNING" ]; then
> +                    tst_res TPASS "$MESSAGE"
> +            else
> +                    tst_res TFAIL "$MESSAGE"
> +            fi
> +    fi
> +
> +    return $RC
> +}
> +
> +stop_cpuplugd() {
> +    echo "stop cpuplugd"
> +
> +    if [ -e /run/cpuplugd.pid ]; then
> +       kill $(cat /run/cpuplugd.pid)
> +    elif [ -e /var/run/cpuplugd.pid ]; then
> +       kill $(cat /var/run/cpuplugd.pid)
> +    else
> +       kill $(ps -e | grep -i cpuplugd | awk '{print $1}')
> +    fi
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
> +
> +#Function to remove the given entry ($1) from test configuration file
> +prepare_incomplete_cpu_test_config() {
> +    rm -rf cpuplugdtest.conf
> +    cp cpuplugd.conf cpuplugdtest.conf
> +    sed -e 's/'$1'/#'$1'/' -i cpuplugdtest.conf
> +}

The test is creating files in $PWD which means that it has to set the
TST_NEEDS_TMPDIR flag as creating files outside of the test temporary
directory is forbidden.

> +prepare_incomplete_cmm_test_config() {
> +    rm -rf cpuplugdtest.conf
> +    cp cpuplugdcmm.conf cpuplugdtest.conf
> +    sed -e 's/'$1'/#'$1'/' -i cpuplugdtest.conf
> +}
> +
> +#run cpuplgd with cpuplugdtest.conf and verify change in number of cpus before/during/after running the daemon
> +cpu_test_with_error_in_cpuplgdtest_conf() {
> +    local NOT_RUNNING="$1"
> +    local WARN="$2"
> +
> +    # cmm must not be loaded so that cpuplugd will only consider the cpu configuration
> +    if [ "$CMM_MOD" = "m" ]; then
> +        rmmod cmm
> +    fi
> +
> +    assert_cpuplugd_running 1 0
> +    local RC=$?
> +
> +    if [ "$RC" -eq "0" ]; then
> +        stop_cpuplugd
> +    fi
> +
> +    cpusbefore=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +    echo "start cpuplugd -V -c cpuplugdtest.conf -f"
> +    cpuplugd -V -c cpuplugdtest.conf -f >> cpuf &
> +    sleep 2
> +
> +    if [ "$CMM_MOD" = "m" ]; then
> +        assert_cpuplugd_running $NOT_RUNNING $WARN
> +    else
> +        assert_cpuplugd_running $NOT_RUNNING $WARN
> +    fi
> +
> +    local RC=$?
> +
> +    # Wait a little to allow for (undesired) cpu configuration change
> +    sleep $SLEEP_X
> +    cpusrunning=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +
> +    if [ "$RC" -eq "0" ]; then
> +        stop_cpuplugd
> +    fi
> +
> +    local cpusafter=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +    local i=0
> +
> +    if (( "$cpusbefore" == "$cpusrunning" )) && (( "$cpusrunning" == "$cpusafter" )); then
> +        i=1
> +    fi
> +
> +    echo  "Verify that CPU configuration does not change: cpusbefore=$cpusbefore, cpusduring=$cpusrunning, cpusafterter=$cpusafter"
> +    if [ $i -eq 1 ]; then
> +            tst_res TPASS "Test passed"
> +    else
> +            tst_res TFAIL "Test failed"
> +    fi
> +}
> +
> +#run cpuplgd with cpuplugdtest.conf and verify change in number of cmm pagess before/during/after running the daemon
> +cmm_test_with_error_in_cpuplgdtest_conf() {
> +    local NOT_RUNNING="$1"
> +    local WARN="$2"
> +
> +    assert_cpuplugd_running 1 0
> +    local RC=$?
> +
> +    if [ "$RC" -eq "0" ]; then
> +        stop_cpuplugd
> +    fi
> +
> +    if [ "$CMM_MOD" = "m" ]; then
> +        modprobe cmm
> +    fi
> +
> +    echo 1000 > /proc/sys/vm/cmm_pages
> +    sleep 2
> +
> +    cmm_pages_before=$(cat /proc/sys/vm/cmm_pages)
> +
> +    echo "start cpuplugd -V -c cpuplugdtest.conf -f"
> +    cpuplugd -V -c cpuplugdtest.conf -f >> cmm &
> +    sleep 2
> +
> +    assert_cpuplugd_running $NOT_RUNNING $WARN
> +    local RC=$?
> +
> +    # Wait a little to allow for (undesired) cpu configuration change
> +    sleep $SLEEP_X
> +    local cmm_pages_running=$(cat /proc/sys/vm/cmm_pages)
> +
> +    if [ "$RC" -eq "0" ]; then
> +        stop_cpuplugd
> +    fi
> +
> +    local cmm_pages_after=$(cat /proc/sys/vm/cmm_pages)
> +    i=0
> +
> +    if (( "$cmm_pages_before" == "$cmm_pages_running" )) && (( "$cmm_pages_running" == "$cmm_pages_after" )); then
> +        i=1
> +    fi
> +
> +    echo "Verify that the number of available CMM pages does not change: cmm_pages_before=$cmm_pages_before, cmm_pages_running=$cmm_pages_running, cmm_pages_after=$cmm_pages_after"
> +    if [ "${i}" -eq "1" ]; then
> +            tst_res TPASS "Test passed"
> +    else
> +            tst_res TFAIL "Test failed"
> +    fi
> +
> +    if [ "$CMM_MOD" = "m" ]; then
> +        rmmod cmm
> +    fi
> +}
> +
> +exec_cpu_test_with_error_in_cpuplugd_conf()
> +{
> +    local notrun=1
> +    isVM && [ "$CMM_MOD" = "y" ] && notrun=0
> +    cpu_test_with_error_in_cpuplgdtest_conf $notrun 1
> +}
> +
> +cpuplugd_run()
> +{
> +
> +        $1
> +        if [ "$?" -eq "$2" ]; then
> +                tst_res TPASS "'$1' returned '$2'"
> +        else
> +                tst_res TFAIL "'$1' did not return '$2'"
> +        fi
> +}
> +
> +cpuplugd_test1()
> +{
> +    tst_res TINFO "Cpuplugd version"
> +    local cpuplugd=$(cpuplugd -v | head -n 1 | cut -d":" -f2 | cut -d" " -f10)
> +    cpuplugd_run "cpuplugd -v" 0
> +    echo "Cpuplugd version $cpuplugd"
> +}
> +cpuplugd_test2()
> +{
> +    tst_res TINFO "Cpuplugd Help information checking"
> +    echo "Checking for Help information with -h option"
> +    cpuplugd_run "cpuplugd -h" 0
> +    echo "Checking for Help information with --help option"
> +    cpuplugd_run "cpuplugd --help" 0
> +}
> +
> +# Run several tests with incomplete/broken configuration.
> +# Correct behavior for the daemon is not to start.
> +cpuplugd_test3()
> +{
> +    tst_res TINFO "Invalid options checking"
> +    echo "Checking for Invalid option -H"
> +    cpuplugd_run "cpuplugd -H" 1
> +    echo "Checking for Invalid option -1234"
> +    cpuplugd_run "cpuplugd -1234" 1
> +}
> +
> +cpuplugd_test4()
> +{
> +    tst_res TINFO "Run daemon without UPDATE entry in config"
> +    prepare_incomplete_cpu_test_config UPDATE
> +    cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +}
> +
> +cpuplugd_test5()
> +{
> +    tst_res TINFO "Run Daemon without CPU_MIN entry"
> +    prepare_incomplete_cpu_test_config CPU_MIN
> +    exec_cpu_test_with_error_in_cpuplugd_conf
> +}
> +
> +cpuplugd_test6()
> +{
> +    tst_res TINFO "Run Daemon without CPU_MAX entry"
> +    prepare_incomplete_cpu_test_config CPU_MAX
> +    cpu_test_with_error_in_cpuplgdtest_conf 1 1
> +}
> +
> +cpuplugd_test7()
> +{
> +    tst_res TINFO "Run Daemon without HOTPLUG entry"
> +    prepare_incomplete_cpu_test_config HOTPLUG
> +    exec_cpu_test_with_error_in_cpuplugd_conf
> +}
> +
> +cpuplugd_test8()
> +{
> +    tst_res TINFO "Run Daemon without HOTUNPLUG entry"
> +    prepare_incomplete_cpu_test_config HOTUNPLUG
> +    exec_cpu_test_with_error_in_cpuplugd_conf
> +}
> +
> +# Good path test for CPU plugging.
> +# Run daemon with only cpu configuration in configuration file
> +# CPU Hotplug with 3 Active cpus and CPU_MIN=1 and CPU_MAX=3
> +# Verify that number of CPUs is reduced after daemon is started
> +# and restored after daemon is stopped.
> +cpuplugd_test9()
> +{
> +        tst_res TINFO  "Run Daemon with only cpu configuration"
> +
> +        assert_cpuplugd_running 1 1
> +
> +        local cpusbefore=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +        echo "running daemon with only cpu config" > cpuf
> +        echo "start cpuplugd -V -c cpu.conf -f "
> +        cpuplugd  -V -c cpu.conf -f >> cpuf &
> +        sleep 2
> +
> +        assert_cpuplugd_running 0 1
> +        local RC=$?
> +        echo "Let Daemon run for few seconds, so that it does the hotplugging"
> +        sleep $SLEEP_X
> +
> +        local cpusrunning=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +
> +        if [ "$RC" -eq "0" ]; then
> +            stop_cpuplugd
> +        fi
> +
> +        sleep 2
> +        local cpusafter=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +        i=0
> +
> +        if [ "$cpusbefore" != "$cpusrunning" ] && [ "$cpusbefore" == "$cpusafter" ]; then
> +            tst_res TPASS "Verify that number of CPUs before, while and after the daemon runs changes: cpusbefore=$cpusbefore, cpusduring=$cpusrunning, cpusafterter=$cpusafter"
> +        else
> +            tst_res TFAIL "Verify that number of CPUs before, while and after the daemon runs changes: cpusbefore=$cpusbefore, cpusduring=$cpusrunning, cpusafterter=$cpusafter"
> +        fi
> +}
> +
> +cpuplugd_test10()
> +{
> +   tst_res TINFO "Memory Hotplug tests (z/VM only)"
> +
> +   if ! isVM; then
> +        # if it is LPAR, Memory Hotplug cannot be done
> +        tst_res TINFO "This must be an LPAR. Skip CMM Tests"
> +	return;
> +   fi
> +
> +   # Run several tests with incomplete/broken configuration.
> +   # Correct behavior for the daemon is not to start.
> +
> +   tst_res TINFO "Run Daemon without loading CMM module"
> +       if [ "$CMM_MOD" != "m" ]; then
> +           tst_res TINFO "This test is not possible to be performed since CMM was builtin within the kernel and cannot be unloaded."
> +       else
> +           assert_cpuplugd_running 1 0
> +           local RC=$?
> +
> +           if [ "$RC" -eq "0" ]; then
> +              stop_cpuplugd
> +           fi
> +
> +           rmmod cmm
> +           lsmod | grep -q cmm
> +
> +           if [ "$?" -eq "1" ]; then
> +               tst_res TPASS "Verify that CMM module is not loaded"
> +           else
> +               tst_res TFAIL "Verify that CMM module is not loaded"
> +           fi
> +
> +           cpuplugd -V -c cmm.conf -f >> cmm.log &
> +           echo "Daemon should fail to run as CMM module is not loaded"
> +           sleep 2
> +
> +           assert_cpuplugd_running 1 1
> +           local RC=$?
> +
> +           rm -rf cmm.log
> +
> +           if [ "$RC" -eq "0" ]; then
> +               stop_cpuplugd
> +           fi
> +       fi
> +
> +
> +   tst_res TINFO "Run Daemon without CMM_MIN entry"
> +       prepare_incomplete_cmm_test_config CMM_MIN
> +       cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +
> +
> +   tst_res TINFO "Run Daemon without CMM_MAX entry"
> +       prepare_incomplete_cmm_test_config CMM_MAX
> +       cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +
> +
> +   tst_res TINFO "Run Daemon without CMM_INC entry"
> +       prepare_incomplete_cmm_test_config CMM_INC
> +       cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +
> +
> +   tst_res TINFO "Run Daemon without MEMPLUG entry"
> +       prepare_incomplete_cmm_test_config MEMPLUG
> +       cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +
> +
> +   tst_res TINFO "Run Daemon without MEMUNPLUG entry"
> +       prepare_incomplete_cmm_test_config MEMUNPLUG
> +       cmm_test_with_error_in_cpuplgdtest_conf 1 1
> +
> +
> +   # Good path test for CMM plugging
> +
> +   tst_res TINFO "Run Daemon with only CMM configuration"
> +       if [ "$CMM_MOD" = "m" ]; then
> +           modprobe cmm
> +       fi
> +
> +       echo 1000 > /proc/sys/vm/cmm_pages
> +       sleep 1
> +
> +       local cmm_pages_before=$(cat /proc/sys/vm/cmm_pages)
> +       local cpusbefore=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +       cpuplugd -V -c cmm.conf -f  >> cmm.log &
> +       sleep 2
> +
> +       assert_cpuplugd_running 0 1
> +       local RC=$?
> +       sleep 4
> +
> +       local cmm_pages_running=$(cat /proc/sys/vm/cmm_pages)
> +       local cpusrunning=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +
> +       if [ "$RC" -eq "0" ]; then
> +           stop_cpuplugd
> +       fi
> +
> +       sleep 2
> +
> +       local cmm_pages_after=$(cat /proc/sys/vm/cmm_pages)
> +       local cpusafter=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
> +       local i=0
> +
> +       if [ "$cmm_pages_before" != "$cmm_pages_running" ] && [ "$cmm_pages_before" == "$cmm_pages_after" ]; then
> +           if [ "$cpusbefore" == "$cpusrunning" ] && [ "$cpusbefore" == "$cpusafter" ]; then
> +               i=1
> +           fi
> +       fi
> +
> +       if [ "$i" -eq "1" ];then
> +           tst_res TPASS "Verify that the number of cmm_pages before, while and after the daemon runs changes:                 cmm_pages_before=$cmm_pages_before, cmm_pages_running=$cmm_pages_running, cmm_pages_after=$cmm_pages_after. CPU hotplugging should not happen and cpu configuration should remain constant: cpus_before=$cpusbefore, cpus_during=$cpusrunning, cpus_after=$cpusafter"
> +       else
> +           tst_res TFAIL "Verify that the number of cmm_pages before, while and after the daemon runs changes:                 cmm_pages_before=$cmm_pages_before, cmm_pages_running=$cmm_pages_running, cmm_pages_after=$cmm_pages_after. CPU hotplugging should not happen and cpu configuration should remain constant: cpus_before=$cpusbefore, cpus_during=$cpusrunning, cpus_after=$cpusafter"
> +       fi
> +
> +}
> +
> +cpuplugd_test11()
> +{
> +    tst_res TINFO "Doing the cleanup tasks ..."
> +    cpuplugd_run "service cpuplugd stop" 0
> +
> +    if [ "$CMM_MOD" = "m" ]; then
> +        cpuplugd_run "rmmod cmm" 0
> +    fi
> +
> +    cpuplugd_run "rm -rf cpuf cmm log cmm.log cpuplugdtest.conf te.tes out.txt.tmp" 0
> +
> +}
> +
> +tst_run
> diff --git a/testcases/commands/cpuplugd/cpuplugdcmm.conf b/testcases/commands/cpuplugd/cpuplugdcmm.conf
> new file mode 100644
> index 000000000..ca393249e
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpuplugdcmm.conf
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +UPDATE="1"
> +
> +CMM_MIN="0"
> +CMM_INC="10"
> +CMM_MAX="10"
> +
> +MEMPLUG="swaprate < 200"
> +MEMUNPLUG="swaprate > 5000"
> diff --git a/testcases/commands/cpuplugd/cpuplugdtemp.conf b/testcases/commands/cpuplugd/cpuplugdtemp.conf
> new file mode 100644
> index 000000000..157422780
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/cpuplugdtemp.conf
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +CPU_MIN="1"
> +CPU_MAX="3"
> +UPDATE="1"
> +
> +HOTPLUG="(loadavg > onumcpus + 0.75) & (idle < 10.0)"
> +HOTUNPLUG="(loadavg < onumcpus - 0.25) | (idle > 50)"
> +
> +#CMM_MIN="0"
> +CMM_INC="10"
> +CMM_MAX="10"
> +
> +MEMPLUG="swaprate < 200"
> +MEMUNPLUG="swaprate > 5000"
> diff --git a/testcases/commands/cpuplugd/mon_fsstatd.sh b/testcases/commands/cpuplugd/mon_fsstatd.sh
> new file mode 100644
> index 000000000..fdbd3ee3d
> --- /dev/null
> +++ b/testcases/commands/cpuplugd/mon_fsstatd.sh
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#!/bin/sh
> +
> +sed -i 's/FSSTAT="no"/FSSTAT="yes"/' /etc/sysconfig/mon_statd
> +sed -i 's/PROC="no"/PROC="yes"/' /etc/sysconfig/mon_statd
> +
> +TST_CNT=1
> +TST_TESTFUNC=mon_fsstatd_test
> +. tst_test.sh
> +
> +load_vmcp(){
> + local GUESTNAME=""
> +
> + if [ ! -e /proc/sysinfo ] ; then
> +  echo "Cannot access /proc/sysinfo" >&1
> +  exit 1

No echo and exit in tests, you should use tst_res and tst_brk instead.

General information should be printed with

tst_res TINFO "information message"

If something unexpected happened test should be terminated with tst_brk
instead of exit.

> + fi
> +
> + GUESTNAME="$(cat /proc/sysinfo | grep -i VM00.Name | sed 's/^.*:[[:space:]]*//g;s/[[:space:]]//g' | tr '[a-z]' '[A-Z]')"
> +
> + if [ -n "$GUESTNAME" ];then
> +      `vmcp q cpus > /dev/null 2>&1`
> +      if [ $? -ne 0 ];then
> +       modprobe vmcp >/dev/null 2>&1
> +       echo "Module vmcp loaded"

Here as well.


Also the test is doing priviledged operations (modprobe at least) which
means that it has to set the TST_NEEDS_ROOT flag so that it's clear that
it cannot be executed as regular user.

See:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#232-library-variables

> +      fi
> +      return 0
> + fi
> + return 1
> +}
> +
> +s390_config_check(){
> +        local config="$1"
> +        local config_line=$(env | grep "$config=")
> +
> +        if [ $? -ne 0 ]; then
> +                tst_res TFAIL "Config option $config not defined"
> +                exit 1

Here as well.

> +        else
> +                local value=$(echo $config_line | awk -F = '{print $2}')
> +                echo "USING CONFIG: $config=$value"

Here as well.

> +        fi
> +}
> +
> +isVM(){
> +   local GUESTNAME=""
> +   local GUESTNO=""
> +
> +   if [ ! -e /proc/sysinfo ] ; then
> +    echo "Cannot access /proc/sysinfo" >&1
> +    exit 1
> +   fi
> +
> +   GUESTNAME="$(cat /proc/sysinfo | grep -i VM00.Name | sed 's/^.*:[[:space:]]*//g;s/[[:space:]]//g' | tr '[a-z]' '[A-Z]')"
> +
> +   if [ -z "$GUESTNAME" ];then
> +    return 1
> +   fi
> +   if [ -n "$GUESTNAME" ];then
> +      load_vmcp
> +      return 0
> +   fi
> +   return 1
> +}
> +
> +s390_config_check S390_mon_statd
> +
> +
> +mon_fsstatd_run()
> +{
> +        $2
> +        if [ "$?" -eq "$1" ]; then
> +                tst_res TPASS "'$2' returned '$1'"
> +        else
> +                tst_res TFAIL "'$2' did not return '$1'"
> +        fi
> +}
> +
> +mon_fsstatd_test1()
> +{
> +    if ! isVM; then
> +        tst_res TINFO "This must be an LPAR. Not applicable in LPAR"
> +        return;
> +    fi
> +
> +    tst_res TINFO "Basic User option Verification"
> +    mon_fsstatd_run 0 "modprobe monwriter max_bufs=8192"
> +
> +    sleep 2

Doing sleep in tests is generally wrong thing to do. We do have 3000+
tests in LTP and if each of them would call sleep 2 as much as this does
the whole testsuite would run for more than 40 hours instead of 40
minutes.

Generally if there is some asynchronous initialization you have to wait
for you should check if it was done about ten times per second and break
the loop once the service is ready.

> +    service mon_statd status
> +    [ $? -eq 3 ] && tst_res TINFO "mon_statd is not started yet"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "service mon_statd stop"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "service mon_statd start"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "pidof mon_fsstatd"
> +    mon_fsstatd_run 0 "pidof mon_procd"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "service mon_statd restart"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_fsstatd -h"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_fsstatd --help"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_fsstatd -v"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_fsstatd --version"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_fsstatd -i 30"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_procd -h"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_procd --help"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_procd -v"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_procd --version"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_procd -i 30"
> +
> +    sleep 2
> +    mon_procd -a &
> +    if [ "$?" -eq "0" ]; then
> +            tst_res TPASS "'mon_procd -a' returned 0"
> +    else
> +            tst_res TFAIL "'mon_procd -a' did not return 0"
> +    fi
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "killall mon_procd"
> +
> +    sleep 2
> +    mon_fsstatd -a &
> +    if [ "$?" -eq "0" ]; then
> +            tst_res TPASS "'mon_fsstatd -a' returned 0"
> +    else
> +            tst_res TFAIL "'mon_fsstatd -a' did not return 0"
> +    fi
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "killall mon_fsstatd"
> +
> +    sleep 2
> +    mon_fsstatd_run 0 "mon_procd -v"
> +}
> +
> +tst_run

-- 
Cyril Hrubis
chrubis@suse.cz
