From: bxue@redhat.com <bxue@redhat.com>
Date: Wed,  5 Apr 2017 14:55:03 +0800
Subject: [LTP] [PATCH v3 1/1] syscalls/splice04: add test for splice() from
	pipe to pipe
Message-ID: <1491375303-1418-1-git-send-email-bxue@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Boyang Xue <bxue@redhat.com>

This test case covers pipe to pipe splice operation, which was introduced
in kernel commit 7c77f0b3f920 ("splice: implement pipe to pipe splicing").

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/splice04.c | 99 +++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 15ae66e..3a49e7a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1222,6 +1222,7 @@ sockioctl01 sockioctl01
 splice01 splice01
 splice02 seq 1 20000 | splice02 splice02-temp
 splice03 splice03
+splice04 splice04
 
 tee01 tee01
 tee02 tee02
diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
new file mode 100644
index 0000000..61f6b33
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2017 Red Hat, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Boyang Xue <bxue@redhat.com>
+ */
+
+/*
+ * Functional test for splice(2): pipe to pipe
+ *
+ * This test case tests splice(2) from a pipe to another
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define MAX_DATA_LEN (64*1024)
+
+static void setup(void);
+static void cleanup(void);
+static void pipe_pipe(void);
+
+static char *str_len_data;
+static int num_len_data = MAX_DATA_LEN;
+static char *arr_in;
+static char *arr_out;
+
+static struct tst_option options[] = {
+	{"l:", &str_len_data, "-l <num> Length of test data (in bytes)"},
+	{NULL, NULL, NULL},
+};
+
+static void setup(void)
+{
+	int i;
+
+	if (tst_parse_int(str_len_data, &num_len_data, 1, MAX_DATA_LEN))
+		tst_brk(TBROK, "Invalid length of data: '%s'", str_len_data);
+	tst_res(TINFO, "splice size = %d\n", num_len_data);
+	arr_in = SAFE_MALLOC(num_len_data);
+	arr_out = SAFE_MALLOC(num_len_data);
+	for (i = 0; i < num_len_data; i++)
+		arr_in[i] = i & 0xff;
+}
+
+static void cleanup(void)
+{
+	free(arr_in);
+	free(arr_out);
+}
+
+static void pipe_pipe(void)
+{
+	int pp1[2], pp2[2], i;
+
+	SAFE_PIPE(pp1);
+	SAFE_PIPE(pp2);
+	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);
+	if (splice(pp1[0], NULL, pp2[1], NULL, num_len_data, SPLICE_F_MOVE) != num_len_data)
+		tst_res(TFAIL, "incomplete splice operation.");
+	SAFE_READ(1, pp2[0], arr_out, num_len_data);
+
+	SAFE_CLOSE(pp1[1]);
+	SAFE_CLOSE(pp1[0]);
+	SAFE_CLOSE(pp2[1]);
+	SAFE_CLOSE(pp2[0]);
+
+	for (i = 0; i < num_len_data; i++) {
+		if (arr_in[i] != arr_out[i]) {
+			tst_res(TFAIL, "splice(2) from pipe to pipe fails.");
+			return;
+		}
+	}
+	tst_res(TPASS, "splice(2) from pipe to pipe run pass.");
+	return;
+}
+
+static struct tst_test test = {
+	.tid = "splice04",
+	.test_all = pipe_pipe,
+	.setup = setup,
+	.cleanup = cleanup,
+	.options = options,
+	.min_kver = "2.6.31"
+};
-- 
1.8.3.1

