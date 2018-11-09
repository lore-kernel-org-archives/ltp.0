From: Steve Muckle <smuckle@google.com>
Date: Thu,  8 Nov 2018 17:46:15 -0800
Subject: [LTP] [PATCH 1/2] syscalls/rt_sigsuspend01: ignore reserved signals
Message-ID: <20181109014616.165281-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some signals may be internally used by the C library. Do not attempt to
verify these.

Change-Id: Ia5b8148c9273b9d13001b07824e9d55680382519
---
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c      | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index c8c228a47..edc913b44 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -87,19 +87,22 @@ int main(int ac, char **av)
 			SIGSETSIZE));
 		TEST(alarm(0));
 		if (result == -1 && TEST_ERRNO != EINTR) {
+			int i;
 			TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0,
 				&set2, SIGSETSIZE));
-			if (TEST_RETURN == -1) {
+			if (TEST_RETURN == -1)
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigprocmask failed");
-			} else if (memcmp(&set1, &set2,
-				   sizeof(unsigned long))) {
-				tst_brkm(TFAIL | TTERRNO, cleanup,
+			for (i = 1; i < SIGRTMAX; i++) {
+				if (i >= __SIGRTMIN && i < SIGRTMIN)
+					continue;
+				if (sigismember(&set1, i) !=
+				    sigismember(&set2, i))
+					tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigsuspend failed to "
 					 "preserve signal mask");
-			} else {
-				tst_resm(TPASS, "rt_sigsuspend PASSED");
 			}
+			tst_resm(TPASS, "rt_sigsuspend PASSED");
 		} else {
 			tst_resm(TFAIL | TTERRNO, "rt_sigsuspend failed");
 		}
-- 
2.19.1.930.g4563a0d9d0-goog

