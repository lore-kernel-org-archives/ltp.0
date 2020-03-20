From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 20 Mar 2020 09:54:01 +0530
Subject: [LTP] [PATCH V3 1/2] syscalls/pidfd_send_signal: Move
 pidfd_send_signal.h to include/lapi/
In-Reply-To: <cover.1584677993.git.viresh.kumar@linaro.org>
References: <cover.1584677993.git.viresh.kumar@linaro.org>
Message-ID: <850a05d5fca922cbc09b06eb99c9724bdbbe0bc4.1584677993.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move pidfd_send_signal.h to include/lapi/ to make it available for other
syscall tests.

While at it, also rename check_syscall_support() to
pidfd_send_signal_supported().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../pidfd_send_signal => include/lapi}/pidfd_send_signal.h    | 3 +--
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c   | 4 ++--
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c   | 4 ++--
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c   | 4 ++--
 4 files changed, 7 insertions(+), 8 deletions(-)
 rename {testcases/kernel/syscalls/pidfd_send_signal => include/lapi}/pidfd_send_signal.h (85%)

diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h b/include/lapi/pidfd_send_signal.h
similarity index 85%
rename from testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h
rename to include/lapi/pidfd_send_signal.h
index dc17fe058672..8352d2adf787 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h
+++ b/include/lapi/pidfd_send_signal.h
@@ -10,7 +10,7 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-static void check_syscall_support(void)
+static inline void pidfd_send_signal_supported(void)
 {
 	/* allow the tests to fail early */
 	tst_syscall(__NR_pidfd_send_signal);
@@ -20,7 +20,6 @@ static void check_syscall_support(void)
 static int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 				 unsigned int flags)
 {
-	tst_res(TINFO, "Testing syscall(__NR_pidfd_send_signal)");
 	return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
 }
 #endif /* HAVE_PIDFD_SEND_SIGNAL */
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
index 03a4ae9bea41..4cb5df94c425 100644
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
@@ -69,7 +69,7 @@ static void verify_pidfd_send_signal(void)
 
 static void setup(void)
 {
-	check_syscall_support();
+	pidfd_send_signal_supported();
 
 	pidfd = SAFE_OPEN("/proc/self", O_DIRECTORY | O_CLOEXEC);
 
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
index 74914523f0b8..1e62b417f29f 100644
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
@@ -68,7 +68,7 @@ static void setup(void)
 {
 	struct passwd *pw;
 
-	check_syscall_support();
+	pidfd_send_signal_supported();
 
 	pidfd = SAFE_OPEN("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	init_pidfd = SAFE_OPEN("/proc/1", O_DIRECTORY | O_CLOEXEC);
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
index 3420afbb9526..0903d67076aa 100644
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
@@ -111,7 +111,7 @@ static void verify_pidfd_send_signal(void)
 
 static void setup(void)
 {
-	check_syscall_support();
+	pidfd_send_signal_supported();
 
 	last_pid_file = "/proc/sys/kernel/ns_last_pid";
 	if (access(last_pid_file, F_OK) == -1) {
-- 
2.21.0.rc0.269.g1a574e7a288b

