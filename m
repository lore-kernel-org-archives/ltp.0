From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 1 Nov 2016 18:01:07 +0800
Subject: [LTP] [PATCH] syscalls/sendto02.c: add new testcase
Message-ID: <1477994467-18497-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When sctp protocol is selected in socket(2) and buffer is invalid,
sendto(2) should fail and set errno to EFAULT, but it sets errno
to ENOMEM.

This is a regression test and has been fixed by kernel patch:
'commit 6e51fe757259 ("sctp: fix -ENOMEM result with invalid
user space pointer in sendto() syscall")'

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/sendto/sendto02.c | 126 ++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sendto/sendto02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b781241..6918795 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1005,6 +1005,7 @@ sendmsg01 sendmsg01
 sendmsg02 sendmsg02
 
 sendto01 sendto01
+sendto02 sendto02
 
 setdomainname01	setdomainname01
 setdomainname02	setdomainname02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f53cc05..eb9bf5c 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -814,6 +814,7 @@
 /sendmsg/sendmsg01
 /sendmsg/sendmsg02
 /sendto/sendto01
+/sendto/sendto02
 /set_robust_list/set_robust_list01
 /set_thread_area/set_thread_area01
 /set_thread_area/set_thread_area02
diff --git a/testcases/kernel/syscalls/sendto/sendto02.c b/testcases/kernel/syscalls/sendto/sendto02.c
new file mode 100644
index 0000000..67cc38d
--- /dev/null
+++ b/testcases/kernel/syscalls/sendto/sendto02.c
@@ -0,0 +1,126 @@
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
+ * Test Name: sendto02
+ *
+ * Description:
+ * When sctp protocol is selected in socket(2) and buffer is invalid,
+ * sendto(2) should fail and set errno to EFAULT, but it sets errno
+ * to ENOMEM.
+ *
+ * This is a regression test and has been fixed by kernel commit:
+ * 6e51fe7572590d8d86e93b547fab6693d305fd0d (sctp: fix -ENOMEM result
+ * with invalid user space pointer in sendto() syscall)
+ */
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include "tst_test.h"
+
+static int sockfd;
+static int rds_flag;
+static struct sockaddr_in sa;
+
+static void setup(void)
+{
+	int acc_res, load_res;
+	const char *cmd[] = {"modprobe", "sctp", NULL};
+
+	acc_res = access("/proc/sys/net/sctp", F_OK);
+	if (acc_res == -1 && errno != ENOENT)
+		tst_brk(TFAIL | TERRNO, "failed to check stcp module");
+
+	if (acc_res == -1 && errno == ENOENT) {
+		load_res = tst_run_cmd(cmd, NULL, NULL, 1);
+		if (load_res) {
+			tst_brk(TCONF, "failed to loaded sctp module, "
+				"so sctp modeule was not support by system");
+		}
+
+		tst_res(TINFO, "succeeded to load sctp module");
+		rds_flag = 1;
+	}
+
+	tst_res(TINFO, "sctp module was supported by system");
+
+	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 132 /*IPPROTO_SCTP*/);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sin_family = AF_INET;
+	sa.sin_addr.s_addr = inet_addr("127.0.0.1");
+	sa.sin_port = htons(11111);
+}
+
+static void cleanup(void)
+{
+	int unload_res;
+	const char *cmd[] = {"modprobe", "-r", "sctp", NULL};
+
+	if (rds_flag == 1) {
+		unload_res = tst_run_cmd(cmd, NULL, NULL, 1);
+		if (unload_res) {
+			/* We failed to unload sctp module(modprobe -r sctp)
+			 * and the operation failed with "FATAL: Module sctp is
+			 * in use." lsmod shows a reference count of 2 for sctp.
+			 * If we rebuild kernel with CONFIG_MODULE_FORCE_UNLOAD
+			 * enabled, we can succeed to unload sctp module
+			 * (rmmod -f sctp).
+			 */
+			tst_res(TINFO, "failed to unload sctp module, you can"
+				" reboot system to unload sctp after testing");
+		} else {
+			tst_res(TINFO, "succeeded to unload sctp modules");
+		}
+	}
+
+	if (sockfd > 0 && close(sockfd))
+		tst_res(TWARN | TERRNO, "failed to close file");
+}
+
+static void verify_sendto(void)
+{
+	TEST(sendto(sockfd, NULL, 1, 0, (struct sockaddr *) &sa, sizeof(sa)));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "sendto() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == ENOMEM) {
+		tst_res(TFAIL | TTERRNO, "sendto() got unrepaired errno with"
+			" invalid buffer when sctp is selected in socket()");
+		return;
+	}
+
+	if (TEST_ERRNO == EFAULT) {
+		tst_res(TPASS | TTERRNO, "sendto() got repaired errno with"
+			" invalid buffer when sctp is selected in socket()");
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO, "sendto() got unexpected errno with invalid"
+		" buffer when sctp is selected in socket(), expected ENOMEM "
+		"or EFAULT");
+}
+
+static struct tst_test test = {
+	.tid = "sendto02",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_sendto,
+};
-- 
1.8.3.1



