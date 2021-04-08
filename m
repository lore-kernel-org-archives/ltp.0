From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  8 Apr 2021 20:45:02 +0200
Subject: [LTP] [PATCH 1/2] splice02: Generate input in C
Message-ID: <20210408184503.28414-1-pvorel@suse.cz>
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
changes v1->v2:
* writing in loop (Cyril), that allowed to drop TST_CHECKPOINT_*()
* default number of writes is 2x max pipe size
* fixed problems reported by Cyril (drop redundant close(STDIN_FILENO),
  better phrase error message).

NOTE: I kept verbose output to make behavior easier for reviewers.
Mainly to see if write size and whole behavior is ok (please do run the
test). But before merge I guess I should then delete:
tst_res(TINFO, "splice() wrote %ld, remaining %d", TST_RET, to_write);

I haven't compared file content (Cyril), only checked size.

Kind regards,
Petr

 runtest/smoketest                           |   2 +-
 runtest/syscalls                            |   2 +-
 testcases/kernel/syscalls/splice/splice02.c | 102 +++++++++++++++++---
 3 files changed, 92 insertions(+), 14 deletions(-)

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
index b579667b9..20bf91fb1 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -1,40 +1,118 @@
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
+static int num_writes = -1;
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
+	if (num_writes == -1) {
+		max_pipe_size = SAFE_FCNTL(pipe_fd[1], F_GETPIPE_SZ);
+		num_writes = max_pipe_size << 2;
+	}
+
+	if (SAFE_FORK())
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
2.30.2

