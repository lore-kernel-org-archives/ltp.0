From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jan 2021 14:29:11 +0100
Subject: [LTP] [PATCH] syscalls: epoll_pwait01: Work around a race
Message-ID: <20210112132911.4031-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There was a race that would manifest on slower machines.

The call to epoll_pwait() could time out before the child has chance to
run, and that would cause the signal to be sent to the parent when it
was already sleeping in wait().

Ideally the whole test should be rewritten into new library and fixed
properly, however as we are just before a release this is an attempt for
a minimal fix.

The logic in the test is changed so that:

- epoll_wait() sleeps indefinitely
- the child:
  - waits for the parent to get asleep
  - sends the signal
  - sleeps
  - writes to the pipe

This causes the child to actually run, while the parent is blocked in
the epoll_wait(), which greatly increases the changes of the signal
arriving at the right time.

Fixes: #765

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
index ed05da8fe..1f08112ad 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -121,8 +121,8 @@ static void verify_sigmask(void)
 		return;
 	}
 
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL, "epoll_pwait() returned %li, expected 0",
+	if (TEST_RETURN != 1) {
+		tst_resm(TFAIL, "epoll_pwait() returned %li, expected 1",
 			 TEST_RETURN);
 		return;
 	}
@@ -153,6 +153,7 @@ static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 static void do_test(sigset_t *sigmask)
 {
 	pid_t cpid;
+	char b;
 
 	cpid = tst_fork();
 	if (cpid < 0)
@@ -161,13 +162,15 @@ static void do_test(sigset_t *sigmask)
 	if (cpid == 0)
 		do_child();
 
-	TEST(epoll_pwait(epfd, &epevs, 1, 100, sigmask));
+	TEST(epoll_pwait(epfd, &epevs, 1, -1, sigmask));
 
 	if (sigmask != NULL)
 		verify_sigmask();
 	else
 		verify_nonsigmask();
 
+	SAFE_READ(cleanup, 1, fds[0], &b, 1);
+
 	tst_record_childstatus(cleanup, cpid);
 }
 
@@ -179,6 +182,8 @@ static void do_child(void)
 	}
 
 	SAFE_KILL(cleanup, getppid(), SIGUSR1);
+	usleep(10000);
+	SAFE_WRITE(cleanup, 1, fds[1], "w", 1);
 
 	cleanup();
 	tst_exit();
-- 
2.26.2

