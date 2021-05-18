From: Li Wang <liwang@redhat.com>
Date: Tue, 18 May 2021 20:26:09 +0800
Subject: [LTP] [PATCH 1/2] tst_test: discard the stderr output
Message-ID: <20210518122610.17171-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    We can merge this before the new release.

 testcases/lib/tst_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 28c2052d6..3a5651c01 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -444,13 +444,13 @@ _tst_kill_test()
 	kill -INT -$pid
 	tst_sleep 100ms
 
-	while kill -0 $pid 2>&1 > /dev/null && [ $i -gt 0 ]; do
+	while kill -0 $pid >/dev/null 2>&1 && [ $i -gt 0 ]; do
 		tst_res TINFO "Test is still running, waiting ${i}s"
 		sleep 1
 		i=$((i-1))
 	done
 
-	if kill -0 $pid 2>&1 > /dev/null; then
+	if kill -0 $pid >/dev/null 2>&1; then
 		tst_res TBROK "Test still running, sending SIGKILL"
 		kill -KILL -$pid
 	fi
-- 
2.31.1

