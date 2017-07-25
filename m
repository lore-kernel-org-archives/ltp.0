From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Tue, 25 Jul 2017 14:29:12 +0200
Subject: [LTP]  [PATCH v3] getsockopt: Add test for SO_PEERCRED
Message-ID: <1500985752-9239-1-git-send-email-vkabatov@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Veronika Kabatova <vkabatov@redhat.com>

Connect to a socket from a fork and check SO_PEERCRED returns
correct PID.

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/.gitignore               |  1 +
 .../kernel/syscalls/getsockopt/getsockopt02.c      | 99 ++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getsockopt/getsockopt02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2e79ab9..c85c713 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -434,6 +434,7 @@ getsid02 getsid02
 getsockname01 getsockname01
 
 getsockopt01 getsockopt01
+getsockopt02 getsockopt02
 
 gettid01 gettid01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index fdb01f9..958bd7a 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -362,6 +362,7 @@
 /getsid/getsid02
 /getsockname/getsockname01
 /getsockopt/getsockopt01
+/getsockopt/getsockopt02
 /gettid/gettid01
 /gettimeofday/gettimeofday01
 /gettimeofday/gettimeofday02
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt02.c b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
new file mode 100644
index 0000000..edf9dd8
--- /dev/null
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test description: Test retrieving of peer credentials (SO_PEERCRED)
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+static int socket_fd, accepted;
+static struct sockaddr_un sun;
+
+#define SOCKNAME	"testsocket"
+
+static void setup(void)
+{
+	sun.sun_family = AF_UNIX;
+	(void)strcpy(sun.sun_path, SOCKNAME);
+	socket_fd = SAFE_SOCKET(sun.sun_family, SOCK_STREAM, 0);
+	SAFE_BIND(socket_fd, (struct sockaddr *)&sun, sizeof(sun));
+	SAFE_LISTEN(socket_fd, SOMAXCONN);
+}
+
+static void fork_func(void)
+{
+	int fork_socket_fd = SAFE_SOCKET(sun.sun_family, SOCK_STREAM, 0);
+
+	SAFE_CONNECT(fork_socket_fd, (struct sockaddr *)&sun, sizeof(sun));
+	TST_CHECKPOINT_WAIT(0);
+	SAFE_CLOSE(fork_socket_fd);
+	exit(0);
+}
+
+static void test_function(void)
+{
+	pid_t fork_id;
+	struct ucred cred;
+	socklen_t cred_len = sizeof(cred);
+
+	fork_id = SAFE_FORK();
+	if (!fork_id)
+		fork_func();
+
+	accepted = accept(socket_fd, NULL, NULL);
+	if (accepted < 0) {
+		tst_res(TFAIL | TERRNO, "Error with accepting connection");
+		goto clean;
+	}
+	if (getsockopt(accepted, SOL_SOCKET,
+				SO_PEERCRED, &cred, &cred_len) < 0) {
+		tst_res(TFAIL | TERRNO, "Error while getting socket option");
+		goto clean;
+	}
+
+	if (fork_id != cred.pid)
+		tst_res(TFAIL, "Received wrong PID %d, expected %d",
+				cred.pid, getpid());
+	else
+		tst_res(TPASS, "Test passed");
+clean:
+	if (accepted >= 0)
+		SAFE_CLOSE(accepted);
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static void cleanup(void)
+{
+	if (accepted >= 0)
+		SAFE_CLOSE(accepted);
+	if (socket_fd >= 0)
+		SAFE_CLOSE(socket_fd);
+}
+
+static struct tst_test test = {
+	.test_all = test_function,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.7.4

