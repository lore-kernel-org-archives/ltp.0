From: zhe.he@windriver.com <zhe.he@windriver.com>
Date: Fri, 23 Aug 2019 15:08:41 +0800
Subject: [LTP] [PATCH] syscalls: rt_sigwaitinfo01: Fix failure for MIPS
 arches
Message-ID: <1566544121-147769-1-git-send-email-zhe.he@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: He Zhe <zhe.he@windriver.com>

rt_sigtimedwait01 fails as follow on MIPS arches
rt_sigtimedwait01    1  TFAIL  :  .../sigwaitinfo01.c:58: test_empty_set
(.../sigwaitinfo01.c: 148): Unexpected failure:
TEST_ERRNO=EINVAL(22): Invalid argument

As this case purposely bypasses glibc, it should align with the size of kernel
definition of sigset_t which is different from other arches.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/uapi/asm/signal.h#n15

This patch adds specific case for MIPS.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 5a32ce1..5c2fa99 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -128,9 +128,16 @@ static int my_sigtimedwait(const sigset_t * set, siginfo_t * info,
 static int my_rt_sigtimedwait(const sigset_t * set, siginfo_t * info,
 			      struct timespec *timeout)
 {
-
-	/* The last argument is (number_of_signals)/(bits_per_byte), which are 64 and 8, resp. */
-	return ltp_syscall(__NR_rt_sigtimedwait, set, info, timeout, 8);
+	/* The last argument is (number_of_signals)/(bits_per_byte), which are 64 and 8, resp,
+	 * except for MIPS which are 128 and 8, resp.
+	 */
+	return ltp_syscall(__NR_rt_sigtimedwait, set, info, timeout,
+#ifdef __mips__
+		16
+#else
+		8
+#endif
+		);
 }
 #endif
 
-- 
2.7.4

