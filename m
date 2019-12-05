From: Jorik Cronenberg <jcronenberg@suse.de>
Date: Thu,  5 Dec 2019 09:58:03 +0100
Subject: [LTP] [PATCH v2]syscalls/vmsplice: Add testcase
Message-ID: <20191205085803.24636-1-jcronenberg@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add vmsplice03 to test splicing from a pipe to user memory.

Signed-off-by: Jorik Cronenberg <jcronenberg@suse.de>
---

V2:

Fixed issues pointed out by Cyril

 testcases/kernel/syscalls/vmsplice/.gitignore |  1 +
 .../kernel/syscalls/vmsplice/vmsplice03.c     | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 testcases/kernel/syscalls/vmsplice/vmsplice03.c

diff --git a/testcases/kernel/syscalls/vmsplice/.gitignore b/testcases/kernel/syscalls/vmsplice/.gitignore
index 2cc74a956..03922073c 100644
--- a/testcases/kernel/syscalls/vmsplice/.gitignore
+++ b/testcases/kernel/syscalls/vmsplice/.gitignore
@@ -1,2 +1,3 @@
 /vmsplice01
 /vmsplice02
+/vmsplice03
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice03.c b/testcases/kernel/syscalls/vmsplice/vmsplice03.c
new file mode 100644
index 000000000..88a387906
--- /dev/null
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice03.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Jorik Cronenberg <jcronenberg@suse.de>
+ *
+ * Test vmsplice() from a pipe into user memory
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/vmsplice.h"
+
+
+#define TEST_BLOCK_SIZE (64*1024)	/* 64K */
+
+static char buffer[TEST_BLOCK_SIZE];
+
+static void vmsplice_test(void)
+{
+	int written, i;
+	int pipes[2];
+	struct iovec iov;
+	char arr_write[TEST_BLOCK_SIZE];
+
+	iov.iov_base = arr_write;
+	iov.iov_len = TEST_BLOCK_SIZE;
+	memset(arr_write, 0, TEST_BLOCK_SIZE);
+
+	SAFE_PIPE(pipes);
+	SAFE_WRITE(1, pipes[1], buffer, TEST_BLOCK_SIZE);
+	written = vmsplice(pipes[0], &iov, 1, 0);
+
+	if (written < 0)
+		tst_brk(TBROK | TERRNO, "vmsplice() failed");
+
+	if (written == 0)
+		tst_res(TFAIL, "vmsplice() didn't write anything");
+	else {
+		for (i = 0; i < TEST_BLOCK_SIZE; i++) {
+			if (arr_write[i] != buffer[i]) {
+				tst_res(TFAIL,
+					"Wrong data in user memory@%i", i);
+				break;
+			}
+		}
+		if (i == written)
+			tst_res(TPASS, "Spliced correctly into user memory");
+	}
+
+	SAFE_CLOSE(pipes[1]);
+	SAFE_CLOSE(pipes[0]);
+}
+
+static void setup(void)
+{
+	int i;
+
+	for (i = 0; i < TEST_BLOCK_SIZE; i++)
+		buffer[i] = i & 0xff;
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = vmsplice_test,
+	.min_kver = "2.6.23",
+};
-- 
2.24.0

