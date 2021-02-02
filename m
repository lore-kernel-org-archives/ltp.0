From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  2 Feb 2021 16:34:54 +0300
Subject: [LTP] [PATCH 3/3] lib/tst_net.sh: calc median instead of mean in
 tst_netload()
In-Reply-To: <20210202133454.59224-1-alexey.kodanev@oracle.com>
References: <20210202133454.59224-1-alexey.kodanev@oracle.com>
Message-ID: <20210202133454.59224-4-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sometimes the tests can get the following results on a test network:

gre01   1 TINFO: run server 'netstress -D ltp_v0...
gre01   1 TINFO: run client 'netstress -l -D ltp_v0... 5 times
gre01   1 TPASS: netstress passed, mean time 4633 ms, data: 128 22627 134 142 137
...
vxlan03 1 TINFO: run server 'netstress -D ltp_v0...
vxlan03 1 TINFO: run client 'netstress -l -D ltp_v0... 5 times
vxlan03 1 TPASS: netstress passed, mean time 4584 ms, data: 142 140 146 145 22350

One unsuccessful run can have a huge impact on the final result,
when using the mean time with such data.

A more suitable solution for short runs would be to obtain a median
time that can remove all outliers. This will lead to more consistent
performance test results. For example, instead of the above runs, we
would get this:

gre01   1 TPASS: netstress passed, median time 137 ms, data: 128 22627 134 142 137
vxlan03 1 TPASS: netstress passed, median time 145 ms, data: 142 140 146 145 22350

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index f1a498306..ca21fe326 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -761,14 +761,10 @@ tst_netload()
 		tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
 	fi
 
-	local mean res_sum
-	for r in $results; do
-		res_sum="$((res_sum + r))"
-	done
-	mean=$((res_sum / passed))
-	echo "$mean" > $rfile
+	local median=$(tst_get_median $results)
+	echo "$median" > $rfile
 
-	tst_res_ TPASS "netstress passed, mean time $mean ms, data:$results"
+	tst_res_ TPASS "netstress passed, median time $median ms, data:$results"
 
 	return $ret
 }
-- 
2.25.1

