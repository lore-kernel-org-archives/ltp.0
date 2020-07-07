From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  7 Jul 2020 13:53:31 +0200
Subject: [LTP] [PATCH] [COMMITTED] lib/tst_clocks: Fix syscall detection
Message-ID: <20200707115331.15806-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have call raw syscall() instead of the tst_syscall() because
tst_sycall() exit the test with TCONF when kernel returned ENOSYS.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Tested-by: Li Wang <liwang@redhat.com>
---
 lib/tst_clocks.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index bc0bef273..7b465b1f6 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -14,11 +14,11 @@
 
 typedef int (*mysyscall)(clockid_t clk_id, void *ts);
 
-int syscall_supported_by_kernel(mysyscall func)
+int syscall_supported_by_kernel(long sysnr)
 {
 	int ret;
 
-	ret = func(0, NULL);
+	ret = syscall(sysnr, 0, NULL);
 	if (ret == -1 && errno == ENOSYS)
 		return 0;
 
@@ -32,13 +32,13 @@ int tst_clock_getres(clockid_t clk_id, struct timespec *res)
 	int ret;
 
 #if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
-	if (!func && syscall_supported_by_kernel(sys_clock_getres64)) {
+	if (!func && syscall_supported_by_kernel(__NR_clock_getres_time64)) {
 		func = sys_clock_getres64;
 		tts.type = TST_KERN_TIMESPEC;
 	}
 #endif
 
-	if (!func && syscall_supported_by_kernel(sys_clock_getres)) {
+	if (!func && syscall_supported_by_kernel(__NR_clock_getres)) {
 		func = sys_clock_getres;
 		tts.type = TST_KERN_OLD_TIMESPEC;
 	}
@@ -62,13 +62,13 @@ int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
 	int ret;
 
 #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	if (!func && syscall_supported_by_kernel(sys_clock_gettime64)) {
+	if (!func && syscall_supported_by_kernel(__NR_clock_gettime64)) {
 		func = sys_clock_gettime64;
 		tts.type = TST_KERN_TIMESPEC;
 	}
 #endif
 
-	if (!func && syscall_supported_by_kernel(sys_clock_gettime)) {
+	if (!func && syscall_supported_by_kernel(__NR_clock_gettime)) {
 		func = sys_clock_gettime;
 		tts.type = TST_KERN_OLD_TIMESPEC;
 	}
@@ -91,13 +91,13 @@ int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
 	static mysyscall func;
 
 #if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
-	if (!func && syscall_supported_by_kernel(sys_clock_settime64)) {
+	if (!func && syscall_supported_by_kernel(__NR_clock_settime64)) {
 		func = sys_clock_settime64;
 		tts.type = TST_KERN_TIMESPEC;
 	}
 #endif
 
-	if (!func && syscall_supported_by_kernel(sys_clock_settime)) {
+	if (!func && syscall_supported_by_kernel(__NR_clock_settime)) {
 		func = sys_clock_settime;
 		tts.type = TST_KERN_OLD_TIMESPEC;
 	}
-- 
2.26.2

