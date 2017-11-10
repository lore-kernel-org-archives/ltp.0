From: Lucas Boehm <lucas@opentech.at>
Date: Fri, 10 Nov 2017 09:56:47 +0100
Subject: [LTP] [PATCH] syscall/read: add new testcase for read
Message-ID: <20171110085647.28127-1-lucas@opentech.at>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 Check the return value of read
 1. Count bytes are read from the current file
 2. Current offset is modified by lseek()
 3. Count bytes are read from the current file

Signed-off-by: Lucas Boehm <lucas@opentech.at>
---
 testcases/kernel/syscalls/read/read05.c | 76 +++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 testcases/kernel/syscalls/read/read05.c

diff --git a/testcases/kernel/syscalls/read/read05.c b/testcases/kernel/syscalls/read/read05.c
new file mode 100644
index 000000000..49ef053fc
--- /dev/null
+++ b/testcases/kernel/syscalls/read/read05.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright (c) 2017 Lucas Boehm <lucas@opentech.at>
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
+
+ /* Check the return value of read
+ *
+ * 1. Count bytes are read from the current file
+ * 2. Current offset is modified by lseek()
+ * 3. Return value equals read
+ */
+
+#include <errno.h>
+#include "tst_test.h"
+#include <stdio.h>
+
+#define SIZE 512
+
+static int fd;
+static char buf[SIZE];
+int pos;
+
+static void verify_read(void)
+{
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+
+	TEST(read(fd, buf, SIZE/2));
+
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "read(2) failed");
+	else
+		tst_res(TPASS, "read(2) returned %ld", TEST_RETURN);
+
+
+	SAFE_LSEEK(fd, 2, SEEK_CUR);
+
+	TEST(read(fd, buf, SIZE/2));
+
+
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "read(2) failed");
+	else
+		tst_res(TPASS, "read(2) returned %ld", TEST_RETURN);
+}
+
+static void setup(void)
+{
+	memset(buf, '*', SIZE);
+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
+	SAFE_WRITE(1, fd, buf, SIZE);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_read,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.11.0

