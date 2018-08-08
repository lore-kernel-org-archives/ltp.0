From: Sandeep Patil <sspatil@google.com>
Date: Wed,  8 Aug 2018 16:40:19 -0700
Subject: [LTP] [PATCH] tracing: ftrace_lib: check if tracing_max_latency
	exists.
Message-ID: <20180808234019.241238-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This avoids unnecessary error in ftrace stress test when the
kernel being tested does not have CONFIG_TRACER_MAX_TRACE defined.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
index 20cf5e760..ec4f7a557 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
@@ -100,7 +100,9 @@ restore_old_setting()
 
 	echo nop > current_tracer
 	echo 0 > events/enable
-	echo 0 > tracing_max_latency 2> /dev/null
+	if [ -e tracing_max_latency ]; then
+		echo 0 > tracing_max_latency 2> /dev/null
+	fi
 
 	if [ -e tracing_cpumask ]; then
 		echo $old_tracing_cpumask > tracing_cpumask
-- 
2.18.0.597.ga71716f1ad-goog

