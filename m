From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:24 +0530
Subject: [LTP] [PATCH 11/16] syscalls: sendmmsg: Reuse struct time64_variants
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <9282311ec60bb1bb2181e79d14336d26d3f073d0.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
index 54febf661530..d6a717687ee7 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <sys/types.h>
 
+#include "time64_variants.h"
 #include "tst_test.h"
 #include "lapi/socket.h"
 #include "tst_safe_macros.h"
@@ -24,32 +25,25 @@ static int receive_sockfd;
 static struct mmsghdr *snd_msg, *rcv_msg;
 static struct iovec *snd1, *snd2, *rcv1, *rcv2;
 
-static struct test_variants {
-	int (*receive)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
-		       unsigned int flags, void *timeout);
-	int (*send)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
-		    unsigned int flags);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .receive = libc_recvmmsg, .send = libc_sendmmsg, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .recvmmsg = libc_recvmmsg, .sendmmsg = libc_sendmmsg, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_recvmmsg != __LTP__NR_INVALID_SYSCALL)
-	{ .receive = sys_recvmmsg, .send = sys_sendmmsg, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .recvmmsg = sys_recvmmsg, .sendmmsg = sys_sendmmsg, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_recvmmsg_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .receive = sys_recvmmsg64, .send = sys_sendmmsg, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .recvmmsg = sys_recvmmsg64, .sendmmsg = sys_sendmmsg, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct tst_ts timeout;
 	int retval;
 
-	retval = tv->send(send_sockfd, snd_msg, VLEN, 0);
+	retval = tv->sendmmsg(send_sockfd, snd_msg, VLEN, 0);
 	if (retval < 0 || snd_msg[0].msg_len != 6 || snd_msg[1].msg_len != 6) {
 		tst_res(TFAIL | TERRNO, "sendmmsg() failed");
 		return;
@@ -58,11 +52,11 @@ static void run(void)
 	memset(rcv1->iov_base, 0, rcv1->iov_len);
 	memset(rcv2->iov_base, 0, rcv2->iov_len);
 
-	timeout.type = tv->type;
+	timeout.type = tv->ts_type;
 	tst_ts_set_sec(&timeout, 1);
 	tst_ts_set_nsec(&timeout, 0);
 
-	retval = tv->receive(receive_sockfd, rcv_msg, VLEN, 0, tst_ts_get(&timeout));
+	retval = tv->recvmmsg(receive_sockfd, rcv_msg, VLEN, 0, tst_ts_get(&timeout));
 
 	if (retval == -1) {
 		tst_res(TFAIL | TERRNO, "recvmmsg() failed");
-- 
2.25.0.rc1.19.g042ed3e048af

