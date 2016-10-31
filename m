From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 31 Oct 2016 19:23:54 +0800
Subject: [LTP] [PATCH] syscalls/recvmsg03.c: add new testcase
Message-ID: <1477913034-20459-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the size of address for receiving data is set larger than actaul
size, recvmsg() will set msg_namelen incorrectly and destroy sock_fd.

This bug has been fixed by the following kernel commit:
06b6a1cf6e776426766298d055bb3991957d90a7(rds: set correct msg_namelen)

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/recvmsg/recvmsg03.c | 195 ++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100644 testcases/kernel/syscalls/recvmsg/recvmsg03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b781241..4c87f45 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -869,6 +869,7 @@ recvfrom01 recvfrom01
 
 recvmsg01 recvmsg01
 recvmsg02 recvmsg02
+recvmsg03 recvmsg03
 
 remap_file_pages01 remap_file_pages01
 remap_file_pages02 remap_file_pages02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f53cc05..1229720 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -725,6 +725,7 @@
 /recvfrom/recvfrom01
 /recvmsg/recvmsg01
 /recvmsg/recvmsg02
+/recvmsg/recvmsg03
 /remap_file_pages/remap_file_pages01
 /remap_file_pages/remap_file_pages02
 /removexattr/removexattr01
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg03.c b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
new file mode 100644
index 0000000..c4225c4
--- /dev/null
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
@@ -0,0 +1,195 @@
+/*
+ * Copyright(c) 2016 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ */
+
+/*
+ * Test Name: recvmsg03
+ *
+ * This test needs that rds socket is supported by system.
+ * If the size of address for receiving data is set larger than actaul size,
+ * recvmsg() will set msg_namelen incorrectly and destroy sock_fd.
+ *
+ * Description:
+ * This is a regression test and has been fixed by kernel commit:
+ * 06b6a1cf6e776426766298d055bb3991957d90a7 (rds: set correct msg_namelen)
+ */
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <stdio.h>
+
+#include "tst_test.h"
+
+#ifndef AF_RDS
+# define AF_RDS 21
+#endif
+
+static int rds_flag;
+
+static void setup(void)
+{
+	int acc_res, load_res;
+	const char *cmd[] = {"modprobe", "-i", "rds", NULL};
+
+	acc_res = access("/proc/sys/net/rds", F_OK);
+	if (acc_res == -1 && errno == ENOENT) {
+		load_res = tst_run_cmd(cmd, NULL, NULL, 1);
+		if (load_res) {
+			tst_brk(TCONF, "failed to loaded rds module, "
+				"so rds modeule was not support by system");
+		} else {
+			tst_res(TINFO, "succeeded to load rds module");
+			rds_flag = 1;
+		}
+	}
+
+	if (acc_res == -1 && errno != ENOENT)
+		tst_brk(TFAIL | TERRNO, "failed to check rds module");
+
+	tst_res(TINFO, "rds module was supported by system");
+}
+
+static void cleanup(void)
+{
+	int unload_res;
+	const char *cmd[] = {"modprobe", "-r", "rds", NULL};
+
+	if (rds_flag == 1) {
+		unload_res = tst_run_cmd(cmd, NULL, NULL, 1);
+		if (unload_res)
+			tst_res(TWARN | TERRNO, "failed to unload rds module");
+		else
+			tst_res(TINFO, "succeeded to unload rds modules");
+	}
+}
+
+static void client(void)
+{
+	int sock_fd1;
+	char sendBuffer[128] = "hello world";
+	struct sockaddr_in serverAddr;
+	struct sockaddr_in toAddr;
+	struct msghdr msg;
+	struct iovec iov;
+
+	sock_fd1 = SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
+
+	memset(&serverAddr, 0, sizeof(serverAddr));
+	serverAddr.sin_family = AF_INET;
+	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
+	serverAddr.sin_port = htons(4001);
+
+	SAFE_BIND(sock_fd1, (struct sockaddr *) &serverAddr, sizeof(serverAddr));
+
+	memset(&toAddr, 0, sizeof(toAddr));
+
+	toAddr.sin_family = AF_INET;
+	toAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
+	toAddr.sin_port = htons(4000);
+	msg.msg_name = &toAddr;
+	msg.msg_namelen = sizeof(toAddr);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_iov->iov_base = sendBuffer;
+	msg.msg_iov->iov_len = strlen(sendBuffer) + 1;
+	msg.msg_control = 0;
+	msg.msg_controllen = 0;
+	msg.msg_flags = 0;
+
+	if (sendmsg(sock_fd1, &msg, 0) == -1) {
+		tst_brk(TFAIL | TERRNO,
+			"sendmsg() failed to send data to server");
+	}
+
+	SAFE_CLOSE(sock_fd1);
+}
+
+static void server(void)
+{
+	int sock_fd, sock_fd2;
+	static char recvBuffer[128];
+	struct sockaddr_in serverAddr;
+	struct sockaddr_in fromAddr;
+	struct msghdr msg;
+	struct iovec iov;
+
+	sock_fd2 = SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
+	sock_fd = sock_fd2;
+
+	memset(&serverAddr, 0, sizeof(serverAddr));
+	serverAddr.sin_family = AF_INET;
+	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
+	serverAddr.sin_port = htons(4000);
+
+	SAFE_BIND(sock_fd2, (struct sockaddr *) &serverAddr, sizeof(serverAddr));
+
+	msg.msg_name = &fromAddr;
+	msg.msg_namelen = sizeof(fromAddr) + 16;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_iov->iov_base = recvBuffer;
+	msg.msg_iov->iov_len = 128;
+	msg.msg_control = 0;
+	msg.msg_controllen = 0;
+	msg.msg_flags = 0;
+
+	TST_CHECKPOINT_WAKE(0);
+
+	TEST(recvmsg(sock_fd2, &msg, 0));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TERRNO,
+		"recvmsg() failed to recvice data from client");
+		return;
+	}
+
+	if (msg.msg_namelen != sizeof(fromAddr)) {
+		tst_res(TFAIL, "msg_namelen was set to %u incorrectly, "
+			"expected %lu", msg.msg_namelen, sizeof(fromAddr));
+		return;
+	}
+
+	if (sock_fd2 != sock_fd) {
+		tst_res(TFAIL, "sock_fd was destroyed");
+		return;
+	}
+
+	tst_res(TPASS, "msg_namelen was set to %u correctly and sock_fd was "
+		"not destroyed", msg.msg_namelen);
+
+	SAFE_CLOSE(sock_fd2);
+}
+
+static void verify_recvmsg(void)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		TST_CHECKPOINT_WAIT(0);
+		client();
+	} else {
+		server();
+	}
+}
+
+static struct tst_test test = {
+	.tid = "recvmsg03",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_recvmsg
+};
-- 
1.8.3.1



