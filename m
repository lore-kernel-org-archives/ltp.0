From: Alistair Strachan <astrachan@google.com>
Date: Fri, 22 Jun 2018 14:57:09 -0700
Subject: [LTP] [PATCH] {rt_, }sigsuspend01: Fix build for non-glibc platforms
In-Reply-To: <20180622215710.126661-1-astrachan@google.com>
References: <20180622215710.126661-1-astrachan@google.com>
Message-ID: <20180622215710.126661-3-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tests dig inside the sigset_t to check if the kernel reverted any
changes made to the signal mask. This is done by comparing the first
32 signal flag bits by dereferencing the sigset_t and reading __val[0],
which is an unsigned long. If the field is not called __val (with
Android's bionic it is called '__bits' instead) the build breaks.

Change the tests to use memcmp for the first sizeof(unsigned long) bits,
which should be equivalent. This makes the test more portable.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c | 4 +++-
 testcases/kernel/syscalls/sigsuspend/sigsuspend01.c       | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index 19e2eb66a..c8c228a47 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <signal.h>
 #include <errno.h>
+#include <string.h>
 
 #include "test.h"
 #include "lapi/syscalls.h"
@@ -91,7 +92,8 @@ int main(int ac, char **av)
 			if (TEST_RETURN == -1) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigprocmask failed");
-			} else if (set1.__val[0] != set2.__val[0]) {
+			} else if (memcmp(&set1, &set2,
+				   sizeof(unsigned long))) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigsuspend failed to "
 					 "preserve signal mask");
diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
index b9542e705..a846f6330 100644
--- a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
@@ -121,7 +121,8 @@ int main(int ac, char **av)
 				tst_resm(TFAIL, "sigprocmask() Failed "
 					 "to get previous signal mask "
 					 "of process");
-			} else if (sigset2.__val[0] != sigset1.__val[0]) {
+			} else if (memcmp(&sigset1, &sigset2,
+				   sizeof(unsigned long))) {
 				tst_resm(TFAIL, "sigsuspend failed to "
 					 "preserve signal mask");
 			} else {
