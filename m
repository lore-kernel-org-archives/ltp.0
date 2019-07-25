From: Steve Muckle <smuckle@google.com>
Date: Thu, 25 Jul 2019 14:11:19 -0700
Subject: [LTP] [PATCH] syscalls/sendmmsg: add new test
Message-ID: <20190725211119.239938-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test basic functionality of sendmmsg and recvmmsg.

Signed-off-by: Steve Muckle <smuckle@google.com>
---

Changes since v3:
 - drop resending of messages on partially successful sendmmsg()
 - drop use of pthreads, do message creation and port management in
   setup/cleanup

Changes since v2:
 - fix race between sender and receiver
 - use TST_GET_UNUSED_PORT
 - fix checkpatch error (it still complains about the // on the SPDX
   identifier in sendmmsg_var.h, but other headers in this project
   use that style)
 - add SPDX identifier in sendmmsg01.c

Changes since v1:
 - rebased on recent autotools cleanup for libc func checks
 - used test_variant to test direct syscalls and libc syscalls
 - use tst_syscall instead of ltp_syscall
 - check that both messages have been sent, retry sending messages if
   necessary
 - use tst_brk(TBROK... if sendmmsg fails so recv thread is not kept
   waiting

 configure.ac                                  |   3 +
 include/lapi/socket.h                         |   8 ++
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/sendmmsg/.gitignore |   1 +
 testcases/kernel/syscalls/sendmmsg/Makefile   |   9 ++
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     | 126 ++++++++++++++++++
 .../kernel/syscalls/sendmmsg/sendmmsg_var.h   |  60 +++++++++
 7 files changed, 209 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sendmmsg/.gitignore
 create mode 100644 testcases/kernel/syscalls/sendmmsg/Makefile
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
 create mode 100644 testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h

diff --git a/configure.ac b/configure.ac
index 3dcf282e8..5e4e7f1f9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -82,9 +82,11 @@ AC_CHECK_FUNCS([ \
     pwritev \
     pwritev2 \
     readlinkat \
+    recvmmsg \
     renameat \
     renameat2 \
     sched_getcpu \
+    sendmmsg \
     sigpending \
     splice \
     stime \
@@ -253,6 +255,7 @@ LTP_CHECK_TIME
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
index 67dfed661..1e79e41c3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1117,6 +1117,8 @@ sendfile09_64 sendfile09_64
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
index 000000000..37a71f281
--- /dev/null
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+
+#include "sendmmsg_var.h"
+
+#define BUFSIZE 16
+#define VLEN 2
+
+static int send_sockfd;
+static int receive_sockfd;
+static struct mmsghdr msg[VLEN];
+static struct iovec msg1[2], msg2;
+
+static void run(void)
+{
+	struct mmsghdr msgs_in[VLEN];
+	struct iovec iovecs[VLEN];
+	char bufs[VLEN][BUFSIZE+1];
+	struct timespec timeout;
+	int i, retval;
+
+	retval = do_sendmmsg(send_sockfd, msg, VLEN, 0);
+	if (retval < 0 || msg[0].msg_len != 6 || msg[1].msg_len != 5) {
+		tst_res(TFAIL|TTERRNO, "sendmmsg failed");
+		return;
+	}
+
+	memset(msgs_in, 0, sizeof(msgs_in));
+	for (i = 0; i < VLEN; i++) {
+		iovecs[i].iov_base = bufs[i];
+		iovecs[i].iov_len = BUFSIZE;
+		msgs_in[i].msg_hdr.msg_iov = &iovecs[i];
+		msgs_in[i].msg_hdr.msg_iovlen = 1;
+	}
+
+	timeout.tv_sec = 1;
+	timeout.tv_nsec = 0;
+
+	retval = do_recvmmsg(receive_sockfd, msgs_in, VLEN, 0, &timeout);
+
+	if (retval == -1) {
+		tst_res(TFAIL | TTERRNO, "recvmmsg failed");
+		return;
+	}
+	if (retval != 2) {
+		tst_res(TFAIL, "Received unexpected number of messages (%d)",
+			retval);
+		return;
+	}
+
+	bufs[0][msgs_in[0].msg_len] = 0;
+	if (strcmp(bufs[0], "onetwo"))
+		tst_res(TFAIL, "Error in first received message.");
+	else
+		tst_res(TPASS, "First message received successfully.");
+
+	bufs[1][msgs_in[1].msg_len] = 0;
+	if (strcmp(bufs[1], "three"))
+		tst_res(TFAIL, "Error in second received message.");
+	else
+		tst_res(TPASS, "Second message received successfully.");
+}
+
+static void setup(void)
+{
+	struct sockaddr_in addr;
+	unsigned int port = TST_GET_UNUSED_PORT(AF_INET, SOCK_DGRAM);
+
+	send_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+	receive_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr.sin_port = port;
+
+	SAFE_BIND(receive_sockfd, (struct sockaddr *)&addr, sizeof(addr));
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
+	test_info();
+}
+
+static void cleanup(void)
+{
+	if (send_sockfd > 0)
+		SAFE_CLOSE(send_sockfd);
+	if (receive_sockfd > 0)
+		SAFE_CLOSE(receive_sockfd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
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
2.22.0.709.g102302147b-goog

