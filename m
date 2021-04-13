From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Apr 2021 06:38:43 +0200
Subject: [LTP] [PATCH v3 1/2] splice02: Generate input in C
Message-ID: <20210413043844.5612-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

instead relying on shell piping data into it.

Found on SLES JeOS (https://progress.opensuse.org/issues/77260).

Also add metadata docs.

Reported-by: Martin Loviska <mloviska@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3:
* fix bugs found by Cyril (use !num_writes, !SAFE_FORK(), break if !TST_RET)

BTW I'm still not sure if break on !TST_RET is needed, but it does not
harm. If you really like it, I can use while (!TST_RET).

Kind regards,
Petr

 runtest/smoketest                           |   2 +-
 runtest/syscalls                            |   2 +-
 testcases/kernel/syscalls/splice/splice02.c | 104 +++++++++++++++++---
 3 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/runtest/smoketest b/runtest/smoketest
index 0c24fc1fa..ec0c088cb 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -11,5 +11,5 @@ symlink01 symlink01
 stat04 symlink01 -T stat04
 utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
-splice02 seq 1 20 | splice02
+splice02 splice02 -n 20
 route4-change-dst route-change-dst.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index 2d1e7b648..b89c545f0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1451,7 +1451,7 @@ socketpair02 socketpair02
 sockioctl01 sockioctl01
 
 splice01 splice01
-splice02 seq 1 20000 | splice02
+splice02 splice02
 splice03 splice03
 splice04 splice04
 splice05 splice05
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index b579667b9..fd71f2995 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -1,40 +1,120 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Jens Axboe <axboe@kernel.dk>, 2009
+ * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*\
+ * [DESCRIPTION]
+ * Original reproducer for kernel fix
+ * bf40d3435caf NFS: add support for splice writes
+ * from v2.6.31-rc1.
+ *
  * http://lkml.org/lkml/2009/4/2/55
+ *
+ * [ALGORITHM]
+ * - create pipe
+ * - fork(), child replace stdin with pipe
+ * - parent write to pipe
+ * - child slice from pipe
+ * - check resulted file size
  */
 
 #define _GNU_SOURCE
 
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/stat.h>
 #include <unistd.h>
-#include <fcntl.h>
 
 #include "tst_test.h"
 #include "lapi/splice.h"
 
-#define SPLICE_SIZE (64*1024)
+#define WRITE_SIZE 1024
+#define TEST_FILENAME "splice02-temp"
+
+static char *narg;
+static int num_writes;
+static int pipe_fd[2];
+
+static void setup(void)
+{
+	if (tst_parse_int(narg, &num_writes, 1, INT_MAX))
+		tst_brk(TBROK, "invalid number of writes '%s'", narg);
+}
 
-static void splice_test(void)
+static void do_child(void)
 {
-	int fd;
+	int fd, to_write = num_writes;
+	struct stat st;
+
+	SAFE_CLOSE(pipe_fd[1]);
+	SAFE_DUP2(pipe_fd[0], STDIN_FILENO);
 
-	fd = SAFE_OPEN("splice02-temp", O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	fd = SAFE_OPEN(TEST_FILENAME, O_WRONLY | O_CREAT | O_TRUNC, 0644);
 
-	TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
-	if (TST_RET < 0) {
-		tst_res(TFAIL, "splice failed - errno = %d : %s",
-			TST_ERR, strerror(TST_ERR));
-	} else {
-		tst_res(TPASS, "splice() system call Passed");
+	while (to_write > 0) {
+		TEST(splice(STDIN_FILENO, NULL, fd, NULL, WRITE_SIZE, 0));
+		tst_res(TINFO, "splice() wrote %ld, remaining %d", TST_RET, to_write);
+		if (TST_RET < 0) {
+			tst_res(TFAIL | TTERRNO, "splice failed");
+			goto cleanup;
+		} else if (!TST_RET) {
+			break;
+		} else {
+			to_write -= TST_RET;
+		}
 	}
 
+	stat(TEST_FILENAME, &st);
+	if (st.st_size != num_writes) {
+		tst_res(TFAIL, "file size is different from expected: %d (%d)",
+				st.st_size, num_writes);
+		return;
+	}
+
+	tst_res(TPASS, "splice() system call passed");
+
+cleanup:
 	SAFE_CLOSE(fd);
+	exit(0);
+}
+
+static void run(void)
+{
+	int i, max_pipe_size;
+
+	SAFE_PIPE(pipe_fd);
+
+	if (!num_writes) {
+		max_pipe_size = SAFE_FCNTL(pipe_fd[1], F_GETPIPE_SZ);
+		num_writes = max_pipe_size << 2;
+	}
+
+	if (!SAFE_FORK())
+		do_child();
+
+	tst_res(TINFO, "writting %d times", num_writes);
+
+	for (i = 0; i < num_writes; i++)
+		SAFE_WRITE(1, pipe_fd[1], "x", 1);
+
+	tst_reap_children();
+
+	SAFE_CLOSE(pipe_fd[0]);
+	SAFE_CLOSE(pipe_fd[1]);
 }
 
 static struct tst_test test = {
-	.test_all = splice_test,
+	.test_all = run,
+	.setup = setup,
+	.needs_checkpoints = 1,
 	.needs_tmpdir = 1,
+	.forks_child = 1,
 	.min_kver = "2.6.17",
+	.options = (struct tst_option[]) {
+		{"n:", &narg, "-n x     Number of writes (default 2x max pipe size)"},
+		{}
+	},
 };
-- 
2.31.1

