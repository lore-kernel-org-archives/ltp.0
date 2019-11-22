From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 22 Nov 2019 10:40:00 +0100
Subject: [LTP] [PATCH 1/1] Fix TBROK usage in timer tests
Message-ID: <20191122094000.8799-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

timer_delete01, timer_settime01 and timer_settime02 incorrectly use
tst_res(TBROK, ...). Change it to tst_res(TFAIL, ...)

Also check errno for ENOTSUP and use tst_res(TCONF, ...) when the tested
functionality is not supported by kernel, including in timer_create01.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/timer_create/timer_create01.c      |  3 +--
 .../kernel/syscalls/timer_delete/timer_delete01.c      |  8 ++++----
 .../kernel/syscalls/timer_settime/timer_settime01.c    | 10 +++++-----
 .../kernel/syscalls/timer_settime/timer_settime02.c    |  8 ++++----
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_create/timer_create01.c b/testcases/kernel/syscalls/timer_create/timer_create01.c
index b03d184dd..1cb9a9fdc 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create01.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create01.c
@@ -82,8 +82,7 @@ static void run(unsigned int n)
 		if (TST_RET != 0) {
 			if (possibly_unsupported(clock) &&
 			    (TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
-				tst_res(TPASS | TTERRNO,
-					"%s unsupported, failed as expected",
+				tst_res(TCONF | TTERRNO, "%s unsupported",
 					get_clock_str(clock));
 			} else {
 				tst_res(TFAIL | TTERRNO,
diff --git a/testcases/kernel/syscalls/timer_delete/timer_delete01.c b/testcases/kernel/syscalls/timer_delete/timer_delete01.c
index 16e50ccec..962eb5670 100644
--- a/testcases/kernel/syscalls/timer_delete/timer_delete01.c
+++ b/testcases/kernel/syscalls/timer_delete/timer_delete01.c
@@ -37,12 +37,12 @@ static void run(void)
 
 		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer_id));
 		if (TST_RET != 0) {
-			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
-				tst_res(TPASS | TTERRNO,
-					"%s unsupported, failed as expected",
+			if (possibly_unsupported(clock) &&
+				(TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
+				tst_res(TCONF | TTERRNO, "%s unsupported",
 					get_clock_str(clock));
 			} else {
-				tst_res(TBROK | TTERRNO,
+				tst_res(TFAIL | TTERRNO,
 					"Aborting test - timer_create(%s) failed",
 					get_clock_str(clock));
 			}
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index fc1cf86a6..7bf00f527 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -60,12 +60,12 @@ static void run(unsigned int n)
 
 		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer));
 		if (TST_RET != 0) {
-			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
-				tst_res(TPASS | TTERRNO,
-					"%s unsupported, failed as expected",
+			if (possibly_unsupported(clock) &&
+				(TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
+				tst_res(TCONF | TTERRNO, "%s unsupported",
 					get_clock_str(clock));
 			} else {
-				tst_res(TBROK | TTERRNO,
+				tst_res(TFAIL | TTERRNO,
 					"timer_create(%s) failed",
 					get_clock_str(clock));
 			}
@@ -80,7 +80,7 @@ static void run(unsigned int n)
 
 		if (tc->flag & TIMER_ABSTIME) {
 			if (clock_gettime(clock, &timenow) < 0) {
-				tst_res(TBROK,
+				tst_res(TFAIL,
 					"clock_gettime(%s) failed - skipping the test",
 					get_clock_str(clock));
 				continue;
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime02.c b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
index 9b410a399..74cb33d73 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime02.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
@@ -73,12 +73,12 @@ static void run(unsigned int n)
 		/* Init temporary timer */
 		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer));
 		if (TST_RET != 0) {
-			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
-				tst_res(TPASS | TTERRNO,
-					"%s unsupported, failed as expected",
+			if (possibly_unsupported(clock) &&
+				(TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
+				tst_res(TCONF | TTERRNO, "%s unsupported",
 					get_clock_str(clock));
 			} else {
-				tst_res(TBROK | TTERRNO,
+				tst_res(TFAIL | TTERRNO,
 					"timer_create(%s) failed",
 					get_clock_str(clock));
 			}
-- 
2.24.0

