From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Mar 2016 16:24:52 +0800
Subject: [LTP] [PATCH RFC 3/9] tracing[2]: reorganize ftrace stress tests to
	general tests
In-Reply-To: <1457079898-9449-3-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
Message-ID: <1457079898-9449-4-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In this commit, code changing as below:
----
new file:   ftrace_regression_test.sh
modified:   ftrace_stress_test.sh
renamed:    ftrace_stress_test.sh -> ftrace_lib.sh

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/tracing                                    |   1 +
 testcases/kernel/tracing/ftrace_test/Makefile      |   2 +-
 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh | 157 +++++++++++++
 .../tracing/ftrace_test/ftrace_regression_test.sh  |  59 +++++
 .../tracing/ftrace_test/ftrace_stress_test.sh      | 256 ++++++---------------
 5 files changed, 285 insertions(+), 190 deletions(-)
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression_test.sh

diff --git a/runtest/tracing b/runtest/tracing
index ef3a048..e14e87a 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -1,2 +1,3 @@
 #DESCRIPTION:Tracing testing
+ftrace-regression-test	ftrace_regression_test.sh
 ftrace-stress-test	ftrace_stress_test.sh 90
diff --git a/testcases/kernel/tracing/ftrace_test/Makefile b/testcases/kernel/tracing/ftrace_test/Makefile
index e4a913a..35f1af5 100644
--- a/testcases/kernel/tracing/ftrace_test/Makefile
+++ b/testcases/kernel/tracing/ftrace_test/Makefile
@@ -2,6 +2,6 @@ top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS         := *.sh ftrace_stress/*
+INSTALL_TARGETS         := *.sh ftrace_function/* ftrace_regression/* ftrace_stress/*
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
new file mode 100755
index 0000000..7c72afb
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
@@ -0,0 +1,157 @@
+#! /bin/sh
+
+###########################################################################
+##                                                                       ##
+## Copyright (c) 2010 FUJITSU LIMITED                                    ##
+##                                                                       ##
+## This program is free software: you can redistribute it and/or modify  ##
+## it under the terms of the GNU General Public License as published by  ##
+## the Free Software Foundation, either version 3 of the License, or     ##
+## (at your option) any later version.                                   ##
+##                                                                       ##
+## This program is distributed in the hope that it will be useful,       ##
+## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
+## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
+## GNU General Public License for more details.                          ##
+##                                                                       ##
+## You should have received a copy of the GNU General Public License     ##
+## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
+##                                                                       ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
+##                                                                       ##
+###########################################################################
+
+cd $LTPROOT/testcases/bin
+
+export TPATH="$PWD"
+export DEBUGFS_PATH="$PWD/debugfs"
+export TRACING_PATH="$PWD/debugfs/tracing"
+export FPATH="$TPATH/ftrace_function"
+export RPATH="$TPATH/ftrace_regression"
+export SPATH="$TPATH/ftrace_stress"
+
+. test.sh
+
+test_interval=$1
+test_success=true
+
+save_old_setting()
+{
+	cd $TRACING_PATH
+
+	old_trace_options=( `cat trace_options` )
+	old_tracing_on=`cat tracing_on`
+	old_tracing_enabled=`cat tracing_enabled`
+	old_buffer_size=`cat buffer_size_kb`
+
+	if [ -e stack_max_size ]; then
+		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
+	fi
+
+	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
+		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
+	fi
+
+	if [ -e "function_profile_enabled" ]; then
+		old_profile_enabled=`cat function_profile_enabled`
+	fi
+
+	cd - > /dev/null
+}
+
+restore_old_setting()
+{
+	cd $TRACING_PATH
+
+	echo nop > current_tracer
+	echo 0 > events/enable
+	echo 0 > tracing_max_latency 2> /dev/null
+
+	if [ -e trace_clock ]; then
+		echo local > trace_clock
+	fi
+
+	if [ -e "function_pofile_enabled" ]; then
+		echo $old_profile_enabled > function_profile_enabled
+	fi
+
+	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
+		echo $old_ftrace_enabled > /proc/sys/kernel/ftrace_enabled
+	fi
+
+	if [ -e stack_max_size ]; then
+		echo $old_stack_tracer_enabled > /proc/sys/kernel/stack_tracer_enabled
+		echo 0 > stack_max_size
+	fi
+
+	echo $old_buffer_size > buffer_size_kb
+	echo $old_tracing_on > tracing_on
+	echo $old_tracing_enabled > tracing_enabled
+
+	for option in $old_trace_options
+	do
+		echo $option > trace_options 2> /dev/null
+	done
+
+	echo > trace
+
+	cd - > /dev/null
+}
+
+clean_up()
+{
+	restore_old_setting
+
+	umount $DEBUGFS_PATH
+	rmdir $DEBUGFS_PATH
+}
+
+clean_up_exit()
+{
+	clean_up
+	exit 1
+}
+
+test_begin()
+{
+	start_time=`date +%s`
+}
+
+test_wait()
+{
+	for ((; ;))
+	{
+		sleep 2
+
+		cur_time=`date +%s`
+		elapsed=$(( $cur_time - $start_time ))
+
+		# run the test for $test_interval secs
+		if [ $elapsed -ge $test_interval ]; then
+			break
+		fi
+	}
+}
+
+trap clean_up_exit INT
+
+tst_require_root
+
+# Don't run the test on kernels older than 2.6.34, otherwise
+# it can crash the system if the kernel is not latest-stable
+tst_kvercmp 2 6 34
+if [ $? -eq 0 ]; then
+	tst_brkm TCONF ignored "The test should be run in kernels >= 2.6.34. Skip the test..."
+	exit 0
+fi
+
+mkdir $DEBUGFS_PATH
+mount -t debugfs xxx $DEBUGFS_PATH
+
+# Check to see tracing feature is supported or not
+if [ ! -d $TRACING_PATH ]; then
+	tst_brkm TCONF ignored "Tracing is not supported. Skip the test..."
+	umount $DEBUGFS_PATH
+	rmdir $DEBUGFS_PATH
+	exit 0
+fi
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression_test.sh
new file mode 100755
index 0000000..3646619
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression_test.sh
@@ -0,0 +1,59 @@
+#! /bin/sh
+
+###########################################################################
+##                                                                       ##
+## Copyright (c) 2015, Red Hat Inc.                                      ##
+##                                                                       ##
+## This program is free software: you can redistribute it and/or modify  ##
+## it under the terms of the GNU General Public License as published by  ##
+## the Free Software Foundation, either version 3 of the License, or     ##
+## (at your option) any later version.                                   ##
+##                                                                       ##
+## This program is distributed in the hope that it will be useful,       ##
+## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
+## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
+## GNU General Public License for more details.                          ##
+##                                                                       ##
+## You should have received a copy of the GNU General Public License     ##
+## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
+##                                                                       ##
+## Author: Li Wang <liwang@redhat.com>                                   ##
+##                                                                       ##
+###########################################################################
+
+export TCID="ftrace-regression-test"
+export TST_TOTAL=1
+export TST_COUNT=1
+
+. ftrace_lib.sh
+
+test_check()
+{
+	if $test_success; then
+		tst_resm TPASS "finished running the test: $subcase."
+	else
+		tst_resm TFAIL "running the test: $subcase failed, please check log message."
+	fi
+
+	test_success=true
+}
+
+test_regression()
+{
+	local subcase
+	for subcase in $(find $RPATH -name 'ftrace*.sh'); do
+		$subcase || test_success=false
+		test_check
+	done
+}
+
+# ----------------------------
+echo "Ftrace Regression Test Begin"
+
+save_old_setting
+
+test_regression
+
+clean_up
+
+echo "Ftrace Regression Test End"
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
index dc8cf3e..beced43 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
@@ -1,105 +1,80 @@
 #! /bin/sh
 
-################################################################################
-##                                                                            ##
-## Copyright (c) 2010 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-cd $LTPROOT/testcases/bin
-
-export TCID="ftrace-test"
+###########################################################################
+##                                                                       ##
+## Copyright (c) 2010 FUJITSU LIMITED                                    ##
+##                                                                       ##
+## This program is free software: you can redistribute it and/or modify  ##
+## it under the terms of the GNU General Public License as published by  ##
+## the Free Software Foundation, either version 3 of the License, or     ##
+## (at your option) any later version.                                   ##
+##                                                                       ##
+## This program is distributed in the hope that it will be useful,       ##
+## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
+## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
+## GNU General Public License for more details.                          ##
+##                                                                       ##
+## You should have received a copy of the GNU General Public License     ##
+## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
+##                                                                       ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
+##                                                                       ##
+###########################################################################
+
+
+export TCID="ftrace-stress-test"
 export TST_TOTAL=1
 export TST_COUNT=1
 
-export TPATH="$PWD"
-export DEBUGFS_PATH="$PWD/debugfs"
-export TRACING_PATH="$PWD/debugfs/tracing"
-export SPATH="$TPATH/ftrace_stress"
+. ftrace_lib.sh
 
-test_interval=$1
-test_success=true
-
-save_old_setting()
+export_pids()
 {
-	cd $TRACING_PATH
-
-	old_trace_options=( `cat trace_options` )
-	old_tracing_on=`cat tracing_on`
-	old_tracing_enabled=`cat tracing_enabled`
-	old_buffer_size=`cat buffer_size_kb`
-
-	if [ -e stack_max_size ]; then
-		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
-	fi
-
-	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
-		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
-	fi
-
-	if [ -e "function_profile_enabled" ]; then
-		old_profile_enabled=`cat function_profile_enabled`
-	fi
+	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
+		pid13 pid14 pid15 pid16
 
-	cd - > /dev/null
+	export NR_PIDS=16
 }
 
-restore_old_setting()
+test_stress()
 {
-	cd $TRACING_PATH
-
-	echo nop > current_tracer
-	echo 0 > events/enable
-	echo 0 > tracing_max_latency 2> /dev/null
-
-	if [ -e trace_clock ]; then
-		echo local > trace_clock
-	fi
-
-	if [ -e "function_pofile_enabled" ]; then
-		echo $old_profile_enabled > function_profile_enabled
-	fi
-
-	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
-		echo $old_ftrace_enabled > /proc/sys/kernel/ftrace_enabled
-	fi
-
-	if [ -e stack_max_size ]; then
-		echo $old_stack_tracer_enabled > /proc/sys/kernel/stack_tracer_enabled
-		echo 0 > stack_max_size
-	fi
-
-	echo $old_buffer_size > buffer_size_kb
-	echo $old_tracing_on > tracing_on
-	echo $old_tracing_enabled > tracing_enabled
-
-	for option in $old_trace_options
-	do
-		echo $option > trace_options 2> /dev/null
-	done
-
-	echo > trace
-
-	cd - > /dev/null
+	export_pids
+
+	$SPATH/ftrace_trace_clock.sh &
+	pid1=$!
+	$SPATH/ftrace_current_tracer.sh &
+	pid2=$!
+	$SPATH/ftrace_trace_options.sh &
+	pid3=$!
+	$SPATH/ftrace_tracing_max_latency.sh &
+	pid4=$!
+	$SPATH/ftrace_stack_trace.sh &
+	pid5=$!
+	$SPATH/ftrace_stack_max_size.sh &
+	pid6=$!
+	$SPATH/ftrace_tracing_on.sh &
+	pid7=$!
+	$SPATH/ftrace_tracing_enabled.sh &
+	pid8=$!
+	$SPATH/ftrace_set_event.sh &
+	pid9=$!
+	$SPATH/ftrace_buffer_size.sh &
+	pid10=$!
+	$SPATH/ftrace_trace.sh &
+	pid11=$!
+	$SPATH/ftrace_trace_pipe.sh &
+	pid12=$!
+	$SPATH/ftrace_ftrace_enabled.sh &
+	pid13=$!
+	$SPATH/ftrace_set_ftrace_pid.sh &
+	pid14=$!
+	$SPATH/ftrace_profile_enabled.sh &
+	pid15=$!
+	$SPATH/ftrace_trace_stat.sh &
+	pid16=$!
 }
 
-clean_up()
+test_kill()
 {
 	kill -KILL $pid1 || test_success=false
 	kill -KILL $pid2 || test_success=false
@@ -119,118 +94,22 @@ clean_up()
 	kill -KILL $pid16 || test_success=false
 
 	sleep 2
-	restore_old_setting
-
-	umount $DEBUGFS_PATH
-	rmdir $DEBUGFS_PATH
-}
-
-clean_up_exit()
-{
 	clean_up
-	exit 1
 }
 
-export_pids()
-{
-	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
-		pid13 pid14 pid15 pid16
-
-	export NR_PIDS=16
-}
-
-test_begin()
-{
-	start_time=`date +%s`
-}
-
-test_wait()
-{
-	for ((; ;))
-	{
-		sleep 2
-
-		cur_time=`date +%s`
-		elapsed=$(( $cur_time - $start_time ))
-
-		# run the test for $test_interval secs
-		if [ $elapsed -ge $test_interval ]; then
-			break
-		fi
-	}
-}
-
-trap clean_up_exit INT
-
-# Should be run by root user
-if [ `id -ru` != 0 ]; then
-	tst_brkm TCONF ignored "The test should be run by root user. Skip the test..."
-	exit 0
-fi
-
-# Don't run the test on kernels older than 2.6.34, otherwise
-# it can crash the system if the kernel is not latest-stable
-tst_kvercmp 2 6 34
-if [ $? -eq 0 ]; then
-	tst_brkm TCONF ignored "The test should be run in kernels >= 2.6.34. Skip the test..."
-	exit 0
-fi
-
-mkdir $DEBUGFS_PATH
-mount -t debugfs xxx $DEBUGFS_PATH
-
-# Check to see tracing feature is supported or not
-if [ ! -d $TRACING_PATH ]; then
-	tst_brkm TCONF ignored "Tracing is not supported. Skip the test..."
-	umount $DEBUGFS_PATH
-	rmdir $DEBUGFS_PATH
-	exit 0
-fi
 
+# ----------------------------
 echo "Ftrace Stress Test Begin"
 
 save_old_setting
 
 test_begin
 
-$SPATH/ftrace_trace_clock.sh &
-pid1=$!
-$SPATH/ftrace_current_tracer.sh &
-pid2=$!
-$SPATH/ftrace_trace_options.sh &
-pid3=$!
-$SPATH/ftrace_tracing_max_latency.sh &
-pid4=$!
-$SPATH/ftrace_stack_trace.sh &
-pid5=$!
-$SPATH/ftrace_stack_max_size.sh &
-pid6=$!
-$SPATH/ftrace_tracing_on.sh &
-pid7=$!
-$SPATH/ftrace_tracing_enabled.sh &
-pid8=$!
-$SPATH/ftrace_set_event.sh &
-pid9=$!
-$SPATH/ftrace_buffer_size.sh &
-pid10=$!
-$SPATH/ftrace_trace.sh &
-pid11=$!
-$SPATH/ftrace_trace_pipe.sh &
-pid12=$!
-$SPATH/ftrace_ftrace_enabled.sh &
-pid13=$!
-$SPATH/ftrace_set_ftrace_pid.sh &
-pid14=$!
-$SPATH/ftrace_profile_enabled.sh &
-pid15=$!
-$SPATH/ftrace_trace_stat.sh &
-pid16=$!
-
-export_pids
+test_stress
 
 test_wait
 
-clean_up
+test_kill
 
 echo "Ftrace Stress Test End"
 
@@ -240,4 +119,3 @@ else
 	tst_resm TFAIL "please check log message."
 	exit 1
 fi
-
-- 
1.8.3.1

