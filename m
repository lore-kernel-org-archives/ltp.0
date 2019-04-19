From: Steve Muckle <smuckle@google.com>
Date: Fri, 19 Apr 2019 14:06:37 -0700
Subject: [LTP] [RFC PATCH v2] syscalls/sendmmsg: add new test
Message-ID: <20190419210637.88522-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test basic functionality of sendmmsg and recvmmsg.

Signed-off-by: Steve Muckle <smuckle@google.com>
---

Known issues/questions:
 - This test occasionally gets stuck when the two messages get sent by
   separate sendmmsg calls. The two sendmmsg calls complete successfully
   but recvmmsg blocks indefinitely. I am not yet sure what would cause
   this.
 - I have not used tst_get_unused_port() because I'm unsure of how that
   function should be made available for both the new and old test API?
   I can just create a duplicate function but is there a cleaner way?

Changes since v1:
 - rebased on recent autotools cleanup for libc func checks
 - used test_variant to test direct syscalls and libc syscalls
 - use tst_syscall instead of ltp_syscall
 - check that both messages have been sent, retry sending messages if
   necessary
 - use tst_brk(TBROK... if sendmmsg fails so recv thread is not kept
   waiting

 configure.ac                                  |   3 +
 include/lapi/socket.h                         |   8 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/sendmmsg/.gitignore |   1 +
 testcases/kernel/syscalls/sendmmsg/Makefile   |   9 ++
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 147 ++++++++++++++++++
 .../kernel/syscalls/sendmmsg/sendmmsg_var.h   |  60 +++++++
 7 files changed, 230 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sendmmsg/.gitignore
 create mode 100644 testcases/kernel/syscalls/sendmmsg/Makefile
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h

diff --git a/configure.ac b/configure.ac
index fad8f8396..182a0476f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,8 +75,10 @@ AC_CHECK_FUNCS([ \
     pwritev \
     pwritev2 \
     readlinkat \
+    recvmmsg \
     renameat \
     renameat2 \
+    sendmmsg \
     sigpending \
     splice \
     stime \
@@ -243,6 +245,7 @@ LTP_CHECK_TIME
 LTP_CHECK_TIMERFD
 test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
 LTP_CHECK_TPACKET_V3
+LTP_CHECK_MMSGHDR
 LTP_CHECK_UNAME_DOMAINNAME
 LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_X_TABLES
diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index 2605443e8..6d9e9fe30 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -19,6 +19,7 @@
 #ifndef __LAPI_SOCKET_H__
 #define __LAPI_SOCKET_H__
 
+#include "config.h"
 #include <sys/socket.h>
 
 #ifndef MSG_ZEROCOPY
@@ -69,4 +70,11 @@
 # define SOL_ALG		279
 #endif
 
+#ifndef HAVE_STRUCT_MMSGHDR
+struct mmsghdr {
+	struct msghdr msg_hdr;
+	unsigned int msg_len;
+};
+#endif
+
 #endif /* __LAPI_SOCKET_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index 2b8ca719b..0e5d5ad3f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1109,6 +1109,8 @@ sendfile09_64 sendfile09_64
 sendmsg01 sendmsg01
 sendmsg02 sendmsg02
 
+sendmmsg01 sendmmsg01
+
 sendto01 sendto01
 sendto02 sendto02
 
diff --git a/testcases/kernel/syscalls/sendmmsg/.gitignore b/testcases/kernel/syscalls/sendmmsg/.gitignore
new file mode 100644
index 000000000..b703ececd
--- /dev/null
+++ b/testcases/kernel/syscalls/sendmmsg/.gitignore
@@ -0,0 +1 @@
+sendmmsg01
diff --git a/testcases/kernel/syscalls/sendmmsg/Makefile b/testcases/kernel/syscalls/sendmmsg/Makefile
new file mode 100644
index 000000000..47e063722
--- /dev/null
+++ b/testcases/kernel/syscalls/sendmmsg/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+sendmmsg01: CFLAGS+=-pthread
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
new file mode 100644
index 000000000..430fae10c
--- /dev/null
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
@@ -0,0 +1,147 @@
+/*
+ * This test is based on source contained in the man pages for sendmmsg and
+ * recvmmsg in release 4.15 of the Linux man-pages project.
+ */
+
+#define _GNU_SOURCE
+#include <netinet/ip.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+#include "lapi/socket.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_pthread.h"
+
+#include "sendmmsg_var.h"
+
+#define BUFSIZE 16
+#define VLEN 2
+
+static void *sender_thread(LTP_ATTRIBUTE_UNUSED void *arg)
+{
+	struct sockaddr_in addr;
+	struct mmsghdr msg[VLEN];
+	struct iovec msg1[2], msg2;
+	int send_sockfd;
+	int msgs = VLEN;
+	int retval;
+
+	send_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr.sin_port = htons(1234);
+	SAFE_CONNECT(send_sockfd, (struct sockaddr *) &addr, sizeof(addr));
+
+	memset(msg1, 0, sizeof(msg1));
+	msg1[0].iov_base = "one";
+	msg1[0].iov_len = 3;
+	msg1[1].iov_base = "two";
+	msg1[1].iov_len = 3;
+
+	memset(&msg2, 0, sizeof(msg2));
+	msg2.iov_base = "three";
+	msg2.iov_len = 5;
+
+	memset(msg, 0, sizeof(msg));
+	msg[0].msg_hdr.msg_iov = msg1;
+	msg[0].msg_hdr.msg_iovlen = 2;
+
+	msg[1].msg_hdr.msg_iov = &msg2;
+	msg[1].msg_hdr.msg_iovlen = 1;
+
+	while(msgs) {
+		retval = do_sendmmsg(send_sockfd, msg, msgs, 0);
+		if (retval < 0) {
+			/*
+			 * tst_brk is used here so reader is not left waiting
+			 * for data - note timeout for recvmmsg does not work
+			 * as one would expect (see man page)
+			 */
+			tst_brk(TBROK|TTERRNO, "sendmmsg failed");
+			return NULL;
+		}
+		msgs -= retval;
+	}
+
+	return NULL;
+}
+
+
+static void *receiver_thread(LTP_ATTRIBUTE_UNUSED void *arg)
+{
+	int receive_sockfd;
+	struct sockaddr_in addr;
+	struct mmsghdr msgs[VLEN];
+	struct iovec iovecs[VLEN];
+	char bufs[VLEN][BUFSIZE+1];
+	struct timespec timeout;
+	int i, retval;
+
+	receive_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr.sin_port = htons(1234);
+	SAFE_BIND(receive_sockfd, (struct sockaddr *)&addr, sizeof(addr));
+
+	memset(msgs, 0, sizeof(msgs));
+	for (i = 0; i < VLEN; i++) {
+		iovecs[i].iov_base = bufs[i];
+		iovecs[i].iov_len = BUFSIZE;
+		msgs[i].msg_hdr.msg_iov = &iovecs[i];
+		msgs[i].msg_hdr.msg_iovlen = 1;
+	}
+
+	timeout.tv_sec = 1;
+	timeout.tv_nsec = 0;
+
+	retval = do_recvmmsg(receive_sockfd, msgs, VLEN, 0, &timeout);
+	if (retval == -1) {
+		tst_res(TFAIL | TTERRNO, "recvmmsg failed");
+		return NULL;
+	}
+	if (retval != 2) {
+		tst_res(TFAIL, "Received unexpected number of messages (%d)",
+			retval);
+		return NULL;
+	}
+
+	bufs[0][msgs[0].msg_len] = 0;
+	if (strcmp(bufs[0], "onetwo"))
+		tst_res(TFAIL, "Error in first received message.");
+	else
+		tst_res(TPASS, "First message received successfully.");
+
+	bufs[1][msgs[1].msg_len] = 0;
+	if (strcmp(bufs[1], "three"))
+		tst_res(TFAIL, "Error in second received message.");
+	else
+		tst_res(TPASS, "Second message received successfully.");
+
+	return NULL;
+}
+
+static void run(void)
+{
+	pthread_t sender;
+	pthread_t receiver;
+
+	SAFE_PTHREAD_CREATE(&sender, NULL, sender_thread, NULL);
+	SAFE_PTHREAD_CREATE(&receiver, NULL, receiver_thread, NULL);
+	SAFE_PTHREAD_JOIN(sender, NULL);
+	SAFE_PTHREAD_JOIN(receiver, NULL);
+}
+
+static void setup(void)
+{
+	test_info();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.test_variants = TEST_VARIANTS,
+};
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h b/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h
new file mode 100644
index 000000000..f00cf056a
--- /dev/null
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Google, Inc.
+ */
+
+#ifndef SENDMMSG_VAR__
+#define SENDMMSG_VAR__
+
+#include "lapi/syscalls.h"
+
+static int do_sendmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
+		       int flags)
+{
+	switch (tst_variant) {
+	case 0:
+		return tst_syscall(__NR_sendmmsg, sockfd, msgvec, vlen, flags);
+	case 1:
+#ifdef HAVE_SENDMMSG
+		return sendmmsg(sockfd, msgvec, vlen, flags);
+#else
+		tst_brk(TCONF, "libc sendmmsg not present");
+#endif
+	}
+
+	return -1;
+}
+
+static int do_recvmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
+		       int flags, struct timespec *timeout)
+{
+	switch (tst_variant) {
+	case 0:
+		return tst_syscall(__NR_recvmmsg, sockfd, msgvec, vlen, flags,
+				   timeout);
+	case 1:
+#ifdef HAVE_RECVMMSG
+		return recvmmsg(sockfd, msgvec, vlen, flags, timeout);
+#else
+		tst_brk(TCONF, "libc recvmmsg not present");
+#endif
+	}
+
+	return -1;
+}
+
+static void test_info(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing direct sendmmsg and recvmmsg syscalls");
+		break;
+	case 1:
+		tst_res(TINFO, "Testing libc sendmmsg and recvmmsg syscalls");
+		break;
+	}
+}
+
+#define TEST_VARIANTS 2
+
+#endif /* SENDMMSG_VAR__ */
-- 
2.21.0.593.g511ec345e18-goog

