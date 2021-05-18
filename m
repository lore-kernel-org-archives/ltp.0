From: Li Wang <liwang@redhat.com>
Date: Tue, 18 May 2021 20:26:10 +0800
Subject: [LTP] [PATCH 2/2] tst_test: using SIGTERM to terminate process
In-Reply-To: <20210518122610.17171-1-liwang@redhat.com>
References: <20210518122610.17171-1-liwang@redhat.com>
Message-ID: <20210518122610.17171-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We'd better avoid using SIGINT for process terminating becuasue,
it has different behavoir on kind of shell.

From Joerg Vehlow's test:

 - bash does not seem to care about SIGINT delivery to background
   processes, but can be blocked using trap

 - zsh ignores SIGINT for background processes by default, but can be
   allowed using trap

 - dash and busybox sh ignore the signal to background processes, and
   this cannot be changed with trap

This patch cover the below situations:

 1. SIGINT (Ctrl^C) for terminating the main process and do cleanup
    correctly before a timeout

 2. Test finish normally and retrieves the _tst_timeout_process in the
    background via SIGTERM(sending by _tst_cleanup_timer)

 3. Test timed out occurs and _tst_kill_test sending SIGTERM to
    terminating all process, and the main process do cleanup work

 4. Test timed out occurs but still have process alive after _tst_kill_test
    sending SIGTERM, then sending SIGKILL to the whole group

 5. Test terminated by SIGTERM unexpectly (e.g. system shutdown or process
    manager) and do cleanup work as well

Co-authored-by: Joerg Vehlow <lkml@jv-coder.de>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/shell/test_timeout.sh | 2 +-
 lib/newlib_tests/shell/timeout03.sh    | 1 +
 testcases/lib/tst_test.sh              | 9 +++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/newlib_tests/shell/test_timeout.sh b/lib/newlib_tests/shell/test_timeout.sh
index b05680cb1..9f31afa32 100755
--- a/lib/newlib_tests/shell/test_timeout.sh
+++ b/lib/newlib_tests/shell/test_timeout.sh
@@ -28,7 +28,7 @@ timeout02.sh|  -10|0|  |2
 timeout02.sh| -0.1|0|  |0
 timeout02.sh| -1.1|0|  |2
 timeout02.sh|-10.1|0|  |2
-timeout03.sh|     |0|12|137| | | |Test kill if test does not terminate by SIGINT
+timeout03.sh|     |0|12|137| | | |Test kill if test does not terminate by SIGTERM
 timeout04.sh|     |0|  |  2|0|0|1|Verify that timeout is enforced
 timeout02.sh|    2|1| 2|   |1|0|0|Test termination of timeout process
 "
diff --git a/lib/newlib_tests/shell/timeout03.sh b/lib/newlib_tests/shell/timeout03.sh
index cd548d9a2..124e96a84 100755
--- a/lib/newlib_tests/shell/timeout03.sh
+++ b/lib/newlib_tests/shell/timeout03.sh
@@ -30,6 +30,7 @@ TST_TIMEOUT=1
 
 do_test()
 {
+	trap "tst_res TINFO 'Sorry, timeout03 is still alive'" TERM
 	tst_res TINFO "testing killing test after TST_TIMEOUT"
 
 	sleep 2
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 3a5651c01..66ffde4eb 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -21,7 +21,8 @@ export TST_LIB_LOADED=1
 . tst_security.sh
 
 # default trap function
-trap "tst_brk TBROK 'test interrupted or timed out'" INT
+trap "tst_brk TBROK 'test interrupted'" INT
+trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
 
 _tst_do_exit()
 {
@@ -439,9 +440,9 @@ _tst_kill_test()
 {
 	local i=10
 
-	trap '' INT
-	tst_res TBROK "Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
-	kill -INT -$pid
+	trap '' TERM
+	tst_res TBROK "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
+	kill -TERM -$pid
 	tst_sleep 100ms
 
 	while kill -0 $pid >/dev/null 2>&1 && [ $i -gt 0 ]; do
-- 
2.31.1

