From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 19 Mar 2020 17:28:38 +0530
Subject: [LTP] [PATCH V2 1/2] syscalls/pidfd_send_signal: Move
 pidfd_send_signal.h to include/lapi/
In-Reply-To: <cover.1584618969.git.viresh.kumar@linaro.org>
References: <cover.1584618969.git.viresh.kumar@linaro.org>
Message-ID: <39538b9f5e6b271edfa202229b103b71626d17ab.1584618969.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move pidfd_send_signal.h to include/lapi/ to make it available for other
syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../lapi}/pidfd_send_signal.h                             | 8 ++------
 .../syscalls/pidfd_send_signal/pidfd_send_signal01.c      | 2 +-
 .../syscalls/pidfd_send_signal/pidfd_send_signal02.c      | 2 +-
 .../syscalls/pidfd_send_signal/pidfd_send_signal03.c      | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)
 rename {testcases/kernel/syscalls/pidfd_send_signal => include/lapi}/pidfd_send_signal.h (73%)

diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h b/include/lapi/pidfd_send_signal.h
similarity index 73%
rename from testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h
rename to include/lapi/pidfd_send_signal.h
index dc17fe058672..37de7ab401d0 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h
+++ b/include/lapi/pidfd_send_signal.h
@@ -10,17 +10,13 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-static void check_syscall_support(void)
-{
-	/* allow the tests to fail early */
-	tst_syscall(__NR_pidfd_send_signal);
-}
+/* allow the tests to fail early */
+#define check_syscall_support()		tst_syscall(__NR_pidfd_send_signal)
 
 #ifndef HAVE_PIDFD_SEND_SIGNAL
 static int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 				 unsigned int flags)
 {
-	tst_res(TINFO, "Testing syscall(__NR_pidfd_send_signal)");
 	return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
 }
 #endif /* HAVE_PIDFD_SEND_SIGNAL */
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
index 03a4ae9bea41..3137b6967371 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
@@ -12,8 +12,8 @@
 #define _GNU_SOURCE
 #include <signal.h>
 #include <stdlib.h>
+#include "lapi/pidfd_send_signal.h"
 #include "tst_safe_pthread.h"
-#include "pidfd_send_signal.h"
 
 #define SIGNAL  SIGUSR1
 #define DATA	777
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
index 74914523f0b8..610c67120a7a 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
@@ -24,8 +24,8 @@
 #define _GNU_SOURCE
 #include <pwd.h>
 #include <signal.h>
+#include "lapi/pidfd_send_signal.h"
 #include "tst_safe_pthread.h"
-#include "pidfd_send_signal.h"
 
 #define CORRECT_SIGNAL		SIGUSR1
 #define DIFFERENT_SIGNAL	SIGUSR2
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
index 3420afbb9526..7d65e6ddc543 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -19,7 +19,7 @@
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
-#include "pidfd_send_signal.h"
+#include "lapi/pidfd_send_signal.h"
 #include "tst_safe_pthread.h"
 
 #define PIDTRIES	3
-- 
2.21.0.rc0.269.g1a574e7a288b

