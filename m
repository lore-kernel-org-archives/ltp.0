From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 11:28:26 +0800
Subject: [LTP] [PATCH v2] syscalls/sendto02.c: add new testcase
In-Reply-To: <20161101162042.GB14966@rei.lan>
References: <20161101162042.GB14966@rei.lan>
Message-ID: <1478057306-15511-1-git-send-email-yangx.jy@cn.fujitsu.com>
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
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/.gitignore        |  1 +
 testcases/kernel/syscalls/sendto/sendto02.c | 91 +++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sendto/sendto02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7c84296..a9da8ca 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1006,6 +1006,7 @@ sendmsg01 sendmsg01
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
index 0000000..2d5887d
--- /dev/null
+++ b/testcases/kernel/syscalls/sendto/sendto02.c
@@ -0,0 +1,91 @@
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
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "tst_test.h"
+
+#ifndef IPPROTO_SCTP
+# define IPPROTO_SCTP	132
+#endif
+
+static int sockfd;
+static struct sockaddr_in sa;
+
+static void setup(void)
+{
+	sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
+	if (sockfd == -1) {
+		if (errno == EPROTONOSUPPORT)
+			tst_brk(TCONF, "sctp protocol was not supported");
+		else
+			tst_brk(TBROK | TERRNO, "socket() failed with sctp");
+	}
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sin_family = AF_INET;
+	sa.sin_addr.s_addr = inet_addr("127.0.0.1");
+	sa.sin_port = htons(11111);
+}
+
+static void cleanup(void)
+{
+	if (sockfd > 0 && close(sockfd))
+		tst_res(TWARN | TERRNO, "failed to close file");
+}
+
+static void verify_sendto(void)
+{
+	TEST(sendto(sockfd, NULL, 1, 0, (struct sockaddr *) &sa, sizeof(sa)));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "sendto(fd, NULL, ...) succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == EFAULT) {
+		tst_res(TPASS | TTERRNO,
+			"sendto(fd, NULL, ...) failed expectedly");
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO,
+		"sendto(fd, NULL, ...) failed unexpectedly, expected EFAULT");
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



