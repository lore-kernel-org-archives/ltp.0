From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  2 Feb 2021 16:34:52 +0300
Subject: [LTP] [PATCH 1/3] lib/tst_net.sh: print all netstress results in
 tst_netload()
In-Reply-To: <20210202133454.59224-1-alexey.kodanev@oracle.com>
References: <20210202133454.59224-1-alexey.kodanev@oracle.com>
Message-ID: <20210202133454.59224-2-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This helps during debugging when you need to see from which
dataset the final result was obtained (mean).

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ef9354903..f1a498306 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -710,7 +710,7 @@ tst_netload()
 	tst_rhost_run -c "pkill -9 netstress\$"
 	rm -f tst_netload.log
 
-	local res=0
+	local results
 	local passed=0
 
 	for i in $(seq 1 $run_cnt); do
@@ -751,7 +751,7 @@ tst_netload()
 		[ ! -f $rfile ] && \
 			tst_netload_brk TFAIL "can't read $rfile"
 
-		res="$((res + $(cat $rfile)))"
+		results="$results $(cat $rfile)"
 		passed=$((passed + 1))
 	done
 
@@ -761,10 +761,14 @@ tst_netload()
 		tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
 	fi
 
-	res=$((res / $passed))
-	echo "$res" > $rfile
+	local mean res_sum
+	for r in $results; do
+		res_sum="$((res_sum + r))"
+	done
+	mean=$((res_sum / passed))
+	echo "$mean" > $rfile
 
-	tst_res_ TPASS "netstress passed, mean time '$res' ms"
+	tst_res_ TPASS "netstress passed, mean time $mean ms, data:$results"
 
 	return $ret
 }
-- 
2.25.1

