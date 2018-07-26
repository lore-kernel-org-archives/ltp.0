From: Michael Moese <mmoese@suse.de>
Date: Thu, 26 Jul 2018 10:46:20 +0200
Subject: [LTP] [PATCH] add new testcase for bind
Message-ID: <20180726084620.14645-1-mmoese@suse.de>
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
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/bind/.gitignore |   1 +
 testcases/kernel/syscalls/bind/bind03.c   | 120 ++++++++++++++++++++++
 3 files changed, 122 insertions(+)
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
index 000000000..72045e6b4
--- /dev/null
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -0,0 +1,120 @@
+/*
+ * Copyright (c) 2018 Michael Moese <mmoese@suse.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/* The commit 0fb44559ffd6  af_unix: move unix_mknod() out of bindlock
+ * changed the behavior of bind() for STREAM UNIX domain sockets if
+ */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <err.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "tst_safe_net.h"
+
+#define SOCK_NAME "socket.1"
+
+
+static int sock1, sock2;
+
+static char dir_path[PATH_MAX];
+static char sockpath[PATH_MAX];
+
+void run(void)
+{
+	struct sockaddr_un sun;
+
+	sock1 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
+
+	memset(&sun, 0, sizeof(sun));
+	sun.sun_family = AF_UNIX;
+	if (snprintf(sockpath, sizeof(sockpath), "%s/%s", dir_path, SOCK_NAME)
+	    >= PATH_MAX) {
+		tst_res(TBROK, "bind_test: snprintf(sockpath)");
+		return;
+	}
+	if (snprintf(sun.sun_path, sizeof(sun.sun_path), "%s", sockpath)
+	    >= (int) sizeof(sun.sun_path)) {
+		tst_res(TBROK, "bind_test: snprintf(sun.sun_path)");
+		return;
+	}
+
+	SAFE_BIND(sock1, (struct sockaddr *)&sun, sizeof(sun));
+
+	/*
+	 * Once a STREAM UNIX domain socket has been bound, it can't be
+	 * rebound. Expected error is EINVAL.
+	 * cannot use SAFE_BIND() here.
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
+	 * again, cannot use SAFE_BIND().
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
+
+static void setup(void)
+{
+	strncpy(dir_path, "/tmp/unix_bind.XXXXXXX", PATH_MAX);
+	if (mkdtemp(dir_path) == NULL)
+		tst_res(TBROK, "cannot create temporary directory");
+}
+
+static void cleanup(void)
+{
+	close(sock1);
+	close(sock2);
+	unlink(sockpath);
+	rmdir(dir_path);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.18.0

