From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Aug 2016 16:45:08 +0200
Subject: [LTP] [PATCH] tst_test: Propagate SIGINT to test process
Message-ID: <20160804144508.GA8001@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since the test runs in separate process and separate process group
pressing Ctrl+C only sends SIGINT to the library process.

This commit adds SIGINT handler for the library process that kills the
whole test process group. The upside is that system resources allocated
in the library are cleaned up even in this case.

We also reset signal handlers in the test process after the fork now.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 1bd2619..cd5b049 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -724,6 +724,16 @@ static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
 	alarm(results->timeout);
 }
 
+#define SIGINT_MSG "Sending SIGKILL to test process...\n"
+
+static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	if (test_pid > 0) {
+		(void)write(2, SIGINT_MSG, sizeof(SIGINT_MSG) - 1);
+		kill(-test_pid, SIGKILL);
+	}
+}
+
 void tst_set_timeout(unsigned int timeout)
 {
 	char *mul = getenv("LTP_TIMEOUT_MUL");
@@ -767,18 +777,23 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	else
 		tst_set_timeout(300);
 
+	SAFE_SIGNAL(SIGINT, sigint_handler);
+
 	test_pid = fork();
 	if (test_pid < 0)
 		tst_brk(TBROK | TERRNO, "fork()");
 
 	if (!test_pid) {
+		SAFE_SIGNAL(SIGALRM, SIG_DFL);
+		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
+		SAFE_SIGNAL(SIGINT, SIG_DFL);
 		SAFE_SETPGID(0, 0);
 		testrun();
 	}
 
 	SAFE_WAITPID(test_pid, &status, 0);
-
 	alarm(0);
+	SAFE_SIGNAL(SIGINT, SIG_DFL);
 
 	if (WIFEXITED(status) && WEXITSTATUS(status))
 		do_exit(WEXITSTATUS(status));
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
