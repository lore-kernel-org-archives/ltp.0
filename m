From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 23 Jul 2020 19:12:05 +0530
Subject: [LTP] [PATCH 1/4] libs: sigwait: Use SAFE_FORK()
Message-ID: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use SAFE_FORK(), which also gets rid of a compilation warning for us.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 libs/libltpsigwait/sigwait.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
index 5fbcdebf1295..bb8d2dd05a30 100644
--- a/libs/libltpsigwait/sigwait.c
+++ b/libs/libltpsigwait/sigwait.c
@@ -356,10 +356,8 @@ void test_bad_address2(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 	pid_t pid;
 	int status;
 
-	switch (pid = fork()) {
-	case -1:
-		tst_brk(TBROK | TERRNO, "fork() failed");
-	case 0:
+	pid = SAFE_FORK();
+	if (pid == 0) {
 		signal(SIGSEGV, SIG_DFL);
 
 		/*
@@ -374,9 +372,6 @@ void test_bad_address2(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 		tst_res(TINFO | TTERRNO, "swi_func returned: %ld",
 			TST_RET);
 		_exit(1);
-		break;
-	default:
-		break;
 	}
 
 	SAFE_WAITPID(pid, &status, 0);
-- 
2.14.1

