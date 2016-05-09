From: Chunyu Hu <chuhu@redhat.com>
Date: Mon,  9 May 2016 19:03:36 +0800
Subject: [LTP] [PATCH v3 7/9] ftrace_stress: update the trace_options test
In-Reply-To: <1462791818-4184-7-git-send-email-chuhu@redhat.com>
References: <1462791818-4184-1-git-send-email-chuhu@redhat.com>
 <1462791818-4184-2-git-send-email-chuhu@redhat.com>
 <1462791818-4184-3-git-send-email-chuhu@redhat.com>
 <1462791818-4184-4-git-send-email-chuhu@redhat.com>
 <1462791818-4184-5-git-send-email-chuhu@redhat.com>
 <1462791818-4184-6-git-send-email-chuhu@redhat.com>
 <1462791818-4184-7-git-send-email-chuhu@redhat.com>
Message-ID: <1462791818-4184-8-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ftrace_trace_options.sh is using hard coced trace options, including
the outdated 'branch', so let's get the trace_options dynamicly from the
trace_options file.

V2:
    Use tst_random.
    Fix bashism code style.
    Use ltp lib.
    Check the existence before setting.

V3:
   Remove the unneeded code comment.
   use tst_random directly.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 .../ftrace_stress/ftrace_trace_options.sh          | 58 ++++++++++++++--------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
index 47d2a62..253568c 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
@@ -13,30 +13,46 @@
 #                                                                             #
 ###############################################################################
 
-LOOP=200
-
-trace_options=(print-parent sym-offset sym-addr verbose raw hex bin block trace_printk ftrace_preempt branch annotate userstacktrace sym-userobj printk-msg-only context-info latency-format sleep-time graph-time)
+. test.sh
 
-NR_TRACE_OPTIONS=19
-
-for ((; ; ))
-{
-	for ((j = 0; j < $LOOP; j++))
-	{
-		num=`date +%N`
-		num=`printf 1%s $num`
+LOOP=200
 
-		for ((i = 0; i < $NR_TRACE_OPTIONS; i++))
-		{
-			n=$(( ( $num >> $i ) % 2 ))
+while true; do
+	j=0;
+	while [ $j -lt $LOOP ]; do
+		trace_options="$(ls $TRACING_PATH/options/)"
+		# enable the nop_test_refuse can cause an
+		# 'write error: Invalid argument'. So don't test it.
+		trace_options="$(echo $trace_options | sed 's/test_nop_refuse//')"
+		nr_trace_options=$(echo "${trace_options}" | wc -w)
+
+		option_index=$(tst_random 1 $nr_trace_options)
+		option=$(echo "$trace_options" | awk "{print \$$option_index}")
+		i=0
+		while [ $i -lt $nr_trace_options ]; do
+			n=$(tst_random 0 1)
+			opt_f="$TRACING_PATH"/options/$option
+			ret_val=0
 			if [ $n -eq 0 ]; then
-				echo 0 > "$TRACING_PATH"/options/${trace_options[$i]}
+				operation="setup"
 			else
-				echo 1 > "$TRACING_PATH"/options/${trace_options[$i]}
+				operation="clear"
+			fi
+			# On old kernel, some trace option dirs
+			# won't be made if the option has nothing
+			# to do with the current tracer. But on newer
+			# kernel(4.4-rc1), all option dirs will be made.
+			# So here check it to avoid 'Permision denied'
+			if [ -f $opt_f ]; then
+				echo $n > $opt_f
+				ret_val=$?
 			fi
-		}
-	}
-
-	sleep 1
-}
 
+			if [ $ret_val -ne 0 ]; then
+				tst_resm TFAIL "$0: $operation trace option $option failed"
+			fi
+			i=$((i + 1))
+		done
+		j=$((j + 1))
+	done
+done
-- 
1.8.3.1

