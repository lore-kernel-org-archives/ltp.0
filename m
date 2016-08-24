From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:53 +0300
Subject: [LTP] [PATCH V2 05/11] syscalls/waitpid: implement
	waitpid_ret_test()
In-Reply-To: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1472041679-29759-6-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Several test cases call waitpid() and then verify the returned
value and errno set. Moved this code into a function.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * Use TST_TRACE

 testcases/kernel/syscalls/waitpid/waitpid07.c      |    6 +---
 testcases/kernel/syscalls/waitpid/waitpid08.c      |   25 +---------------
 testcases/kernel/syscalls/waitpid/waitpid_common.h |   29 ++++++++++++++++++++
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid07.c b/testcases/kernel/syscalls/waitpid/waitpid07.c
index 47ebf9a..9166fbe 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid07.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid07.c
@@ -48,12 +48,8 @@ static void do_child_1(void)
 	}
 
 	/* Check that waitpid with WNOHANG returns zero */
-	pid = waitpid(-1, &status, WNOHANG);
-	if (pid != 0) {
-		tst_res(TFAIL, "waitpid() returned %d, expected 0",
-			pid);
+	if (TST_TRACE(waitpid_ret_test(-1, &status, WNOHANG, 0, 0)))
 		return;
-	}
 
 	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
diff --git a/testcases/kernel/syscalls/waitpid/waitpid08.c b/testcases/kernel/syscalls/waitpid/waitpid08.c
index b95a308..6c8d3b9 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid08.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid08.c
@@ -51,36 +51,15 @@ static void do_child_1(void)
 	/* Check that waitpid with WNOHANG|WUNTRACED returns
 	 * zero
 	 */
-	pid = waitpid(-1, &status, WNOHANG | WUNTRACED);
-	if (pid != 0) {
-		tst_res(TFAIL,
-			"waitpid(WNOHANG | WUNTRACED) returned %d, expected 0",
-			pid);
+	if (TST_TRACE(waitpid_ret_test(-1, &status, WNOHANG | WUNTRACED,
+				       0, 0)))
 		return;
-	}
 
 	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
 	if (TST_TRACE(reap_children(-1, WUNTRACED, fork_kid_pid, MAXKIDS)))
 		return;
 
-	/*
-	 * Check that waitpid(WUNTRACED) returns -1 when no
-	 * stopped children
-	 */
-	pid = waitpid(-1, &status, WUNTRACED);
-	if (pid != -1) {
-		tst_res(TFAIL, "waitpid(WUNTRACED) returned %d, expected -1",
-			pid);
-		return;
-	}
-
-	if (errno != ECHILD) {
-		tst_res(TFAIL, "waitpid(WUNTRACED) set errno %s, expected %s",
-			tst_strerrno(errno), tst_strerrno(ECHILD));
-		return;
-	}
-
 	tst_res(TPASS, "Test PASSED");
 }
 
diff --git a/testcases/kernel/syscalls/waitpid/waitpid_common.h b/testcases/kernel/syscalls/waitpid/waitpid_common.h
index 008577a..f5e9519 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid_common.h
+++ b/testcases/kernel/syscalls/waitpid/waitpid_common.h
@@ -75,6 +75,35 @@ static void do_exit(int stop)
 	exit(3);
 }
 
+static int waitpid_errno_check(int err, int exp_err)
+{
+	if (err != exp_err) {
+		tst_res(TFAIL, "waitpid() set errno to %s, expected %s",
+			tst_strerrno(err), tst_strerrno(exp_err));
+		return -1;
+	}
+
+	return 0;
+}
+
+int waitpid_ret_test(pid_t wp_pid, int *wp_status, int wp_opts,
+		     pid_t wp_ret, int wp_errno)
+{
+	pid_t ret;
+
+	ret = waitpid(wp_pid, wp_status, wp_opts);
+	if (ret != wp_ret) {
+		tst_res(TFAIL, "waitpid() returned %d, expected %d",
+			ret, wp_ret);
+		return -1;
+	}
+
+	if ((ret == -1) && waitpid_errno_check(errno, wp_errno))
+		return -1;
+
+	return 0;
+}
+
 static int reap_children(pid_t wp_pid, int wp_opts, pid_t *children, int len)
 {
 	pid_t pid;
-- 
1.7.1

