From: Elif Aslan <elas@linux.vnet.ibm.com>
Date: Mon, 25 Mar 2019 10:15:35 +0100
Subject: [LTP] [PATCH 1/1] ltp: add s390 cpuplugd tests
In-Reply-To: <20190325091535.2232-1-elas@linux.vnet.ibm.com>
References: <20190325091535.2232-1-elas@linux.vnet.ibm.com>
Message-ID: <20190325091535.2232-2-elas@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Elif Aslan <elas@linux.vnet.ibm.com>
---
 runtest/s390x_tests                           |   3 +-
 testcases/commands/cpuplugd/cpuplugd.sh       | 443 ++++++++++++++++++
 .../commands/cpuplugd/datafiles/cmm.conf      |  10 +
 .../commands/cpuplugd/datafiles/cpu.conf      |   8 +
 .../commands/cpuplugd/datafiles/cpuplugd.conf |  15 +
 .../cpuplugd/datafiles/cpuplugdcmm.conf       |  10 +
 .../cpuplugd/datafiles/cpuplugdtemp.conf      |  15 +
 testcases/commands/cpuplugd/mon_fsstatd.sh    | 113 +++++
 testcases/commands/cpuplugd/s390_lib.sh       |  45 ++
 9 files changed, 661 insertions(+), 1 deletion(-)
 create mode 100644 testcases/commands/cpuplugd/cpuplugd.sh
 create mode 100644 testcases/commands/cpuplugd/datafiles/cmm.conf
 create mode 100644 testcases/commands/cpuplugd/datafiles/cpu.conf
 create mode 100644 testcases/commands/cpuplugd/datafiles/cpuplugd.conf
 create mode 100644 testcases/commands/cpuplugd/datafiles/cpuplugdcmm.conf
 create mode 100644 testcases/commands/cpuplugd/datafiles/cpuplugdtemp.conf
 create mode 100644 testcases/commands/cpuplugd/mon_fsstatd.sh
 create mode 100644 testcases/commands/cpuplugd/s390_lib.sh

diff --git a/runtest/s390x_tests b/runtest/s390x_tests
index 0c2bf05a5..b05b2f58b 100644
--- a/runtest/s390x_tests
+++ b/runtest/s390x_tests
@@ -1,2 +1,3 @@
 # Those tests are designed to be executed in s390x environment (zVM or LPAR)
-vmcp vmcp_m.sh
+cpuplugd cpuplugd.sh
+mon_fsstatd mon_fsstatd.sh
diff --git a/testcases/commands/cpuplugd/cpuplugd.sh b/testcases/commands/cpuplugd/cpuplugd.sh
new file mode 100644
index 000000000..9d3da1118
--- /dev/null
+++ b/testcases/commands/cpuplugd/cpuplugd.sh
@@ -0,0 +1,443 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# cpuplugd: Daemon that manages CPU and memory resources based on a set of rules.
+# Depending on the workload CPUs can be enabled or disabled.
+# The amount of memory can be increased or decreased exploiting the Cooperative Memory Management (CMM1) feature.
+
+#!/bin/sh
+
+TST_CNT=11
+TST_TESTFUNC=cpuplugd_test
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
+. tst_test.sh
+
+number_of_cpus=$(tst_getconf _NPROCESSORS_ONLN)
+SLEEP_X=$((number_of_cpus*2))
+CMM_MOD="$(grep "CONFIG_CMM=" /boot/config-$(uname -r) | cut -d= -f2 | tr '[:upper:]' '[:lower:]')"
+
+source s390_lib.sh
+
+
+assert_cpuplugd_running() {
+    local NOT_RUNNING="$1"
+    local WARN="$2"
+
+    if [ "$NOT_RUNNING" -eq "0" ]; then
+        MESSAGE="cpuplugd is running"
+    elif [ "$NOT_RUNNING" -eq "1" ]; then
+        MESSAGE="cpuplugd is not running"
+    fi
+
+    ps -e | grep -q cpuplugd
+    local RC=$?
+
+    if [ "$WARN" -eq "1" ]; then
+            if [ "$RC" -eq "$NOT_RUNNING" ]; then
+                    tst_res TPASS "$MESSAGE"
+            else
+                    tst_res TFAIL "$MESSAGE"
+            fi
+    fi
+
+    return $RC
+}
+
+stop_cpuplugd() {
+    tst_res TINFO "stop cpuplugd"
+
+    if [ -e /run/cpuplugd.pid ]; then
+       kill $(cat /run/cpuplugd.pid)
+    elif [ -e /var/run/cpuplugd.pid ]; then
+       kill $(cat /var/run/cpuplugd.pid)
+    else
+       kill $(ps -e | grep -i cpuplugd | awk '{print $1}')
+    fi
+
+    until ! assert_cpuplugd_running 1 0; do
+        tst_res TINFO "cpuplugd is still running"
+        sleep 0.1
+    done
+
+    tst_res TINFO "check cpuplugd is not running"
+    if [ $? -eq 0 ]; then
+            tst_res TPASS "Test passed"
+    else
+            tst_res TFAIL "Test failed"
+    fi
+
+}
+
+#Function to remove the given entry ($1) from test configuration file
+prepare_incomplete_cpu_test_config() {
+    rm -rf $TST_DATAROOT/cpuplugdtest.conf
+    cp $TST_DATAROOT/cpuplugd.conf $TST_DATAROOT/cpuplugdtest.conf
+    sed -e 's/'$1'/#'$1'/' -i $TST_DATAROOT/cpuplugdtest.conf
+}
+
+prepare_incomplete_cmm_test_config() {
+    rm -rf $TST_DATAROOT/cpuplugdtest.conf
+    cp $TST_DATAROOT/cpuplugdcmm.conf $TST_DATAROOT/cpuplugdtest.conf
+    sed -e 's/'$1'/#'$1'/' -i $TST_DATAROOT/cpuplugdtest.conf
+}
+
+#run cpuplgd with cpuplugdtest.conf and verify change in number of cpus before/during/after running the daemon
+cpu_test_with_error_in_cpuplgdtest_conf() {
+    local NOT_RUNNING="$1"
+    local WARN="$2"
+
+    # cmm must not be loaded so that cpuplugd will only consider the cpu configuration
+    if [ "$CMM_MOD" = "m" ]; then
+        rmmod cmm
+    fi
+
+    assert_cpuplugd_running 1 0
+    local RC=$?
+
+    if [ "$RC" -eq "0" ]; then
+        stop_cpuplugd
+    fi
+
+    cpusbefore=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+    tst_res TINFO "start cpuplugd -V -c cpuplugdtest.conf -f"
+    cpuplugd -V -c $TST_DATAROOT/cpuplugdtest.conf -f >> cpuf &
+    sleep 0.2
+
+    if [ "$CMM_MOD" = "m" ]; then
+        assert_cpuplugd_running $NOT_RUNNING $WARN
+    else
+        assert_cpuplugd_running $NOT_RUNNING $WARN
+    fi
+
+    local RC=$?
+
+    # Wait a little to allow for (undesired) cpu configuration change
+    sleep $SLEEP_X
+    cpusrunning=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+
+    if [ "$RC" -eq "0" ]; then
+        stop_cpuplugd
+    fi
+
+    local cpusafter=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+    local i=0
+
+    if (( "$cpusbefore" == "$cpusrunning" )) && (( "$cpusrunning" == "$cpusafter" )); then
+        i=1
+    fi
+
+    tst_res TINFO  "Verify that CPU configuration does not change: cpusbefore=$cpusbefore, cpusduring=$cpusrunning, cpusafterter=$cpusafter"
+    if [ $i -eq 1 ]; then
+            tst_res TPASS "Test passed"
+    else
+            tst_res TFAIL "Test failed"
+    fi
+}
+
+#run cpuplgd with cpuplugdtest.conf and verify change in number of cmm pagess before/during/after running the daemon
+cmm_test_with_error_in_cpuplgdtest_conf() {
+    local NOT_RUNNING="$1"
+    local WARN="$2"
+
+    assert_cpuplugd_running 1 0
+    local RC=$?
+
+    if [ "$RC" -eq "0" ]; then
+        stop_cpuplugd
+    fi
+
+    if [ "$CMM_MOD" = "m" ]; then
+        modprobe cmm
+    fi
+
+    echo 1000 > /proc/sys/vm/cmm_pages
+    sleep 0.2
+
+    cmm_pages_before=$(cat /proc/sys/vm/cmm_pages)
+
+    tst_res TINFO "start cpuplugd -V -c cpuplugdtest.conf -f"
+    cpuplugd -V -c $TST_DATAROOT/cpuplugdtest.conf -f >> cmm &
+    sleep 0.2
+
+    assert_cpuplugd_running $NOT_RUNNING $WARN
+    local RC=$?
+
+    # Wait a little to allow for (undesired) cpu configuration change
+    sleep $SLEEP_X
+    local cmm_pages_running=$(cat /proc/sys/vm/cmm_pages)
+
+    if [ "$RC" -eq "0" ]; then
+        stop_cpuplugd
+    fi
+
+    local cmm_pages_after=$(cat /proc/sys/vm/cmm_pages)
+    i=0
+
+    if (( "$cmm_pages_before" == "$cmm_pages_running" )) && (( "$cmm_pages_running" == "$cmm_pages_after" )); then
+        i=1
+    fi
+
+    tst_res TINFO "Verify that the number of available CMM pages does not change: cmm_pages_before=$cmm_pages_before, cmm_pages_running=$cmm_pages_running, cmm_pages_after=$cmm_pages_after"
+    if [ "${i}" -eq "1" ]; then
+            tst_res TPASS "Test passed"
+    else
+            tst_res TFAIL "Test failed"
+    fi
+
+    if [ "$CMM_MOD" = "m" ]; then
+        rmmod cmm
+    fi
+}
+
+exec_cpu_test_with_error_in_cpuplugd_conf()
+{
+    local notrun=1
+    isVM && [ "$CMM_MOD" = "y" ] && notrun=0
+    cpu_test_with_error_in_cpuplgdtest_conf $notrun 1
+}
+
+cpuplugd_run()
+{
+
+        $1
+        if [ "$?" -eq "$2" ]; then
+                tst_res TPASS "'$1' returned '$2'"
+        else
+                tst_res TFAIL "'$1' did not return '$2'"
+        fi
+}
+
+cpuplugd_test1()
+{
+    tst_res TINFO "Cpuplugd version"
+    local cpuplugd=$(cpuplugd -v | head -n 1 | cut -d":" -f2 | cut -d" " -f10)
+    cpuplugd_run "cpuplugd -v" 0
+    tst_res TINFO "Cpuplugd version $cpuplugd"
+}
+cpuplugd_test2()
+{
+    tst_res TINFO "Cpuplugd Help information checking"
+    tst_res TINFO "Checking for Help information with -h option"
+    cpuplugd_run "cpuplugd -h" 0
+    tst_res TINFO "Checking for Help information with --help option"
+    cpuplugd_run "cpuplugd --help" 0
+}
+
+# Run several tests with incomplete/broken configuration.
+# Correct behavior for the daemon is not to start.
+cpuplugd_test3()
+{
+    tst_res TINFO "Invalid options checking"
+    tst_res TINFO "Checking for Invalid option -H"
+    cpuplugd_run "cpuplugd -H" 1
+    tst_res TINFO "Checking for Invalid option -1234"
+    cpuplugd_run "cpuplugd -1234" 1
+}
+
+cpuplugd_test4()
+{
+    tst_res TINFO "Run daemon without UPDATE entry in config"
+    prepare_incomplete_cpu_test_config UPDATE
+    cpu_test_with_error_in_cpuplgdtest_conf 1 1
+}
+
+cpuplugd_test5()
+{
+    tst_res TINFO "Run Daemon without CPU_MIN entry"
+    prepare_incomplete_cpu_test_config CPU_MIN
+    exec_cpu_test_with_error_in_cpuplugd_conf
+}
+
+cpuplugd_test6()
+{
+    tst_res TINFO "Run Daemon without CPU_MAX entry"
+    prepare_incomplete_cpu_test_config CPU_MAX
+    cpu_test_with_error_in_cpuplgdtest_conf 1 1
+}
+
+cpuplugd_test7()
+{
+    tst_res TINFO "Run Daemon without HOTPLUG entry"
+    prepare_incomplete_cpu_test_config HOTPLUG
+    exec_cpu_test_with_error_in_cpuplugd_conf
+}
+
+cpuplugd_test8()
+{
+    tst_res TINFO "Run Daemon without HOTUNPLUG entry"
+    prepare_incomplete_cpu_test_config HOTUNPLUG
+    exec_cpu_test_with_error_in_cpuplugd_conf
+}
+
+# Good path test for CPU plugging.
+# Run daemon with only cpu configuration in configuration file
+# CPU Hotplug with 3 Active cpus and CPU_MIN=1 and CPU_MAX=3
+# Verify that number of CPUs is reduced after daemon is started
+# and restored after daemon is stopped.
+cpuplugd_test9()
+{
+        tst_res TINFO  "Run Daemon with only cpu configuration"
+
+        assert_cpuplugd_running 1 1
+
+        local cpusbefore=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+        echo "running daemon with only cpu config" > cpuf
+        tst_res TINFO "start cpuplugd -V -c $TST_DATAROOT/cpu.conf -f "
+        cpuplugd  -V -c $TST_DATAROOT/cpu.conf -f >> cpuf &
+        sleep 0.2
+
+        assert_cpuplugd_running 0 1
+        local RC=$?
+        tst_res TINFO "Let Daemon run for few seconds, so that it does the hotplugging"
+        sleep $SLEEP_X
+
+        local cpusrunning=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+
+        if [ "$RC" -eq "0" ]; then
+            stop_cpuplugd
+        fi
+
+        sleep 0.2
+        local cpusafter=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+        i=0
+
+        if [ "$cpusbefore" != "$cpusrunning" ] && [ "$cpusbefore" == "$cpusafter" ]; then
+            tst_res TPASS "Verify that number of CPUs before, while and after the daemon runs changes: cpusbefore=$cpusbefore, cpusduring=$cpusrunning, cpusafterter=$cpusafter"
+        else
+            tst_res TFAIL "Verify that number of CPUs before, while and after the daemon runs changes: cpusbefore=$cpusbefore, cpusduring=$cpusrunning, cpusafterter=$cpusafter"
+        fi
+}
+
+cpuplugd_test10()
+{
+   tst_res TINFO "Memory Hotplug tests (z/VM only)"
+
+   if ! isVM; then
+        # if it is LPAR, Memory Hotplug cannot be done
+        tst_res TINFO "This must be an LPAR. Skip CMM Tests"
+	return;
+   fi
+
+   # Run several tests with incomplete/broken configuration.
+   # Correct behavior for the daemon is not to start.
+
+   tst_res TINFO "Run Daemon without loading CMM module"
+       if [ "$CMM_MOD" != "m" ]; then
+           tst_res TINFO "This test is not possible to be performed since CMM was builtin within the kernel and cannot be unloaded."
+       else
+           assert_cpuplugd_running 1 0
+           local RC=$?
+
+           if [ "$RC" -eq "0" ]; then
+              stop_cpuplugd
+           fi
+
+           rmmod cmm
+           lsmod | grep -q cmm
+
+           if [ "$?" -eq "1" ]; then
+               tst_res TPASS "Verify that CMM module is not loaded"
+           else
+               tst_res TFAIL "Verify that CMM module is not loaded"
+           fi
+
+           cpuplugd -V -c $TST_DATAROOT/cmm.conf -f >> cmm.log &
+           tst_res TINFO "Daemon should fail to run as CMM module is not loaded"
+           sleep 0.2
+
+           assert_cpuplugd_running 1 1
+           local RC=$?
+
+           rm -rf cmm.log
+
+           if [ "$RC" -eq "0" ]; then
+               stop_cpuplugd
+           fi
+       fi
+
+
+   tst_res TINFO "Run Daemon without CMM_MIN entry"
+       prepare_incomplete_cmm_test_config CMM_MIN
+       cmm_test_with_error_in_cpuplgdtest_conf 1 1
+
+
+   tst_res TINFO "Run Daemon without CMM_MAX entry"
+       prepare_incomplete_cmm_test_config CMM_MAX
+       cmm_test_with_error_in_cpuplgdtest_conf 1 1
+
+
+   tst_res TINFO "Run Daemon without CMM_INC entry"
+       prepare_incomplete_cmm_test_config CMM_INC
+       cmm_test_with_error_in_cpuplgdtest_conf 1 1
+
+
+   tst_res TINFO "Run Daemon without MEMPLUG entry"
+       prepare_incomplete_cmm_test_config MEMPLUG
+       cmm_test_with_error_in_cpuplgdtest_conf 1 1
+
+
+   tst_res TINFO "Run Daemon without MEMUNPLUG entry"
+       prepare_incomplete_cmm_test_config MEMUNPLUG
+       cmm_test_with_error_in_cpuplgdtest_conf 1 1
+
+
+   # Good path test for CMM plugging
+
+   tst_res TINFO "Run Daemon with only CMM configuration"
+       if [ "$CMM_MOD" = "m" ]; then
+           modprobe cmm
+       fi
+
+       echo 1000 > /proc/sys/vm/cmm_pages
+       sleep 0.1
+
+       local cmm_pages_before=$(cat /proc/sys/vm/cmm_pages)
+       local cpusbefore=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+       cpuplugd -V -c $TST_DATAROOT/cmm.conf -f  >> cmm.log &
+       sleep 0.2
+
+       assert_cpuplugd_running 0 1
+       local RC=$?
+       sleep 0.4
+
+       local cmm_pages_running=$(cat /proc/sys/vm/cmm_pages)
+       local cpusrunning=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+
+       if [ "$RC" -eq "0" ]; then
+           stop_cpuplugd
+       fi
+
+       sleep 0.2
+
+       local cmm_pages_after=$(cat /proc/sys/vm/cmm_pages)
+       local cpusafter=$(grep "processors" /proc/cpuinfo | cut -d":" -f2)
+       local i=0
+
+       if [ "$cmm_pages_before" != "$cmm_pages_running" ] && [ "$cmm_pages_before" == "$cmm_pages_after" ]; then
+           if [ "$cpusbefore" == "$cpusrunning" ] && [ "$cpusbefore" == "$cpusafter" ]; then
+               i=1
+           fi
+       fi
+
+       if [ "$i" -eq "1" ];then
+           tst_res TPASS "Verify that the number of cmm_pages before, while and after the daemon runs changes:                 cmm_pages_before=$cmm_pages_before, cmm_pages_running=$cmm_pages_running, cmm_pages_after=$cmm_pages_after. CPU hotplugging should not happen and cpu configuration should remain constant: cpus_before=$cpusbefore, cpus_during=$cpusrunning, cpus_after=$cpusafter"
+       else
+           tst_res TFAIL "Verify that the number of cmm_pages before, while and after the daemon runs changes:                 cmm_pages_before=$cmm_pages_before, cmm_pages_running=$cmm_pages_running, cmm_pages_after=$cmm_pages_after. CPU hotplugging should not happen and cpu configuration should remain constant: cpus_before=$cpusbefore, cpus_during=$cpusrunning, cpus_after=$cpusafter"
+       fi
+
+}
+
+cpuplugd_test11()
+{
+    tst_res TINFO "Doing the cleanup tasks ..."
+    cpuplugd_run "service cpuplugd stop" 0
+
+    if [ "$CMM_MOD" = "m" ]; then
+        cpuplugd_run "rmmod cmm" 0
+    fi
+
+    cpuplugd_run "rm -rf cpuf cmm log cmm.log cpuplugdtest.conf te.tes out.txt.tmp" 0
+
+}
+
+tst_run
diff --git a/testcases/commands/cpuplugd/datafiles/cmm.conf b/testcases/commands/cpuplugd/datafiles/cmm.conf
new file mode 100644
index 000000000..59e71f726
--- /dev/null
+++ b/testcases/commands/cpuplugd/datafiles/cmm.conf
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+UPDATE="1"
+
+CMM_MIN="5000"
+CMM_INC="100"
+CMM_MAX="20000"
+
+MEMPLUG="swaprate < 200"
+MEMUNPLUG="swaprate > 5000"
diff --git a/testcases/commands/cpuplugd/datafiles/cpu.conf b/testcases/commands/cpuplugd/datafiles/cpu.conf
new file mode 100644
index 000000000..6a84d8177
--- /dev/null
+++ b/testcases/commands/cpuplugd/datafiles/cpu.conf
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CPU_MIN="1"
+CPU_MAX="3"
+UPDATE="1"
+
+HOTPLUG="(loadavg > onumcpus + 0.75) & (idle < 10.0)"
+HOTUNPLUG="(loadavg < onumcpus - 0.25) | (idle > 50)"
diff --git a/testcases/commands/cpuplugd/datafiles/cpuplugd.conf b/testcases/commands/cpuplugd/datafiles/cpuplugd.conf
new file mode 100644
index 000000000..09d76b993
--- /dev/null
+++ b/testcases/commands/cpuplugd/datafiles/cpuplugd.conf
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CPU_MIN="1"
+CPU_MAX="3"
+UPDATE="1"
+
+HOTPLUG="(loadavg > onumcpus + 0.75) & (idle < 10.0)"
+HOTUNPLUG="(loadavg < onumcpus - 0.25) | (idle > 50)"
+
+CMM_MIN="0"
+CMM_INC="10"
+CMM_MAX="10"
+
+MEMPLUG="swaprate < 200"
+MEMUNPLUG="swaprate > 5000"
diff --git a/testcases/commands/cpuplugd/datafiles/cpuplugdcmm.conf b/testcases/commands/cpuplugd/datafiles/cpuplugdcmm.conf
new file mode 100644
index 000000000..ca393249e
--- /dev/null
+++ b/testcases/commands/cpuplugd/datafiles/cpuplugdcmm.conf
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+UPDATE="1"
+
+CMM_MIN="0"
+CMM_INC="10"
+CMM_MAX="10"
+
+MEMPLUG="swaprate < 200"
+MEMUNPLUG="swaprate > 5000"
diff --git a/testcases/commands/cpuplugd/datafiles/cpuplugdtemp.conf b/testcases/commands/cpuplugd/datafiles/cpuplugdtemp.conf
new file mode 100644
index 000000000..157422780
--- /dev/null
+++ b/testcases/commands/cpuplugd/datafiles/cpuplugdtemp.conf
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CPU_MIN="1"
+CPU_MAX="3"
+UPDATE="1"
+
+HOTPLUG="(loadavg > onumcpus + 0.75) & (idle < 10.0)"
+HOTUNPLUG="(loadavg < onumcpus - 0.25) | (idle > 50)"
+
+#CMM_MIN="0"
+CMM_INC="10"
+CMM_MAX="10"
+
+MEMPLUG="swaprate < 200"
+MEMUNPLUG="swaprate > 5000"
diff --git a/testcases/commands/cpuplugd/mon_fsstatd.sh b/testcases/commands/cpuplugd/mon_fsstatd.sh
new file mode 100644
index 000000000..a1dc4ee03
--- /dev/null
+++ b/testcases/commands/cpuplugd/mon_fsstatd.sh
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+#!/bin/sh
+
+sed -i 's/FSSTAT="no"/FSSTAT="yes"/' /etc/sysconfig/mon_statd
+sed -i 's/PROC="no"/PROC="yes"/' /etc/sysconfig/mon_statd
+
+TST_CNT=1
+TST_TESTFUNC=mon_fsstatd_test
+. tst_test.sh
+
+source s390_lib.sh
+
+s390_config_check(){
+        local config="$1"
+        local config_line=$(env | grep "$config=")
+
+        if [ $? -ne 0 ]; then
+                tst_brk TCONF "Config option $config not defined"
+        else
+                local value=$(echo $config_line | awk -F = '{print $2}')
+                echo "USING CONFIG: $config=$value"
+        fi
+}
+
+s390_config_check S390_mon_statd
+
+
+mon_fsstatd_run()
+{
+        $2
+        if [ "$?" -eq "$1" ]; then
+                tst_res TPASS "'$2' returned '$1'"
+        else
+                tst_res TFAIL "'$2' did not return '$1'"
+        fi
+}
+
+mon_fsstatd_test1()
+{
+    if ! isVM; then
+        tst_res TINFO "This must be an LPAR. Not applicable in LPAR"
+        return;
+    fi
+
+    tst_res TINFO "Basic User option Verification"
+    mon_fsstatd_run 0 "modprobe monwriter max_bufs=8192"
+
+    sleep 0.5
+    service mon_statd status
+    [ $? -eq 3 ] && tst_res TINFO "mon_statd is not started yet"
+
+    sleep 0.2
+    mon_fsstatd_run 0 "service mon_statd stop"
+
+    sleep 0.2
+    mon_fsstatd_run 0 "service mon_statd start"
+
+    sleep 0.2
+    mon_fsstatd_run 0 "pidof mon_fsstatd"
+    mon_fsstatd_run 0 "pidof mon_procd"
+
+    sleep 0.2
+    mon_fsstatd_run 0 "service mon_statd restart"
+
+    sleep 0.2
+    mon_fsstatd_run 0 "mon_fsstatd -h"
+
+    mon_fsstatd_run 0 "mon_fsstatd --help"
+
+    mon_fsstatd_run 0 "mon_fsstatd -v"
+
+    mon_fsstatd_run 0 "mon_fsstatd --version"
+
+    mon_fsstatd_run 0 "mon_fsstatd -i 30"
+
+    sleep 0.5
+    mon_fsstatd_run 0 "mon_procd -h"
+
+    mon_fsstatd_run 0 "mon_procd --help"
+
+    mon_fsstatd_run 0 "mon_procd -v"
+
+    mon_fsstatd_run 0 "mon_procd --version"
+
+    mon_fsstatd_run 0 "mon_procd -i 30"
+
+    sleep 0.5
+    mon_procd -a &
+    if [ "$?" -eq "0" ]; then
+            tst_res TPASS "'mon_procd -a' returned 0"
+    else
+            tst_res TFAIL "'mon_procd -a' did not return 0"
+    fi
+
+    mon_fsstatd_run 0 "killall mon_procd"
+
+    sleep 0.2
+    mon_fsstatd -a &
+    if [ "$?" -eq "0" ]; then
+            tst_res TPASS "'mon_fsstatd -a' returned 0"
+    else
+            tst_res TFAIL "'mon_fsstatd -a' did not return 0"
+    fi
+
+    mon_fsstatd_run 0 "killall mon_fsstatd"
+
+    sleep 0.2
+    mon_fsstatd_run 0 "mon_procd -v"
+
+}
+
+tst_run
diff --git a/testcases/commands/cpuplugd/s390_lib.sh b/testcases/commands/cpuplugd/s390_lib.sh
new file mode 100644
index 000000000..5930457a0
--- /dev/null
+++ b/testcases/commands/cpuplugd/s390_lib.sh
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# This is a set of functions for s390x_tests
+
+#!/bin/bash
+
+load_vmcp(){
+ local GUESTNAME=""
+
+ if [ ! -e /proc/sysinfo ] ; then
+  tst_brk TBROK "Cannot access /proc/sysinfo"
+ fi
+
+ GUESTNAME="$(cat /proc/sysinfo | grep -i VM00.Name | sed 's/^.*:[[:space:]]*//g;s/[[:space:]]//g' | tr '[a-z]' '[A-Z]')"
+
+ if [ -n "$GUESTNAME" ];then
+      `vmcp q cpus > /dev/null 2>&1`
+      if [ $? -ne 0 ];then
+       modprobe vmcp >/dev/null 2>&1
+       tst_res TINFO "Module vmcp loaded"
+      fi
+      return 0
+ fi
+ return 1
+}
+
+isVM(){
+   local GUESTNAME=""
+   local GUESTNO=""
+
+   if [ ! -e /proc/sysinfo ] ; then
+    tst_brk TBROK "Cannot access /proc/sysinfo"
+   fi
+
+   GUESTNAME="$(cat /proc/sysinfo | grep -i VM00.Name | sed 's/^.*:[[:space:]]*//g;s/[[:space:]]//g' | tr '[a-z]' '[A-Z]')"
+
+   if [ -z "$GUESTNAME" ];then
+    return 1
+   fi
+   if [ -n "$GUESTNAME" ];then
+      load_vmcp
+      return 0
+   fi
+   return 1
+}
-- 
2.17.2 (Apple Git-113)

