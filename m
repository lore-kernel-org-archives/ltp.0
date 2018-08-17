From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 17 Aug 2018 10:39:01 +0800
Subject: [LTP] [PATCH v2] syscall/signalfd01: Fix compiler warnings
In-Reply-To: <20180816115434.GB6547@rei>
References: <20180816115434.GB6547@rei>
Message-ID: <1534473541-8372-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/signalfd/signalfd01.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index 9859524..72901ff 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -76,7 +76,7 @@ int TST_TOTAL = 1;
 #endif
 
 #ifdef USE_STUB
-int main(int argc, char **argv)
+int main(void)
 {
 	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
 }
@@ -94,7 +94,7 @@ int signalfd(int fd, const sigset_t * mask, int flags)
 void cleanup(void);
 void setup(void);
 
-int do_test1(int ntst, int sig)
+int do_test1(uint32_t sig)
 {
 	int sfd_for_next;
 	int sfd;
@@ -145,7 +145,7 @@ int do_test1(int ntst, int sig)
 	if ((s > 0) && (s != sizeof(struct signalfd_siginfo))) {
 		tst_resm(TFAIL,
 			 "getting incomplete signalfd_siginfo data: "
-			 "actual-size=%" PRId32 ", expected-size=%" PRId32,
+			 "actual-size=%zd, expected-size=%zu",
 			 s, sizeof(struct signalfd_siginfo));
 		sfd_for_next = -1;
 		close(sfd);
@@ -187,7 +187,7 @@ out:
 	return sfd_for_next;
 }
 
-void do_test2(int ntst, int fd, int sig)
+void do_test2(int fd, uint32_t sig)
 {
 	int sfd;
 	sigset_t mask;
@@ -235,7 +235,7 @@ void do_test2(int ntst, int fd, int sig)
 	if ((s > 0) && (s != sizeof(struct signalfd_siginfo))) {
 		tst_resm(TFAIL,
 			 "getting incomplete signalfd_siginfo data: "
-			 "actual-size=%" PRId32 ", expected-size= %" PRId32,
+			 "actual-size=%zd, expected-size= %zu",
 			 s, sizeof(struct signalfd_siginfo));
 		goto out;
 	} else if (s < 0) {
@@ -285,11 +285,11 @@ int main(int argc, char **argv)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		sfd = do_test1(lc, SIGUSR1);
+		sfd = do_test1(SIGUSR1);
 		if (sfd < 0)
 			continue;
 
-		do_test2(lc, sfd, SIGUSR2);
+		do_test2(sfd, SIGUSR2);
 		close(sfd);
 	}
 
-- 
1.8.3.1



