From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jan 2018 17:41:17 +0100
Subject: [LTP] [COMMITTED] [PATCH 4/4] syscalls/[p]write: check for special
	case with NULL buffer and 0 nsize
In-Reply-To: <20180123164117.3052-1-chrubis@suse.cz>
References: <20180123164117.3052-1-chrubis@suse.cz>
Message-ID: <20180123164117.3052-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

From: Carlo Marcelo Arenas Belón <carenas@gmail.com>

As documented, calling write with 0 as nsize is valid and should
return 0.

Passing NULL as a buffer is also valid, and when combined with a size
of 0 has been shown historically to result in a returned value of 0.

SysV and BSD make a point to always return 0, regardless of the buffer
and therefore some software expects a call like write(fd, NULL, 0) to
never fail, so test for that combination as an exception to this test
that looks for an EFAULT.

Signed-off-by: Carlo Marcelo Arenas Belón <carlo@gmail.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  3 ++
 testcases/kernel/syscalls/.gitignore        |  3 ++
 testcases/kernel/syscalls/pwrite/pwrite03.c | 56 +++++++++++++++++++++++++++++
 testcases/kernel/syscalls/write/write02.c   | 56 +++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pwrite/pwrite03.c
 create mode 100644 testcases/kernel/syscalls/write/write02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 94efd2305..2a4fad0a8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -851,10 +851,12 @@ ptrace07 ptrace07
 
 pwrite01 pwrite01
 pwrite02 pwrite02
+pwrite03 pwrite03
 pwrite04 pwrite04
 
 pwrite01_64 pwrite01_64
 pwrite02_64 pwrite02_64
+pwrite03_64 pwrite03_64
 pwrite04_64 pwrite04_64
 
 pwritev01 pwritev01
@@ -1455,6 +1457,7 @@ waitid01 waitid01
 waitid02 waitid02
 
 write01 write01
+write02 write02
 write03 write03
 write04 write04
 write05 write05
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 061948125..67211cad4 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -716,6 +716,8 @@
 /pwrite/pwrite01_64
 /pwrite/pwrite02
 /pwrite/pwrite02_64
+/pwrite/pwrite03
+/pwrite/pwrite03_64
 /pwrite/pwrite04
 /pwrite/pwrite04_64
 /pwritev/pwritev01
@@ -1123,6 +1125,7 @@
 /waitpid/waitpid12
 /waitpid/waitpid13
 /write/write01
+/write/write02
 /write/write03
 /write/write04
 /write/write05
diff --git a/testcases/kernel/syscalls/pwrite/pwrite03.c b/testcases/kernel/syscalls/pwrite/pwrite03.c
new file mode 100644
index 000000000..ef99de49b
--- /dev/null
+++ b/testcases/kernel/syscalls/pwrite/pwrite03.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2017 Carlo Marcelo Arenas Belon <carlo@gmail.com>
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
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
+/*
+ * Tests for a special case NULL buffer with size 0 is expected to return 0.
+ */
+
+#include <errno.h>
+#include "tst_test.h"
+
+static int fd;
+
+static void verify_pwrite(void)
+{
+	TEST(pwrite(fd, NULL, 0, 0));
+
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"pwrite() should have succeeded with ret=0");
+		return;
+	}
+
+	tst_res(TPASS, "pwrite(fd, NULL, 0) == 0");
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN("test_file", O_RDWR | O_CREAT, 0700);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_pwrite,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/write/write02.c b/testcases/kernel/syscalls/write/write02.c
new file mode 100644
index 000000000..3cec43d5f
--- /dev/null
+++ b/testcases/kernel/syscalls/write/write02.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2017 Carlo Marcelo Arenas Belon <carlo@gmail.com>
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
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
+/*
+ * Tests for a special case NULL buffer with size 0 is expected to return 0.
+ */
+
+#include <errno.h>
+#include "tst_test.h"
+
+static int fd;
+
+static void verify_write(void)
+{
+	TEST(write(fd, NULL, 0));
+
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"write() should have succeeded with ret=0");
+		return;
+	}
+
+	tst_res(TPASS, "write(fd, NULL, 0) == 0");
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN("test_file", O_RDWR | O_CREAT, 0700);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_write,
+	.needs_tmpdir = 1,
+};
-- 
2.13.6

