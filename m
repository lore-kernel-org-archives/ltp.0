From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri,  8 May 2020 09:53:56 +0530
Subject: [LTP] [PATCH V2 11/17] syscalls/recvmmsg: Add support for time64
 tests
In-Reply-To: <cover.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <a0d6380383512736f7d72ebd3ca896545a60a2cb.1588911607.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing recvmmsg() syscall
tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 45 +++++++++++----
 .../kernel/syscalls/sendmmsg/sendmmsg_var.h   | 55 ++++++++-----------
 2 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
index 37084102ee09..5d1fd1b6b9fa 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
@@ -14,8 +14,8 @@
 #include "tst_test.h"
 #include "lapi/socket.h"
 #include "tst_safe_macros.h"
-
 #include "sendmmsg_var.h"
+#include "lapi/abisize.h"
 
 #define BUFSIZE 16
 #define VLEN 2
@@ -25,27 +25,52 @@ static int receive_sockfd;
 static struct mmsghdr *snd_msg, *rcv_msg;
 static struct iovec *snd1, *snd2, *rcv1, *rcv2;
 
+static struct test_variants {
+	int (*receive)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
+		       unsigned int flags, void *timeout);
+	int (*send)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
+		    unsigned int flags);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .receive = libc_recvmmsg, .send = libc_sendmmsg, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+	{ .receive = sys_recvmmsg, .send = sys_sendmmsg, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .receive = sys_recvmmsg, .send = sys_sendmmsg, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .receive = sys_recvmmsg, .send = sys_sendmmsg, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_recvmmsg_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .receive = sys_recvmmsg64, .send = sys_sendmmsg, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void run(void)
 {
-	struct timespec timeout;
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts timeout;
 	int retval;
 
-	retval = do_sendmmsg(send_sockfd, snd_msg, VLEN, 0);
+	retval = tv->send(send_sockfd, snd_msg, VLEN, 0);
 	if (retval < 0 || snd_msg[0].msg_len != 6 || snd_msg[1].msg_len != 6) {
-		tst_res(TFAIL|TTERRNO, "sendmmsg failed");
+		tst_res(TFAIL|TTERRNO, "sendmmsg() failed");
 		return;
 	}
 
 	memset(rcv1->iov_base, 0, rcv1->iov_len);
 	memset(rcv2->iov_base, 0, rcv2->iov_len);
 
-	timeout.tv_sec = 1;
-	timeout.tv_nsec = 0;
+	timeout.type = tv->type;
+	tst_ts_set_sec(&timeout, 1);
+	tst_ts_set_nsec(&timeout, 0);
 
-	retval = do_recvmmsg(receive_sockfd, rcv_msg, VLEN, 0, &timeout);
+	retval = tv->receive(receive_sockfd, rcv_msg, VLEN, 0, tst_ts_get(&timeout));
 
 	if (retval == -1) {
-		tst_res(TFAIL | TTERRNO, "recvmmsg failed");
+		tst_res(TFAIL | TTERRNO, "recvmmsg() failed");
 		return;
 	}
 	if (retval != 2) {
@@ -96,7 +121,7 @@ static void setup(void)
 	rcv_msg[1].msg_hdr.msg_iov = rcv2;
 	rcv_msg[1].msg_hdr.msg_iovlen = 1;
 
-	test_info();
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
 static void cleanup(void)
@@ -111,7 +136,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = ARRAY_SIZE(variants),
 	.bufs = (struct tst_buffers []) {
 		{&snd1, .iov_sizes = (int[]){3, 3, -1}},
 		{&snd2, .iov_sizes = (int[]){6, -1}},
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h b/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h
index f00cf056a747..a142b17f9718 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h
@@ -6,55 +6,46 @@
 #ifndef SENDMMSG_VAR__
 #define SENDMMSG_VAR__
 
+#include "tst_timer.h"
 #include "lapi/syscalls.h"
 
-static int do_sendmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
-		       int flags)
+static inline int libc_sendmmsg(int sockfd, struct mmsghdr *msgvec,
+				unsigned int vlen, unsigned int flags)
 {
-	switch (tst_variant) {
-	case 0:
-		return tst_syscall(__NR_sendmmsg, sockfd, msgvec, vlen, flags);
-	case 1:
 #ifdef HAVE_SENDMMSG
-		return sendmmsg(sockfd, msgvec, vlen, flags);
+	return sendmmsg(sockfd, msgvec, vlen, flags);
 #else
-		tst_brk(TCONF, "libc sendmmsg not present");
+	tst_brk(TCONF, "libc sendmmsg not present");
 #endif
-	}
+}
 
-	return -1;
+static inline int sys_sendmmsg(int sockfd, struct mmsghdr *msgvec,
+			       unsigned int vlen, unsigned int flags)
+{
+	return tst_syscall(__NR_sendmmsg, sockfd, msgvec, vlen, flags);
 }
 
-static int do_recvmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
-		       int flags, struct timespec *timeout)
+static inline int libc_recvmmsg(int sockfd, struct mmsghdr *msgvec,
+			unsigned int vlen, unsigned int flags, void *timeout)
 {
-	switch (tst_variant) {
-	case 0:
-		return tst_syscall(__NR_recvmmsg, sockfd, msgvec, vlen, flags,
-				   timeout);
-	case 1:
 #ifdef HAVE_RECVMMSG
-		return recvmmsg(sockfd, msgvec, vlen, flags, timeout);
+	return recvmmsg(sockfd, msgvec, vlen, flags, timeout);
 #else
-		tst_brk(TCONF, "libc recvmmsg not present");
+	tst_brk(TCONF, "libc recvmmsg not present");
 #endif
-	}
-
-	return -1;
 }
 
-static void test_info(void)
+static inline int sys_recvmmsg(int sockfd, struct mmsghdr *msgvec,
+			unsigned int vlen, unsigned int flags, void *timeout)
 {
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Testing direct sendmmsg and recvmmsg syscalls");
-		break;
-	case 1:
-		tst_res(TINFO, "Testing libc sendmmsg and recvmmsg syscalls");
-		break;
-	}
+	return tst_syscall(__NR_recvmmsg, sockfd, msgvec, vlen, flags, timeout);
 }
 
-#define TEST_VARIANTS 2
+static inline int sys_recvmmsg64(int sockfd, struct mmsghdr *msgvec,
+			unsigned int vlen, unsigned int flags, void *timeout)
+{
+	return tst_syscall(__NR_recvmmsg_time64, sockfd, msgvec, vlen, flags,
+			   timeout);
+}
 
 #endif /* SENDMMSG_VAR__ */
-- 
2.25.0.rc1.19.g042ed3e048af

