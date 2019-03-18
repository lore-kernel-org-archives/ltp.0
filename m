From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Mar 2019 14:42:27 +0100
Subject: [LTP] [PATCH] lib/tst_checkpoint: Retry sleep on EINTR
Message-ID: <20190318134227.17385-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previously we haven't retried on EINTR, the main reason for that was
that all the tests using checkpoints haven't cared at all since signals
were not involved. However I think that retry on EINTR should be done by
default, since checkpoints returning from sleep on random signal
delivery are broken, and no test in the tree actually depends on such
behavior.

Currently tests for tgkill have emerged on ML where child needs to sleep
while parent sends signals to the child, this commit allows to use
checkpoints for these tests.

This commit implements the simpliest way how to retry, it's just a
simple loop over the futex() call that repeats on EINTR. The only side
effect is that timeout is restarted after the thread sleeping in futex()
got signal, since we use relative timeouts after all. However the
hypotetical worst case that can happen is that the test will timeout and
will end up being killed by the test library in a case that one test
would sleep on checkpoint while other would send signals in a loop.
Hoever chances for this arrangement are quite small.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Sumit Garg <sumit.garg@linaro.org>
CC: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_checkpoint.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 5455d0378..5e5b11496 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -85,6 +85,7 @@ void tst_checkpoint_init(const char *file, const int lineno,
 int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
 {
 	struct timespec timeout;
+	int ret;
 
 	if (id >= tst_max_futexes) {
 		errno = EOVERFLOW;
@@ -94,8 +95,12 @@ int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
 	timeout.tv_sec = msec_timeout/1000;
 	timeout.tv_nsec = (msec_timeout%1000) * 1000000;
 
-	return syscall(SYS_futex, &tst_futexes[id], FUTEX_WAIT,
-		       tst_futexes[id], &timeout);
+	do {
+		ret = syscall(SYS_futex, &tst_futexes[id], FUTEX_WAIT,
+			      tst_futexes[id], &timeout);
+	} while (ret == -1 && errno == EINTR);
+
+	return ret;
 }
 
 int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
-- 
2.19.2

