From: Chunyu Hu <chuhu@redhat.com>
Date: Mon, 18 Apr 2016 16:04:15 +0800
Subject: [LTP] [PATCH V2 8/9] ftrace_stress: add two new tests
In-Reply-To: <1460966656-28328-8-git-send-email-chuhu@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <1460966656-28328-8-git-send-email-chuhu@redhat.com>
Message-ID: <1460966656-28328-9-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

V2:
    Use tst_random to get random integer.
    Fix bashism code.
    Simplify the get of cpu mask, make it work with nr_cpu > 32.
    Update the set_ftrace_filter, use awk instead sed.small fix moddule filter.
    Use ltp lib.

V1:
   add ftrace_tracing_cpumask.sh.
   add ftrace_set_ftrace_filter.sh.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh |  22 ++++
 .../ftrace_stress/ftrace_set_ftrace_filter.sh      | 121 +++++++++++++++++++++
 .../ftrace_stress/ftrace_tracing_cpumask.sh        |  93 ++++++++++++++++
 .../tracing/ftrace_test/ftrace_stress_test.sh      |   3 +-
 4 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
index b7aef34..8632e24 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
@@ -41,6 +41,11 @@ save_old_setting()
 	old_trace_options=( `cat trace_options` )
 	old_tracing_on=`cat tracing_on`
 	old_buffer_size=`cat buffer_size_kb`
+	old_tracing_cpumask=`cat tracing_cpumask`
+
+	if [ -e tracing_cpumask ]; then
+		old_tracing_cpumask=`cat tracing_cpumask`
+	fi
 
 	if [ -e tracing_enabled ]; then
 		old_tracing_enabled=`cat tracing_enabled`
@@ -69,6 +74,10 @@ restore_old_setting()
 	echo 0 > events/enable
 	echo 0 > tracing_max_latency 2> /dev/null
 
+	if [ -e tracing_cpumask ]; then
+		echo $old_tracing_cpumask > tracing_cpumask
+	fi
+
 	if [ -e trace_clock ]; then
 		echo local > trace_clock
 	fi
@@ -100,6 +109,19 @@ restore_old_setting()
 
 	echo > trace
 
+	if [ -f set_ftrace_filter ]; then
+		cat set_ftrace_filter | \
+		while read flt; do
+			if [ -n "$flt" ]; then
+				# the line start with # started is comment.
+				if echo $flt | grep -e "^#"; then
+					continue;
+				fi
+				echo '!'"$flt" > set_ftrace_filter
+			fi
+		done
+	fi
+
 	cd - > /dev/null
 }
 
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
new file mode 100755
index 0000000..32b23d5
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
@@ -0,0 +1,121 @@
+#! /bin/sh
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
+## Author: Chunyu Hu <chuhu@redhat.com>                                  ##
+##                                                                       ##
+###########################################################################
+
+. test.sh
+
+triggers="traceon traceoff enable_event disable_event snapshot \
+	 dump cpudump stacktrace module function"
+nr_triggers=$(echo ${triggers} | wc -w)
+
+rand_gen=tst_random
+
+module_pick()
+{
+	nr_module=$(lsmod | wc -l)
+	pick_one=$($rand_gen 1 $nr_module)
+	picked_module=$(lsmod | awk "{if (NR == $pick_one) {print \$1}}")
+}
+
+filter_file=$TRACING_PATH/available_filter_functions
+nr_functions=$(awk 'END{print NR}' $filter_file)
+
+function_pick()
+{
+	if [ -f $filter_file ]; then
+		local pick_one=$($rand_gen 1 $nr_functions)
+		picked_function=$(awk "{if (NR == $pick_one) {print \$1}}" $filter_file)
+		echo $picked_function
+	else
+		echo "\*sched\*"
+	fi
+}
+
+event_pick()
+{
+	local events_file=$TRACING_PATH/available_events
+	if [ -f $events_file ]; then
+		nr_events=$(awk 'END{print NR}' $events_file)
+		local pick_one=$($rand_gen 1 $nr_events)
+		picked_event=$(awk "{if (NR == $pick_one) {print \$0}}" $events_file)
+		echo "$picked_event"
+	else
+		echo "sched:sched_switch"
+	fi
+}
+
+filter_formatter()
+{
+	function_str=$(function_pick)
+	count=$($rand_gen 0 2)
+
+	case $1 in
+	traceon|traceoff|snapshot|dump|cpudump|stacktrace)
+		trigger=$1
+		;;
+	enable_event|disable_event)
+		event_sys_name=$(event_pick)
+		trigger=$1:$event_sys_name
+		;;
+	module)
+		module_pick
+		echo ":mod:$picked_module"
+		return
+		;;
+	function)
+		echo "$function_str"
+		return
+		;;
+	*)
+		trigger=$1
+		;;
+	esac
+
+	if [ $count -gt 0 ]; then
+		trigger=$trigger:$count
+	fi
+	echo $function_str:$trigger
+}
+
+signal_handler()
+{
+	tst_exit
+}
+
+trap signal_handler SIGTERM
+
+while true; do
+	# Here try to check if a race caused issue can be hit.
+	cat $TRACING_PATH/set_ftrace_filter > /dev/null
+
+	trigger_index=$($rand_gen 1 $nr_triggers)
+	trigger_name=$(echo $triggers | awk "{print \$$trigger_index}")
+	filter_format=$(filter_formatter $trigger_name)
+
+	echo "$filter_format" > $TRACING_PATH/set_ftrace_filter
+	[ $? -ne 0 ] && tst_resm TFAIL "$0: setup filter <$filter_format> failed"
+
+	sleep 2
+
+	echo "!$filter_format" > $TRACING_PATH/set_ftrace_filter
+	[ $? -ne 0 ] && tst_resm TFAIL "$0: remove filter <$filter_format> failed"
+done
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
new file mode 100755
index 0000000..787a675
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
@@ -0,0 +1,93 @@
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
+## Author: Chunyu Hu <chuhu@redhat.com>                                  ##
+##                                                                       ##
+###########################################################################
+
+. test.sh
+nr_cpus=`tst_ncpus`
+rand_gen=tst_random
+
+# the 32 bit integer count. one integer is not
+# enough to restore the mask.
+
+if [ $nr_cpus -gt 32 ]; then
+	group_cnt=$((nr_cpus / 32))
+	range=31
+	rem=$((nr_cpus % 32))
+	if [ $rem -ne 0 ]; then
+		range_last=$((rem -1))
+	fi
+else
+	group_cnt=1
+	range=$((nr_cpus - 1))
+fi
+
+get_test_cpumask()
+{
+	mask=""
+
+	local i=0;
+	while [ $i -lt $group_cnt ]; do
+		# select count of cpu in one group, include the duplicate.
+		local set_cnt=$($rand_gen 1 $((range + 1)))
+
+		local c=0;
+		local temp_mask=0
+		while [ $c -lt $set_cnt ]; do
+			local group_cpuid=$($rand_gen 1 $range)
+			temp_mask=$((temp_mask | (1 << $group_cpuid)))
+			c=$((c + 1))
+		done
+
+		if  [ $i = 0 ]; then
+			mask=`echo $temp_mask | awk '{printf "%x",$0}'`
+		else
+			mask=$mask","`echo $temp_mask | awk '{printf "%x",$0}'`
+		fi
+
+		i=$((i + 1))
+	done
+
+	if [ $group_cnt -gt 1  ]; then
+		set_cnt=$($rand_gen 1 $((range_last +1)))
+		c=0;
+		temp_mask=0
+		while [ $c -lt $set_cnt ]; do
+			local group_cpuid=$($rand_gen 1 $range_last)
+			temp_mask=$((temp_mask | (1 << $group_cpuid)))
+			c=$((c + 1))
+		done
+		mask=`echo $temp_mask | awk '{printf "%x",$0}'`
+	fi
+
+	echo "$mask"
+}
+
+signal_handler()
+{
+	tst_exit
+}
+
+trap signal_handler SIGTERM SIGKILL
+
+while true; do
+	get_test_cpumask > $TRACING_PATH/tracing_cpumask
+done
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
index 80c914c..eb2c5f6 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
@@ -31,7 +31,8 @@ test_targets=" \
 trace_pipe current_tracer ftrace_enabled function_profile_enabled \
 set_event set_ftrace_pid stack_max_size stack_trace trace trace_clock \
 trace_options trace_stat tracing_enabled tracing_max_latency \
-tracing_on function_profile_enabled buffer_size_kb"
+tracing_on function_profile_enabled buffer_size_kb tracing_cpumask \
+set_ftrace_filter"
 
 get_skip_targets()
 {
-- 
1.8.3.1

