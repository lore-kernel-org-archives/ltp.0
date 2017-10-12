From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2017 17:33:38 +0200
Subject: [LTP] [RFC] [PATCH 2/2] syscalls: Make use of tst_strstatus()
In-Reply-To: <20171012153338.1233-1-chrubis@suse.cz>
References: <20171012153338.1233-1-chrubis@suse.cz>
Message-ID: <20171012153338.1233-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/cve/stack_clash.c                       |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify03.c   | 17 ++++-------------
 testcases/kernel/syscalls/madvise/madvise07.c     | 11 ++++++++---
 testcases/kernel/syscalls/madvise/madvise09.c     |  4 ++--
 testcases/kernel/syscalls/setrlimit/setrlimit04.c | 14 +++++---------
 5 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 49c45ef74..f25e19b3f 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -256,7 +256,7 @@ void stack_clash_test(void)
 		}
 	}
 
-	tst_brk(TBROK, "child did not exit gracefully");
+	tst_brk(TBROK, "Child %s", tst_strstatus(status));
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index ea5c02a7b..400042081 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -132,19 +132,10 @@ static void check_child(void)
 	}
 	SAFE_WAITPID(-1, &child_ret, 0);
 
-	if (WIFSIGNALED(child_ret)) {
-		tst_res(TFAIL, "child exited due to signal %d",
-			 WTERMSIG(child_ret));
-	} else if (WIFEXITED(child_ret)) {
-		if (WEXITSTATUS(child_ret) == 0)
-			tst_res(TPASS, "child exited correctly");
-		else
-			tst_res(TFAIL, "child exited with status %d",
-				 WEXITSTATUS(child_ret));
-	} else {
-		tst_res(TFAIL, "child exited for unknown reason (status %d)",
-			 child_ret);
-	}
+	if (WIFEXITED(child_ret) && WEXITSTATUS(child_ret) == 0)
+		tst_res(TPASS, "child exited correctly");
+	else
+		tst_res(TFAIL, "child %s", tst_strstatus(child_ret));
 }
 
 void test01(void)
diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
index ef9aa4a26..170642ada 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -91,10 +91,15 @@ static void run(void)
 	}
 
 	SAFE_WAITPID(pid, &status, 0);
-	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGBUS)
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGBUS) {
 		tst_res(TPASS, "Received SIGBUS after accessing poisoned page");
-	else if (WIFEXITED(status) && WEXITSTATUS(status) == TBROK)
-		tst_res(TBROK, "Child exited abnormally");
+		return;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		return;
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 7ad76f795..4e887f5db 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -305,8 +305,8 @@ retry:
 		goto retry;
 	}
 
-	if (WIFEXITED(status) && WEXITSTATUS(status))
-		tst_brk(TBROK, "Child exitted unexpectedly");
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		tst_brk(TBROK, "Child %s", tst_strstatus(status));
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit04.c b/testcases/kernel/syscalls/setrlimit/setrlimit04.c
index e366298a1..5b6c958c3 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit04.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit04.c
@@ -48,16 +48,12 @@ static void test_setrlimit(void)
 		SAFE_EXECLP("/bin/true", "/bin/true", NULL);
 	SAFE_WAITPID(child, &status, 0);
 
-	if (WIFEXITED(status)) {
-		if ((WEXITSTATUS(status) == 0))
-			tst_res(TPASS, "child process completed OK");
-		else
-			tst_res(TFAIL, "child process exited with %d",
-				WEXITSTATUS(status));
-	} else if (WIFSIGNALED(status)) {
-		tst_res(TFAIL, "child exited with signal %s",
-			tst_strsig(WTERMSIG(status)));
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		tst_res(TPASS, "child process completed OK");
+		return;
 	}
+
+	tst_res(TFAIL, "child %s", tst_strstatus(status));
 }
 
 static struct tst_test test = {
-- 
2.13.5

