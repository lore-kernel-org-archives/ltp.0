From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Sep 2016 17:24:10 +0200
Subject: [LTP] [PATCH V2 1/6] memcg_lib.sh: Print test number at test start
Message-ID: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Given that some of the testcases report more than one TPASS/TFAIL you
cannot easily tell from the log which exact testcase has failed/passed.

This commit fixes that by adding "Starting test $i" TINFO message into
the loop that executes the testcases.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index c71a41b..352960b 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -476,6 +476,9 @@ setup_test()
 run_tests()
 {
 	for i in $(seq 1 $TST_TOTAL); do
+
+		tst_resm TINFO "Starting test $i"
+
 		setup_test $i
 
 		if [ -e memory.memsw.limit_in_bytes ]; then
-- 
2.7.3

