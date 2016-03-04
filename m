From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Mar 2016 16:24:58 +0800
Subject: [LTP] [PATCH RFC 9/9] ftrace_stress: add two new tests
In-Reply-To: <1457079898-9449-9-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
 <1457079898-9449-9-git-send-email-liwang@redhat.com>
Message-ID: <1457079898-9449-10-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Chunyu Hu <chuhu@redhat.com>

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh |   2 +
 .../ftrace_stress/ftrace_set_ftrace_filter.sh      | 103 +++++++++++++++++++++
 .../ftrace_stress/ftrace_tracing_cpumask.sh        |  51 ++++++++++
 .../tracing/ftrace_test/ftrace_stress_test.sh      |   3 +-
 4 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
index 81af617..5fceb80 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
@@ -42,6 +42,7 @@ save_old_setting()
 	old_trace_options=( `cat trace_options` )
 	old_tracing_on=`cat tracing_on`
 	old_buffer_size=`cat buffer_size_kb`
+	old_tracing_cpumask=`cat tracing_cpumask`
 
 	if [ -e tracing_enabled ]; then
 		old_tracing_enabled=`cat tracing_enabled`
@@ -69,6 +70,7 @@ restore_old_setting()
 	echo nop > current_tracer
 	echo 0 > events/enable
 	echo 0 > tracing_max_latency 2> /dev/null
+	echo $old_tracing_cpumask > tracing_cpumask
 
 	if [ -e trace_clock ]; then
 		echo local > trace_clock
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
new file mode 100755
index 0000000..2f9a143
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
@@ -0,0 +1,103 @@
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
+triggers=( traceon traceoff enable_event disable_event snapshot\
+	 dump cpudump stacktrace module function )
+n_triggers=${#triggers}
+
+module_pick()
+{
+	nr_module=$(lsmod | wc -l)
+	pick_one=$(( (RANDOM % nr_module) +1 ))
+	picked_module=$(lsmod | sed -n ''$pick_one'p')
+}
+
+nr_functions=$(cat $TRACING_PATH/available_filter_functions|wc -l)
+
+function_pick()
+{
+	if [ -f $TRACING_PATH/available_filter_functions ]; then
+		local pick_one=$(( (RANDOM % nr_functions) + 1 ))
+		picked_function=$(cat $TRACING_PATH/available_filter_functions |\
+				 sed -n ''$pick_one'p'|awk '{print $1}')
+		echo $picked_function
+	else
+		echo "\*sched\*"
+	fi
+}
+
+event_pick()
+{
+	if [ -f $TRACING_PATH/available_events ]; then
+		nr_events=$(cat $TRACING_PATH/available_events | wc -l)
+		local pick_one=$(( (RANDOM % nr_events) + 1 ))
+		picked_event=$(cat $TRACING_PATH/available_events | sed -n ''$pick_one'p')
+		echo "$picked_event"
+	else
+		echo "sched:sched_switch"
+	fi
+}
+
+filter_formatter()
+{
+	local count=$(( (RANDOM % 5) + 1 ))
+	function_name=$(function_pick)
+	case $1 in
+	traceon|traceoff|snapshot|dump|cpudump|stacktrace|module|function)
+		format=$1
+		;;
+	enable_event|disable_event)
+		event_sys_name=$(event_pick)
+		format=$1:$event_sys_name
+		;;
+	module)
+		module_pick
+		echo "$picked_module:\*"
+		return
+		;;
+	function)
+		echo "$picked_function"
+		return
+		;;
+	*)
+		format=$1
+		;;
+	esac
+	((count)) && format=$format:$count
+	echo $function_name:$format
+}
+
+for ((; ;))
+{
+	cat $TRACING_PATH/set_ftrace_filter > /dev/null
+	trigger_index=$((RANDOM % n_triggers))
+	trigger_name=${triggers[$trigger_index]}
+	filter_format=$(filter_formatter $trigger_name)
+
+	echo "$filter_format" > $TRACING_PATH/set_ftrace_filter
+	[ $? -ne 0 ] && echo "setup filter <$filter_format> failed"
+
+	sleep 1
+
+	echo "!$filter_format" > $TRACING_PATH/set_ftrace_filter
+	[ $? -ne 0 ] && echo "remove filter <$filter_format> failed"
+}
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
new file mode 100755
index 0000000..28bbc27
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
@@ -0,0 +1,51 @@
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
+nr_cpus=`tst_ncpus`
+
+get_random_value()
+{
+	local max=$1
+	local min=${2:-0}
+	local random=${RANDOM:-$(date +%N)}
+	echo $(( random % max  ))
+}
+
+get_test_cpumask()
+{
+	local random=${RANDOM:-$(date +%N)}
+	local set_cnt=$(get_random_value $nr_cpus);
+	mask=0
+	for ((c=0; c<set_cnt; c++));do
+		local cpuid=$(get_random_value $nr_cpus)
+		mask=$(( mask| (1<<$cpuid) ))
+	done
+	mask=`echo $mask | awk '{printf "%x",$0}'`
+}
+
+for ((; ;))
+{
+	get_test_cpumask
+	echo $mask > $TRACING_PATH/tracing_cpumask
+	sleep 5
+}
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
index d1be49a..49cae86 100755
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

