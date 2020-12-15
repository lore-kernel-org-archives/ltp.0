From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Dec 2020 17:36:57 +0100
Subject: [LTP] [PATCH v5 1/1] syscalls/{send|recv}mmsg: add a test case
 for timeout and errno test
In-Reply-To: <20201213224729.17974-2-Filip.Bozuta@syrmia.com>
References: <20201213224729.17974-1-Filip.Bozuta@syrmia.com>
 <20201213224729.17974-2-Filip.Bozuta@syrmia.com>
Message-ID: <X9jmKe8U06lF6fWm@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've been looking at the code and, in the end, decided to fix it since
that would be easier than explaining what should be changed. Detailed
comments below.

Generally speaking it would be easier to review if you send the
unrelated changes in a separate patches. For this changes I would have
send each new test in a separate patch to make the review easier.

Thanks for your contributions!

> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  runtest/syscalls                              |   3 +
>  testcases/kernel/syscalls/recvmmsg/Makefile   |   7 +
>  .../kernel/syscalls/recvmmsg/recvmmsg01.c     | 146 ++++++++++++++++++

Added missing .gitignore here.

>  testcases/kernel/syscalls/sendmmsg/.gitignore |   1 +
>  testcases/kernel/syscalls/sendmmsg/sendmmsg.h |  45 ++++++
>  .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 111 ++++++-------
>  .../kernel/syscalls/sendmmsg/sendmmsg02.c     |  87 +++++++++++
>  7 files changed, 347 insertions(+), 53 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/recvmmsg/Makefile
>  create mode 100644 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
>  create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg.h
>  create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
... 
> diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> new file mode 100644
> index 000000000..b3204cc9a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/* test status of errors:
> + *
> + * EBADF            v ('Bad socket file descriptor')
> + * EFAULT           v ('Bad message vector address')
> + * EINVAL           v ('Bad seconds value for the timeout argument')
> + * EINVAL           v ('Bad nanoseconds value for the timeout argument')
> + * EFAULT           v ('Bad timeout address')
> + */

I've reformatted these comments to asciidoc and changed the comment so
that it's picked by the documentation parser.

> +#define _GNU_SOURCE
> +#include "../sendmmsg/sendmmsg.h"
> +
> +static struct tst_ts ts;
> +
> +enum test_type {
> +	BAD_FD,
> +	BAD_MSGVEC,
> +	BAD_TS_VALUE_1,
> +	BAD_TS_VALUE_2,
> +	BAD_TS_ADDR,
> +};
> +
> +#define TYPE_NAME(x) .ttype = x, .desc = #x

> +struct test_case {
> +	int ttype;
> +	const char *desc;
> +	int fd;
> +	long tv_sec;
> +	long tv_nsec;
> +	int exp_errno;
> +};

I think that this whole test type makes the code harder to read, and we
more usually use indirection over something like this, so I've changed
the test structures in the testcases like that.

> +static struct test_case tcase[] = {
> +	{
> +		TYPE_NAME(BAD_FD),
> +		.fd = -1,
> +		.exp_errno = EBADF,
> +	},
> +	{
> +		TYPE_NAME(BAD_MSGVEC),
> +		.exp_errno = EFAULT,
> +	},
> +	{
> +		TYPE_NAME(BAD_TS_VALUE_1),
> +		.tv_sec = -1,
> +		.tv_nsec = 0,
> +		.exp_errno = EINVAL,
> +	},
> +	{
> +		TYPE_NAME(BAD_TS_VALUE_2),
> +		.tv_sec = 1,
> +		.tv_nsec = 1000000001,
> +		.exp_errno = EINVAL,
> +	},
> +	{
> +		TYPE_NAME(BAD_TS_ADDR),
> +		.exp_errno = EFAULT,
> +	}
> +};
> +
> +static void do_test(unsigned int i)
> +{
> +	struct time64_variants *tv = &variants[tst_variant];
> +	struct test_case *tc = &tcase[i];
> +	void *rcv_msgvec, *timeout;
> +
> +	tst_res(TINFO, "case %s", tc->desc);
> +
> +	if (tc->ttype != BAD_FD)
> +		tc->fd = receive_sockfd;
> +
> +	TEST(tv->sendmmsg(send_sockfd, snd_msg, 1, 0));
> +
> +	if (TST_RET != 1) {
> +		tst_res(TFAIL | TERRNO, "sendmmsg() failed");
> +		return;
> +	}

This is actually no-op sice the snd_msg is not initialized with the iov
vectors in setup. If you want to send any data you have to do that
first.

Also it does not make sense to call this on each iteration, even when
you want to have some data on the socket ready it could be done once in
the test setup.

So I've moved this to the test setup and changed the code to initialize
the message header correctly.

> +	memset(rcv1->iov_base, 0, rcv1->iov_len);
> +	memset(rcv2->iov_base, 0, rcv2->iov_len);

This is pointless we never check the content anways.

> +	ts.type = tv->ts_type;
> +	tst_ts_set_sec(&ts, tc->tv_sec);
> +	tst_ts_set_nsec(&ts, tc->tv_nsec);
> +
> +	if (tc->ttype == BAD_MSGVEC)
> +		rcv_msgvec = bad_addr;
> +	else
> +		rcv_msgvec = rcv_msg;
> +
> +	if (tc->ttype == BAD_TS_ADDR)
> +		timeout = bad_addr;
> +	else
> +		timeout = tst_ts_get(&ts);
> +
> +	TEST(tv->recvmmsg(tc->fd, rcv_msgvec, VLEN, 0, timeout));
> +
> +	if (TST_RET < 0) {
> +		if (tc->exp_errno == errno)
> +			tst_res(TPASS | TERRNO, "recvemmsg() failed successfully");
> +		else
> +			tst_res(TFAIL | TERRNO, "recvemmsg() failed unexpectedly");
> +	} else {
> +		tst_res(TFAIL | TERRNO, "recvemmsg() succeded unexpectedly");
> +	}

I've replaced this whole chunk with the newly introduced TST_EXP_FAIL()
macro.

> +}
> +
> +static void setup(void)
> +{
> +	struct sockaddr_in addr;
> +	unsigned int port = TST_GET_UNUSED_PORT(AF_INET, SOCK_DGRAM);
> +
> +	send_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> +	receive_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> +
> +	addr.sin_family = AF_INET;
> +	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +	addr.sin_port = port;
> +
> +	SAFE_BIND(receive_sockfd, (struct sockaddr *)&addr, sizeof(addr));
> +	SAFE_CONNECT(send_sockfd, (struct sockaddr *)&addr, sizeof(addr));
> +
> +	bad_addr = tst_get_bad_addr(NULL);
> +
> +	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +}
> +
> +static struct tst_test test = {
> +	.test = do_test,
> +	.tcnt = ARRAY_SIZE(tcase),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_variants = ARRAY_SIZE(variants),
> +	.bufs = (struct tst_buffers []) {
> +		{&snd1, .iov_sizes = (int[]){3, 3, -1}},
> +		{&snd2, .iov_sizes = (int[]){6, -1}},
> +		{&rcv1, .iov_sizes = (int[]){6, -1}},
> +		{&rcv2, .iov_sizes = (int[]){5, -1}},
> +		{&snd_msg, .size = VLEN * sizeof(*snd_msg)},
> +		{&rcv_msg, .size = VLEN * sizeof(*rcv_msg)},
> +		{},
> +	}
> +};

And I've did a similar changed to the sendmmsg02.c test.

> diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg.h b/testcases/kernel/syscalls/sendmmsg/sendmmsg.h
> new file mode 100644
> index 000000000..68a9a4020
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include <netinet/ip.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +
> +#include "time64_variants.h"
> +#include "tst_test.h"
> +#include "lapi/socket.h"
> +#include "tst_safe_macros.h"
> +#include "sendmmsg_var.h"
> +
> +#define BUFSIZE 16
> +#define VLEN 2
> +
> +static int send_sockfd;
> +static int receive_sockfd;
> +static struct mmsghdr *snd_msg, *rcv_msg;
> +static struct iovec *snd1, *snd2, *rcv1, *rcv2;
> +
> +static void *bad_addr;

Hiding variables like this in headers makes the code harder to
understand also most of the tests does not need more than one header and
one iov, so I've moved these to testcases where we declare only what we
actually need.

> +#define TYPE_NAME(x) .ttype = x, .desc = #x
> +
> +static struct time64_variants variants[] = {
> +	{ .recvmmsg = libc_recvmmsg, .sendmmsg = libc_sendmmsg, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
> +
> +#if (__NR_recvmmsg != __LTP__NR_INVALID_SYSCALL)
> +	{ .recvmmsg = sys_recvmmsg, .sendmmsg = sys_sendmmsg, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
> +#endif
> +
> +#if (__NR_recvmmsg_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{ .recvmmsg = sys_recvmmsg64, .sendmmsg = sys_sendmmsg, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
> +#endif
> +};
> +
> +static void cleanup(void)
> +{
> +	if (send_sockfd > 0)
> +		SAFE_CLOSE(send_sockfd);
> +	if (receive_sockfd > 0)
> +		SAFE_CLOSE(receive_sockfd);
> +}

Same here, moved the cleanup to tests and changed it to close only what
was opened.

> diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
> index d6a717687..ad26a7b4d 100644
> --- a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
> +++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c

As for this changes I've reverted the added test. Techincally this is
testing recvmmsg() timeout, as far as I can tell it would be better if
we added a recvmmsg test based on these changes. Also having the timeout
tests in a separate test would make the code a bit easier to read.

The full diff:

diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
index b3204cc9a..8f066de9b 100644
--- a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
+++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
@@ -1,63 +1,76 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-/* test status of errors:
+/*\
+ * Test recvmmsg() errors:
  *
- * EBADF            v ('Bad socket file descriptor')
- * EFAULT           v ('Bad message vector address')
- * EINVAL           v ('Bad seconds value for the timeout argument')
- * EINVAL           v ('Bad nanoseconds value for the timeout argument')
- * EFAULT           v ('Bad timeout address')
- */
+ * - EBADF  Bad socket file descriptor
+ * - EFAULT Bad message vector address
+ * - EINVAL Bad seconds value for the timeout argument
+ * - EINVAL Bad nanoseconds value for the timeout argument
+ * - EFAULT Bad timeout address
+\*/
 
 #define _GNU_SOURCE
 #include "../sendmmsg/sendmmsg.h"
 
-static struct tst_ts ts;
+static int send_sockfd;
+static int receive_sockfd;
 
-enum test_type {
-	BAD_FD,
-	BAD_MSGVEC,
-	BAD_TS_VALUE_1,
-	BAD_TS_VALUE_2,
-	BAD_TS_ADDR,
-};
+#define VLEN 1
+
+static struct mmsghdr *msg;
+static struct iovec *iov;
+
+static void *bad_addr;
+static int bad_fd = -1;
 
-#define TYPE_NAME(x) .ttype = x, .desc = #x
+static struct tst_ts ts;
 
 struct test_case {
-	int ttype;
 	const char *desc;
-	int fd;
+	int *fd;
 	long tv_sec;
 	long tv_nsec;
 	int exp_errno;
+	struct mmsghdr **msg_vec;
+	int bad_ts_addr;
 };
 
 static struct test_case tcase[] = {
 	{
-		TYPE_NAME(BAD_FD),
-		.fd = -1,
+		.desc = "bad socket file descriptor",
+		.fd = &bad_fd,
 		.exp_errno = EBADF,
+		.msg_vec = &msg,
 	},
 	{
-		TYPE_NAME(BAD_MSGVEC),
+		.desc = "bad message vector address",
+		.fd = &receive_sockfd,
 		.exp_errno = EFAULT,
+		.msg_vec = (void*)&bad_addr,
 	},
 	{
-		TYPE_NAME(BAD_TS_VALUE_1),
+		.desc = "negative seconds in timeout",
+		.fd = &receive_sockfd,
 		.tv_sec = -1,
 		.tv_nsec = 0,
 		.exp_errno = EINVAL,
+		.msg_vec = &msg,
 	},
 	{
-		TYPE_NAME(BAD_TS_VALUE_2),
+		.desc = "overflow in nanoseconds in timeout",
+		.fd = &receive_sockfd,
 		.tv_sec = 1,
 		.tv_nsec = 1000000001,
 		.exp_errno = EINVAL,
+		.msg_vec = &msg,
 	},
 	{
-		TYPE_NAME(BAD_TS_ADDR),
+		.desc = "bad timeout address",
+		.fd = &receive_sockfd,
 		.exp_errno = EFAULT,
+		.msg_vec = &msg,
+		.bad_ts_addr = 1,
 	}
 };
 
@@ -65,53 +78,28 @@ static void do_test(unsigned int i)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
-	void *rcv_msgvec, *timeout;
-
-	tst_res(TINFO, "case %s", tc->desc);
-
-	if (tc->ttype != BAD_FD)
-		tc->fd = receive_sockfd;
-
-	TEST(tv->sendmmsg(send_sockfd, snd_msg, 1, 0));
-
-	if (TST_RET != 1) {
-		tst_res(TFAIL | TERRNO, "sendmmsg() failed");
-		return;
-	}
-
-	memset(rcv1->iov_base, 0, rcv1->iov_len);
-	memset(rcv2->iov_base, 0, rcv2->iov_len);
+	void *timeout;
 
 	ts.type = tv->ts_type;
 	tst_ts_set_sec(&ts, tc->tv_sec);
 	tst_ts_set_nsec(&ts, tc->tv_nsec);
 
-	if (tc->ttype == BAD_MSGVEC)
-		rcv_msgvec = bad_addr;
-	else
-		rcv_msgvec = rcv_msg;
-
-	if (tc->ttype == BAD_TS_ADDR)
+	if (tc->bad_ts_addr)
 		timeout = bad_addr;
 	else
 		timeout = tst_ts_get(&ts);
 
-	TEST(tv->recvmmsg(tc->fd, rcv_msgvec, VLEN, 0, timeout));
-
-	if (TST_RET < 0) {
-		if (tc->exp_errno == errno)
-			tst_res(TPASS | TERRNO, "recvemmsg() failed successfully");
-		else
-			tst_res(TFAIL | TERRNO, "recvemmsg() failed unexpectedly");
-	} else {
-		tst_res(TFAIL | TERRNO, "recvemmsg() succeded unexpectedly");
-	}
+	TST_EXP_FAIL(tv->recvmmsg(*tc->fd, *tc->msg_vec, VLEN, 0, timeout),
+	             tc->exp_errno, "recvmmsg() %s", tc->desc);
 }
 
 static void setup(void)
 {
 	struct sockaddr_in addr;
 	unsigned int port = TST_GET_UNUSED_PORT(AF_INET, SOCK_DGRAM);
+	struct time64_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 
 	send_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
 	receive_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
@@ -123,9 +111,26 @@ static void setup(void)
 	SAFE_BIND(receive_sockfd, (struct sockaddr *)&addr, sizeof(addr));
 	SAFE_CONNECT(send_sockfd, (struct sockaddr *)&addr, sizeof(addr));
 
+	msg[0].msg_hdr.msg_iov = iov;
+	msg[0].msg_hdr.msg_iovlen = 1;
+
+	TEST(tv->sendmmsg(send_sockfd, msg, 1, 0));
+
+	if (TST_RET != 1) {
+		tst_res(TFAIL | TERRNO, "sendmmsg() failed");
+		return;
+	}
+
 	bad_addr = tst_get_bad_addr(NULL);
+}
 
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+static void cleanup(void)
+{
+	if (send_sockfd > 0)
+		SAFE_CLOSE(send_sockfd);
+
+	if (receive_sockfd > 0)
+		SAFE_CLOSE(receive_sockfd);
 }
 
 static struct tst_test test = {
@@ -135,12 +140,8 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_variants = ARRAY_SIZE(variants),
 	.bufs = (struct tst_buffers []) {
-		{&snd1, .iov_sizes = (int[]){3, 3, -1}},
-		{&snd2, .iov_sizes = (int[]){6, -1}},
-		{&rcv1, .iov_sizes = (int[]){6, -1}},
-		{&rcv2, .iov_sizes = (int[]){5, -1}},
-		{&snd_msg, .size = VLEN * sizeof(*snd_msg)},
-		{&rcv_msg, .size = VLEN * sizeof(*rcv_msg)},
+		{&iov, .iov_sizes = (int[]){1, -1}},
+		{&msg, .size = VLEN * sizeof(*msg)},
 		{},
 	}
 };
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg.h b/testcases/kernel/syscalls/sendmmsg/sendmmsg.h
index 68a9a4020..65d5b680f 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg.h
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg.h
@@ -13,16 +13,6 @@
 #include "sendmmsg_var.h"
 
 #define BUFSIZE 16
-#define VLEN 2
-
-static int send_sockfd;
-static int receive_sockfd;
-static struct mmsghdr *snd_msg, *rcv_msg;
-static struct iovec *snd1, *snd2, *rcv1, *rcv2;
-
-static void *bad_addr;
-
-#define TYPE_NAME(x) .ttype = x, .desc = #x
 
 static struct time64_variants variants[] = {
 	{ .recvmmsg = libc_recvmmsg, .sendmmsg = libc_sendmmsg, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
@@ -35,11 +25,3 @@ static struct time64_variants variants[] = {
 	{ .recvmmsg = sys_recvmmsg64, .sendmmsg = sys_sendmmsg, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
-
-static void cleanup(void)
-{
-	if (send_sockfd > 0)
-		SAFE_CLOSE(send_sockfd);
-	if (receive_sockfd > 0)
-		SAFE_CLOSE(receive_sockfd);
-}
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
index ad26a7b4d..e3884f1fd 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
@@ -1,52 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
+/*\
+ * Basic sendmmsg() test that sends and receives messages.
+ *
  * This test is based on source contained in the man pages for sendmmsg and
  * recvmmsg in release 4.15 of the Linux man-pages project.
- */
+\*/
 
 #define _GNU_SOURCE
-
 #include "sendmmsg.h"
 
-enum test_type {
-	NORMAL,
-	TIMEOUT,
-};
+#define BUFSIZE 16
+#define VLEN 2
 
-struct test_case {
-	int ttype;
-	const char *desc;
-	long tv_sec;
-	long tv_nsec;
-	int exp_ret;
-};
+static int send_sockfd;
+static int receive_sockfd;
+static struct mmsghdr *snd_msg, *rcv_msg;
+static struct iovec *snd1, *snd2, *rcv1, *rcv2;
 
-static struct test_case tcase[] = {
-	{
-		TYPE_NAME(NORMAL),
-		.tv_sec = 1,
-		.tv_nsec = 0,
-		.exp_ret = 2,
-	},
-	{
-		TYPE_NAME(TIMEOUT),
-		.tv_sec = 0,
-		.tv_nsec = 0,
-		.exp_ret = 1,
-	},
-};
-
-static void do_test(unsigned int i)
+static void run(void)
 {
 	struct time64_variants *tv = &variants[tst_variant];
-	struct test_case *tc = &tcase[i];
 	struct tst_ts timeout;
+	int retval;
 
-	tst_res(TINFO, "case %s", tc->desc);
-
-	TEST(tv->sendmmsg(send_sockfd, snd_msg, VLEN, 0));
-
-	if (TST_RET < 0 || snd_msg[0].msg_len != 6 || snd_msg[1].msg_len != 6) {
+	retval = tv->sendmmsg(send_sockfd, snd_msg, VLEN, 0);
+	if (retval < 0 || snd_msg[0].msg_len != 6 || snd_msg[1].msg_len != 6) {
 		tst_res(TFAIL | TERRNO, "sendmmsg() failed");
 		return;
 	}
@@ -55,18 +33,18 @@ static void do_test(unsigned int i)
 	memset(rcv2->iov_base, 0, rcv2->iov_len);
 
 	timeout.type = tv->ts_type;
-	tst_ts_set_sec(&timeout, tc->tv_sec);
-	tst_ts_set_nsec(&timeout, tc->tv_nsec);
+	tst_ts_set_sec(&timeout, 1);
+	tst_ts_set_nsec(&timeout, 0);
 
-	TEST(tv->recvmmsg(receive_sockfd, rcv_msg, VLEN, 0, tst_ts_get(&timeout)));
+	retval = tv->recvmmsg(receive_sockfd, rcv_msg, VLEN, 0, tst_ts_get(&timeout));
 
-	if (TST_RET == -1) {
+	if (retval == -1) {
 		tst_res(TFAIL | TERRNO, "recvmmsg() failed");
 		return;
 	}
-	if (tc->exp_ret != TST_RET) {
+	if (retval != 2) {
 		tst_res(TFAIL, "Received unexpected number of messages (%d)",
-			TST_RET);
+			retval);
 		return;
 	}
 
@@ -75,18 +53,10 @@ static void do_test(unsigned int i)
 	else
 		tst_res(TPASS, "First message received successfully");
 
-	if (tc->ttype == NORMAL) {
-		if (memcmp(rcv2->iov_base, "three", 5))
-			tst_res(TFAIL, "Error in second received message");
-		else
-			tst_res(TPASS, "Second message received successfully");
-	} else {
-		TEST(tv->recvmmsg(receive_sockfd, rcv_msg, 1, 0, NULL));
-		if (TST_RET != 1 || memcmp(rcv1->iov_base, "three", 5))
-			tst_res(TFAIL, "Error in second message after the timeout");
-		else
-			tst_res(TPASS, "Timeout successfully reached before second message");
-	}
+	if (memcmp(rcv2->iov_base, "three", 5))
+		tst_res(TFAIL, "Error in second received message");
+	else
+		tst_res(TPASS, "Second message received successfully");
 }
 
 static void setup(void)
@@ -120,14 +90,19 @@ static void setup(void)
 	rcv_msg[1].msg_hdr.msg_iov = rcv2;
 	rcv_msg[1].msg_hdr.msg_iovlen = 1;
 
-	bad_addr = tst_get_bad_addr(NULL);
-
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
+static void cleanup(void)
+{
+	if (send_sockfd > 0)
+		SAFE_CLOSE(send_sockfd);
+	if (receive_sockfd > 0)
+		SAFE_CLOSE(receive_sockfd);
+}
+
 static struct tst_test test = {
-	.test = do_test,
-	.tcnt = ARRAY_SIZE(tcase),
+	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = ARRAY_SIZE(variants),
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
index 8ed345b09..7c3f2164c 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
@@ -1,36 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-/* test status of errors:
+/*\
+ * Tests sendmmsg() failures:
  *
- * EBADF            v ('Bad socket file descriptor')
- * EFAULT           v ('Bad message vector address')
- */
+ * - EBADF Bad socket file descriptor
+ * - EFAULT Bad message vector address
+\*/
 
 #define _GNU_SOURCE
 #include "sendmmsg.h"
 
-enum test_type {
-	BAD_FD,
-	BAD_MSGVEC,
-};
+#define VLEN 1
+
+static int send_sockfd;
+static struct mmsghdr *snd_msg;
 
-#define TYPE_NAME(x) .ttype = x, .desc = #x
+static void *bad_addr;
+static int bad_fd = -1;
 
 struct test_case {
-	int ttype;
 	const char *desc;
-	int fd;
+	int *fd;
 	int exp_errno;
+	struct mmsghdr **msg_vec;
 };
 
 static struct test_case tcase[] = {
 	{
-		TYPE_NAME(BAD_FD),
-		.fd = -1,
+		.desc = "bad file descriptor",
+		.fd = &bad_fd,
+		.msg_vec = &snd_msg,
 		.exp_errno = EBADF,
 	},
 	{
-		TYPE_NAME(BAD_MSGVEC),
+		.desc = "invalid msgvec address",
+		.fd = &send_sockfd,
+		.msg_vec = (void*)&bad_addr,
 		.exp_errno = EFAULT,
 	},
 };
@@ -39,27 +44,9 @@ static void do_test(unsigned int i)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
-	void *snd_msgvec;
-
-	tst_res(TINFO, "case %s", tc->desc);
-
-	if (tc->ttype != BAD_FD)
-		tc->fd = send_sockfd;
-
-	if (tc->ttype == BAD_MSGVEC)
-		snd_msgvec = bad_addr;
-	else
-		snd_msgvec = snd_msg;
 
-	TEST(tv->sendmmsg(tc->fd, snd_msgvec, VLEN, 0));
-
-	if (TST_RET < 0)
-		if (tc->exp_errno != TST_ERR)
-			tst_res(TFAIL | TERRNO, "sendmmsg() failed unexpectedly");
-		else
-			tst_res(TPASS | TERRNO, "sendmmg() failed successfully");
-	else
-		tst_res(TFAIL, "sendmmsg() succeded unexpectedly");
+	TST_EXP_FAIL(tv->sendmmsg(*tc->fd, *tc->msg_vec, VLEN, 0),
+	             tc->exp_errno, "%s", tc->desc);
 }
 
 static void setup(void)
@@ -69,6 +56,12 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
+static void cleanup(void)
+{
+	if (send_sockfd > 0)
+		SAFE_CLOSE(send_sockfd);
+}
+
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcase),
@@ -76,12 +69,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_variants = ARRAY_SIZE(variants),
 	.bufs = (struct tst_buffers []) {
-		{&snd1, .iov_sizes = (int[]){3, 3, -1}},
-		{&snd2, .iov_sizes = (int[]){6, -1}},
-		{&rcv1, .iov_sizes = (int[]){6, -1}},
-		{&rcv2, .iov_sizes = (int[]){5, -1}},
 		{&snd_msg, .size = VLEN * sizeof(*snd_msg)},
-		{&rcv_msg, .size = VLEN * sizeof(*rcv_msg)},
 		{},
 	}
 };

-- 
Cyril Hrubis
chrubis@suse.cz
