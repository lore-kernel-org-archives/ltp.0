From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  8 Mar 2021 16:44:21 +0100
Subject: [LTP] [PATCH] splice02: Generate input in C
Message-ID: <20210308154421.2002-1-pvorel@suse.cz>
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
Hi,

Hope using TST_CHECKPOINT_*() correctly.
Not using tst_tag for such old kernel.

Kind regards,
Petr

 runtest/smoketest                           |  2 +-
 runtest/syscalls                            |  2 +-
 testcases/kernel/syscalls/splice/splice02.c | 67 ++++++++++++++++++++-
 3 files changed, 66 insertions(+), 5 deletions(-)

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
index fe22ae5b6..355e71144 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1446,7 +1446,7 @@ socketpair02 socketpair02
 sockioctl01 sockioctl01
 
 splice01 splice01
-splice02 seq 1 20000 | splice02
+splice02 splice02 -n 20000
 splice03 splice03
 splice04 splice04
 splice05 splice05
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index b579667b9..6e183ac7e 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -1,9 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Jens Axboe <axboe@kernel.dk>, 2009
- * http://lkml.org/lkml/2009/4/2/55
+ * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
  */
 
+/*\
+ * [DESCRIPTION]
+ * Original reproducer for kernel fix
+ * bf40d3435caf NFS: add support for splice writes
+ * from v2.6.31-rc1.
+ *
+ * http://lkml.org/lkml/2009/4/2/55
+ *
+ * [ALGORITHM]
+ * - create pipe
+ * - fork(), child replace stdin with pipe
+ * - parent write to pipe
+ * - child slice from pipe
+\*/
+
 #define _GNU_SOURCE
 
 #include <stdio.h>
@@ -15,11 +30,27 @@
 #include "lapi/splice.h"
 
 #define SPLICE_SIZE (64*1024)
+#define DEFAULT_NARG 20000
 
-static void splice_test(void)
+static char *narg;
+static int num = DEFAULT_NARG;
+static int pipe_fd[2];
+
+static void setup(void)
+{
+	if (tst_parse_int(narg, &num, 1, INT_MAX))
+		tst_brk(TBROK, "invalid number of input '%s'", narg);
+}
+
+static void do_child(void)
 {
 	int fd;
 
+	SAFE_CLOSE(pipe_fd[1]);
+	close(STDIN_FILENO);
+	SAFE_DUP2(pipe_fd[0], STDIN_FILENO);
+
+	TST_CHECKPOINT_WAIT(0);
 	fd = SAFE_OPEN("splice02-temp", O_WRONLY | O_CREAT | O_TRUNC, 0644);
 
 	TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
@@ -31,10 +62,40 @@ static void splice_test(void)
 	}
 
 	SAFE_CLOSE(fd);
+
+	exit(0);
+}
+
+static void run(void)
+{
+	int i;
+
+	SAFE_PIPE(pipe_fd);
+
+	if (SAFE_FORK())
+		do_child();
+
+	tst_res(TINFO, "writting %d times", num);
+
+	for (i = 0; i < num; i++)
+		SAFE_WRITE(1, pipe_fd[1], "x", 1);
+
+	TST_CHECKPOINT_WAKE(0);
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
+		{"n:", &narg, "-n x     Number of input"},
+		{}
+	},
 };
-- 
2.30.1

