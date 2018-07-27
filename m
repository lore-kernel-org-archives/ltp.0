From: Michael Moese <mmoese@suse.de>
Date: Fri, 27 Jul 2018 14:30:14 +0200
Subject: [LTP] [PATCH v3] add new testcase for bind
Message-ID: <20180727123014.24435-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With
  0fb44559ffd6  af_unix: move unix_mknod() out of bindlock
the behavior of bind() for STREAM UNIX sockets changed in
case a socket that is already bound is passed to bind() again.

This testcase fails for the new behavior and passes for the
old one.

Signed-off-by: Michael Moese <mmoese@suse.de>
---

Changes to v2:
change to relative socket path and letting the harness handle the
temporaty directory

Changes to v1:
I just cleaned the includes and comments as suggested.
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/bind/.gitignore |  1 +
 testcases/kernel/syscalls/bind/bind03.c   | 81 +++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bind/bind03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index dc72484cb..e8b93a65b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -29,6 +29,7 @@ asyncio02 asyncio02
 
 bind01 bind01
 bind02 bind02
+bind03 bind03
 
 bdflush01 bdflush01
 
diff --git a/testcases/kernel/syscalls/bind/.gitignore b/testcases/kernel/syscalls/bind/.gitignore
index ba46f4fa2..4ebea9ee7 100644
--- a/testcases/kernel/syscalls/bind/.gitignore
+++ b/testcases/kernel/syscalls/bind/.gitignore
@@ -1,2 +1,3 @@
 /bind01
 /bind02
+/bind03
diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
new file mode 100644
index 000000000..06314a8c0
--- /dev/null
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2018 Michael Moese <mmoese@suse.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+/* The commit 0fb44559ffd6  af_unix: move unix_mknod() out of bindlock
+ * changed the behavior of bind() for STREAM UNIX domain sockets if
+ */
+
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "tst_test.h"
+#include "tst_safe_net.h"
+
+#define SNAME "socket.1"
+
+static int sock1, sock2;
+
+void run(void)
+{
+	struct sockaddr_un sun;
+
+	sock1 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
+
+	memset(&sun, 0, sizeof(sun));
+	sun.sun_family = AF_UNIX;
+	if (sprintf(sun.sun_path, "%s", SNAME) < (int) strlen(SNAME)) {
+		tst_res(TFAIL, "sprintf failed");
+		return;
+	}
+
+	SAFE_BIND(sock1, (struct sockaddr *)&sun, sizeof(sun));
+
+	/*
+	 * Once a STREAM UNIX domain socket has been bound, it can't be
+	 * rebound. Expected error is EINVAL.
+	 */
+	if (bind(sock1, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
+		tst_res(TFAIL, "re-binding of socket succeeded");
+		return;
+	}
+
+	if (errno != EINVAL) {
+		tst_res(TFAIL | TERRNO, "expected EINVAL");
+		return;
+	}
+
+	sock2 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
+
+	/*
+	 * Since a socket is already bound to the pathname, it can't be bound
+	 * to a second socket. Expected error is EADDRINUSE.
+	 */
+	if (bind(sock2, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
+		tst_res(TFAIL, "bind() succeeded with already bound pathname!");
+		return;
+	}
+
+	if (errno != EADDRINUSE) {
+		tst_res(TFAIL | TERRNO, "expected to fail with EADDRINUSE");
+		return;
+	}
+
+	tst_res(TPASS, "bind() failed with EADDRINUSE as expected");
+}
+
+static void cleanup(void)
+{
+	close(sock1);
+	close(sock2);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.18.0

