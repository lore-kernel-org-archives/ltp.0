From: Li Wang <liwang@redhat.com>
Date: Sat,  8 May 2021 13:51:09 +0800
Subject: [LTP] [PATCH v3 4/4] lib: reset SIGTERM to original disposition if
 timeout occured
Message-ID: <20210508055109.16914-5-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To limit the "kill $sleep_pid; exit" action only effect on the
sleep proccess will make code easy to understand.

Also, to get rid of below redundant behavior:
  ./../../../testcases/lib/tst_test.sh: line 1: kill: (242089) - No such process

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/lib/tst_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b6ca0cb26..28c2052d6 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -472,6 +472,7 @@ _tst_timeout_process()
 	sleep_pid=$!
 	trap "kill $sleep_pid; exit" TERM
 	wait $sleep_pid
+	trap - TERM
 	_tst_kill_test
 }
 
-- 
2.30.2

