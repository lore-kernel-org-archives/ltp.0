From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Mar 2016 16:24:57 +0800
Subject: [LTP] [PATCH RFC 8/9] ftrace_stress: update the trace_options test
In-Reply-To: <1457079898-9449-8-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
Message-ID: <1457079898-9449-9-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Chunyu Hu <chuhu@redhat.com>

The ftrace_trace_options.sh is using hard coced trace options, including
the outdated 'branch', so let's get the trace_options dynamicly from the
trace_options file.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 .../ftrace_test/ftrace_stress/ftrace_trace_options.sh       | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
index 47d2a62..5efbcce 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
@@ -15,9 +15,15 @@
 
 LOOP=200
 
-trace_options=(print-parent sym-offset sym-addr verbose raw hex bin block trace_printk ftrace_preempt branch annotate userstacktrace sym-userobj printk-msg-only context-info latency-format sleep-time graph-time)
+option_files=$(ls $TRACING_PATH/options/)
 
-NR_TRACE_OPTIONS=19
+# enable the nop_test_refuse can cause an
+# 'write error: Invalid argument'. So don't
+# test it.
+option_files=${option_files/test_nop_refuse/}
+trace_options=( $option_files )
+
+NR_TRACE_OPTIONS=${#trace_options[*]}
 
 for ((; ; ))
 {
@@ -25,7 +31,6 @@ for ((; ; ))
 	{
 		num=`date +%N`
 		num=`printf 1%s $num`
-
 		for ((i = 0; i < $NR_TRACE_OPTIONS; i++))
 		{
 			n=$(( ( $num >> $i ) % 2 ))
@@ -34,9 +39,9 @@ for ((; ; ))
 			else
 				echo 1 > "$TRACING_PATH"/options/${trace_options[$i]}
 			fi
+			[ $? -ne 0 ] && echo "setup trace option ${trace_options[$i]} failed"
 		}
 	}
 
 	sleep 1
 }
-
-- 
1.8.3.1

