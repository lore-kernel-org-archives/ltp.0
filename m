From: Li Wang <liwang@redhat.com>
Date: Wed, 24 May 2017 10:16:27 +0800
Subject: [LTP] [PATCH] numa: fix memhog fails in test8
Message-ID: <20170524021627.8366-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

memhog test fails on first iteration (when the memhog binary is not
in the page cache) because the test script runs too fast and looks
at the statistics even befor the memmhog binary has a chance to run.

In this patch, just redirectiong the output to a file and then checking
the content in the script in a loop.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/numa01.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 4eda3f1..e3fe854 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -315,9 +315,20 @@ test8()
 	# Memory will be allocated using round robin on nodes.
 	Exp_incr=$(echo "$MB / $total_nodes" |bc)
 
-	numactl --interleave=all memhog -r1000000 1MB 2>&1 >/dev/null &
+	numactl --interleave=all memhog -r1000000 1MB 2>&1 >ltp_numa_test8.log &
 	pid=$!
 
+	local retries=20
+	while [ $retries -gt 0 ]; do
+
+		if grep -m1 -q '.' ltp_numa_test8.log; then
+			break
+		fi
+
+		retries=$((retries-1))
+		tst_sleep 50ms
+	done
+
 	for node in $nodes_list; do
 		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
 
-- 
2.9.3

