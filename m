From: zhe.he@windriver.com <zhe.he@windriver.com>
Date: Thu, 29 Aug 2019 21:09:46 +0800
Subject: [LTP] [PATCH v2] syscall: rt_sigtimedwait01: Fix wrong sigset
 length for mips
Message-ID: <1567084186-417234-1-git-send-email-zhe.he@windriver.com>
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

This patch turns to use _NSIG which is always right for all arches.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v2: Use _NSIG/8 instead of fixed numbers

 testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 5a32ce1..6a30c27 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -128,9 +128,8 @@ static int my_sigtimedwait(const sigset_t * set, siginfo_t * info,
 static int my_rt_sigtimedwait(const sigset_t * set, siginfo_t * info,
 			      struct timespec *timeout)
 {
-
-	/* The last argument is (number_of_signals)/(bits_per_byte), which are 64 and 8, resp. */
-	return ltp_syscall(__NR_rt_sigtimedwait, set, info, timeout, 8);
+	/* _NSIG is always the right number of bits of signal map for all arches */
+	return ltp_syscall(__NR_rt_sigtimedwait, set, info, timeout, _NSIG/8);
 }
 #endif
 
-- 
2.7.4

