From: bxue@redhat.com <bxue@redhat.com>
Date: Tue,  2 May 2017 11:59:58 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/splice05: add test for splice()
	between pipe and socket
In-Reply-To: <1493697598-9327-1-git-send-email-bxue@redhat.com>
References: <1493697598-9327-1-git-send-email-bxue@redhat.com>
Message-ID: <1493697598-9327-3-git-send-email-bxue@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Boyang Xue <bxue@redhat.com>

This test case covers splice operation between pipe and socket.

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
 .gitignore                                  |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/splice/splice05.c | 134 ++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice05.c

diff --git a/.gitignore b/.gitignore
index a1bd857..b9614f7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,3 +77,4 @@ logfile.*
 /lib/tests/tst_dataroot02
 /lib/tests/tst_dataroot03
 /testcases/kernel/syscalls/splice/splice04
+/testcases/kernel/syscalls/splice/splice05
diff --git a/runtest/syscalls b/runtest/syscalls
index d6c9ab4..0fae11a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1225,6 +1225,7 @@ splice01 splice01
 splice02 seq 1 20000 | splice02 splice02-temp
 splice03 splice03
 splice04 splice04
+splice05 splice05
 
 tee01 tee01
 tee02 tee02
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
new file mode 100644
index 0000000..f5ab735
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -0,0 +1,134 @@
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
+ * Functional test for splice(2): pipe <-> socket
+ *
+ * This test case tests splice(2) from a pipe to a socket and vice versa
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include "tst_test.h"
+
+#define PIPE_MAX (64*1024)
+
+static char *arr_in, *arr_out;
+static char *str_len_data;
+static int num_len_data = PIPE_MAX;
+static int pp0[2], pp1[2], sv[2];
+
+static struct tst_option options[] = {
+	{"l:", &str_len_data, "-l <num> Length of test data (in bytes)"},
+	{NULL, NULL, NULL},
+};
+
+static void setup(void)
+{
+	int i, fd, pipe_max_unpriv, pipe_limit;
+	FILE *s;
+
+	fd = SAFE_OPEN("/proc/sys/fs/pipe-max-size", O_RDONLY);
+	s = fdopen(fd, "r");
+	if (s == NULL)
+		tst_brk(TBROK, "fdopen() error");
+	if (fscanf(s, "%d", &pipe_max_unpriv) != 1)
+		tst_brk(TBROK, "Fail to get value of /proc/sys/fs/pipe-max-size");
+	else {
+		pipe_limit = pipe_max_unpriv < num_len_data ? pipe_max_unpriv : num_len_data;
+		num_len_data = pipe_limit;
+	}
+	if (fclose(s) == EOF)
+		tst_brk(TBROK, "Fail to close file");
+
+	if (tst_parse_int(str_len_data, &num_len_data, 1, pipe_limit))
+		tst_brk(TBROK, "Invalid length of data: '%s', valid value: [1, %d]", str_len_data, pipe_limit);
+	tst_res(TINFO, "splice size = %d", num_len_data);
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
+static void pipe_socket(void)
+{
+	int i, ret;
+
+	SAFE_PIPE(pp0);
+	SAFE_PIPE(pp1);
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv))
+		tst_brk(TBROK | TERRNO, "fail to create socket pair.");
+
+	SAFE_WRITE(1, pp0[1], arr_in, num_len_data);
+	do {
+		ret = splice(pp0[0], NULL, sv[0], 0, num_len_data, SPLICE_F_MOVE);
+		if (ret == 0)
+			break;
+		else if (ret == -1) {
+			tst_res(TFAIL | TERRNO, "splice error");
+			goto exit;
+		}
+	} while (num_len_data - ret);
+	do {
+		ret = splice(sv[1], 0, pp1[1], NULL, num_len_data, SPLICE_F_MOVE);
+		if (ret == 0)
+			break;
+		else if (ret == -1) {
+			tst_res(TFAIL | TERRNO, "splice error");
+			goto exit;
+		}
+	} while (num_len_data - ret);
+	SAFE_READ(1, pp1[0], arr_out, num_len_data);
+
+	for (i = 0; i < num_len_data; i++) {
+		if (arr_in[i] != arr_out[i]) {
+			tst_res(TFAIL, "wrong data@%d: expected: %d, actual %d", i, arr_in[i], arr_out[i]);
+			goto exit;
+		}
+	}
+	tst_res(TPASS, "splice(2): pipe <-> socket run pass.");
+exit:
+	for (i = 0; i < 2; i++) {
+		SAFE_CLOSE(pp0[i]);
+		SAFE_CLOSE(pp1[i]);
+		SAFE_CLOSE(sv[i]);
+	}
+}
+
+static struct tst_test test = {
+	.tid = "splice05",
+	.test_all = pipe_socket,
+	.setup = setup,
+	.cleanup = cleanup,
+	.options = options,
+	.min_kver = "2.6.17"
+};
-- 
1.8.3.1

