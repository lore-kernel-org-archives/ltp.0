From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:41 -0700
Subject: [LTP] [PATCH V3 08/23] rt_sigaction/rt_sigprocmark: Replace
	SA_NOMASK with SA_NODEFER
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-8-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes musl build failure e.g.
error: 'SA_NOMASK' undeclared here (not in a function)

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c | 4 ++--
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c | 5 ++---
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c | 4 ++--
 testcases/kernel/syscalls/sigaction/sigaction02.c       | 2 +-
 testcases/misc/crash/crash01.c                          | 4 ++--
 testcases/misc/crash/crash02.c                          | 3 +--
 6 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 5cf89cc..e07b974 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -57,10 +57,10 @@ static void setup(void)
 
 static int test_flags[] =
     { SA_RESETHAND | SA_SIGINFO, SA_RESETHAND, SA_RESETHAND | SA_SIGINFO,
-SA_RESETHAND | SA_SIGINFO, SA_NOMASK };
+SA_RESETHAND | SA_SIGINFO, SA_NODEFER };
 char *test_flags_list[] =
     { "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND", "SA_RESETHAND|SA_SIGINFO",
-"SA_RESETHAND|SA_SIGINFO", "SA_NOMASK" };
+"SA_RESETHAND|SA_SIGINFO", "SA_NODEFER" };
 
 static void handler(int sig)
 {
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index a1da743..594b260 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -23,7 +23,6 @@
 /* Description: This tests the rt_sigaction() syscall                         */
 /*		rt_sigaction Expected EFAULT error check                      */
 /******************************************************************************/
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -55,10 +54,10 @@ void setup(void)
 
 static int test_flags[] =
     { SA_RESETHAND | SA_SIGINFO, SA_RESETHAND, SA_RESETHAND | SA_SIGINFO,
-SA_RESETHAND | SA_SIGINFO, SA_NOMASK };
+SA_RESETHAND | SA_SIGINFO, SA_NODEFER };
 char *test_flags_list[] =
     { "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND", "SA_RESETHAND|SA_SIGINFO",
-"SA_RESETHAND|SA_SIGINFO", "SA_NOMASK" };
+"SA_RESETHAND|SA_SIGINFO", "SA_NODEFER" };
 
 static struct test_case_t {
 	int exp_errno;
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 175d220..991c87f 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -55,10 +55,10 @@ static void setup(void)
 
 static int test_flags[] =
     { SA_RESETHAND | SA_SIGINFO, SA_RESETHAND, SA_RESETHAND | SA_SIGINFO,
-SA_RESETHAND | SA_SIGINFO, SA_NOMASK };
+SA_RESETHAND | SA_SIGINFO, SA_NODEFER };
 char *test_flags_list[] =
     { "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND", "SA_RESETHAND|SA_SIGINFO",
-"SA_RESETHAND|SA_SIGINFO", "SA_NOMASK" };
+"SA_RESETHAND|SA_SIGINFO", "SA_NODEFER" };
 
 static struct test_case_t {
 	int exp_errno;
diff --git a/testcases/kernel/syscalls/sigaction/sigaction02.c b/testcases/kernel/syscalls/sigaction/sigaction02.c
index 641a04e..8641bfc 100644
--- a/testcases/kernel/syscalls/sigaction/sigaction02.c
+++ b/testcases/kernel/syscalls/sigaction/sigaction02.c
@@ -91,7 +91,7 @@ int set_handler(int sig, int sig_to_mask, int flag)
 
 	if (flag == 0) {
 		sa.sa_sigaction = (void *)handler;
-		sa.sa_flags = SA_NOMASK;
+		sa.sa_flags = SA_NODEFER;
 		sigemptyset(&sa.sa_mask);
 		sigaddset(&sa.sa_mask, sig_to_mask);
 		err = sigaction(sig, &sa, NULL);
diff --git a/testcases/misc/crash/crash01.c b/testcases/misc/crash/crash01.c
index 0574521..614b7e8 100644
--- a/testcases/misc/crash/crash01.c
+++ b/testcases/misc/crash/crash01.c
@@ -49,7 +49,7 @@ stress test at the same time you run other tests, like a multi-user
 benchmark.
 
 */
-
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -409,7 +409,7 @@ void my_signal(int sig, void (*func) ())
 
 	act.sa_handler = func;
 	memset(&act.sa_mask, 0x00, sizeof(sigset_t));
-	act.sa_flags = SA_NOMASK | SA_RESTART;
+	act.sa_flags = SA_NODEFER | SA_RESTART;
 	sigaction(sig, &act, 0);
 }
 
diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index 00fee34..1aba3b9 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -49,7 +49,6 @@ TODO:
 	* Does a syscall is supposed to send SIGSEGV?
 */
 
-#define _GNU_SOURCE
 #include <sys/syscall.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -358,7 +357,7 @@ void my_signal(int sig, void (*func) ())
 
 	act.sa_handler = func;
 	memset(&act.sa_mask, 0x00, sizeof(sigset_t));
-	act.sa_flags = SA_NOMASK | SA_RESTART;
+	act.sa_flags = SA_NODEFER | SA_RESTART;
 	sigaction(sig, &act, 0);
 }
 
-- 
2.9.0

