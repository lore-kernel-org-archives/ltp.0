From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  7 Aug 2018 16:25:49 +0200
Subject: [LTP] [PATCH] lib: Fix result propagation after exec() +
	tst_reinit()
Message-ID: <20180807142549.13877-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The result pointer wasn't initialized in tst_reinit(), which haven't
allowed for test result propagation to the main test process and there
is actually no reason not to do that. So this commit initializes the
results pointer in tst_reinit() and also adds a child_needs_reinit flag
to tst_test structure, which causes the library not to unlink the IPC
file after it has been mapped and also inserts LTP_IPC_PATH to the
environment.

This commit also adds a test that also shows the usage of the API and
documentation.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Eddie Horng <eddiehorng.tw@gmail.com>
---
 doc/test-writing-guidelines.txt    | 40 +++++++++++++++++++++++++++++++++++
 include/tst_test.h                 |  1 +
 lib/newlib_tests/.gitignore        |  2 ++
 lib/newlib_tests/test_exec.c       | 43 ++++++++++++++++++++++++++++++++++++++
 lib/newlib_tests/test_exec_child.c | 27 ++++++++++++++++++++++++
 lib/tst_test.c                     |  7 +++----
 6 files changed, 116 insertions(+), 4 deletions(-)
 create mode 100644 lib/newlib_tests/test_exec.c
 create mode 100644 lib/newlib_tests/test_exec_child.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index b6b394590..a16972430 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -692,6 +692,46 @@ The 'tst_reap_children()' function makes the process wait for all of its
 children and exits with 'tst_brk(TBROK, ...)' if any of them returned
 a non zero exit code.
 
+.Using tst_res() from binaries started by exec()
+[source,c]
+-------------------------------------------------------------------------------
+/* test.c */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	char *const argv[] = {"test_exec_child", NULL};
+
+	execvpe(argv[0], argv, environ);
+
+	tst_res(TBROK | TERRNO, "EXEC!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.child_needs_reinit = 1,
+};
+
+/* test_exec_child.c */
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int main(void)
+{
+	tst_reinit();
+	tst_res(TPASS, "Child passed!");
+	return 0;
+}
+-------------------------------------------------------------------------------
+
+The 'tst_res()' function can be also used from binaries started by 'exec()',
+the parent test process has to set the '.child_needs_reinit' flag so that the
+library prepares for it and has to make sure the 'LTP_IPC_PATH' environment
+vairiable is passed down, then the very fist thing the program has to call in
+'main()' is 'tst_reinit()' that sets up the IPC.
+
 2.2.9 Fork() and Parent-child synchronization
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/tst_test.h b/include/tst_test.h
index 90938bc29..98dacf387 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -127,6 +127,7 @@ struct tst_test {
 	int format_device:1;
 	int mount_device:1;
 	int needs_rofs:1;
+	int child_needs_reinit:1;
 	/*
 	 * If set the test function will be executed for all available
 	 * filesystems and the current filesytem type would be set in the
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 8c0981ec8..99edc6404 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -20,3 +20,5 @@ tst_res_hexd
 tst_strstatus
 test17
 tst_expiration_timer
+test_exec
+test_exec_child
diff --git a/lib/newlib_tests/test_exec.c b/lib/newlib_tests/test_exec.c
new file mode 100644
index 000000000..8aef62176
--- /dev/null
+++ b/lib/newlib_tests/test_exec.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*
+ * Assert that tst_res() from child started by exec() is propagated to the main
+ * test process.
+ *
+ * This test should be executed as:
+ * $ PATH=$PATH:$PWD ./test_exec
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	char *const argv[] = {"test_exec_child", NULL};
+
+	execvpe(argv[0], argv, environ);
+
+	tst_res(TBROK | TERRNO, "EXEC!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.child_needs_reinit = 1,
+};
diff --git a/lib/newlib_tests/test_exec_child.c b/lib/newlib_tests/test_exec_child.c
new file mode 100644
index 000000000..696ff5be2
--- /dev/null
+++ b/lib/newlib_tests/test_exec_child.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int main(void)
+{
+	tst_reinit();
+	tst_res(TPASS, "Child passed!");
+	return 0;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 008bcefe0..2f3d357d2 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -105,7 +105,7 @@ static void setup_ipc(void)
 	results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, ipc_fd, 0);
 
 	/* Checkpoints needs to be accessible from processes started by exec() */
-	if (tst_test->needs_checkpoints) {
+	if (tst_test->needs_checkpoints || tst_test->child_needs_reinit) {
 		sprintf(ipc_path, IPC_ENV_VAR "=%s", shm_path);
 		putenv(ipc_path);
 	} else {
@@ -141,7 +141,6 @@ void tst_reinit(void)
 	const char *path = getenv(IPC_ENV_VAR);
 	size_t size = getpagesize();
 	int fd;
-	void *ptr;
 
 	if (!path)
 		tst_brk(TBROK, IPC_ENV_VAR" is not defined");
@@ -151,8 +150,8 @@ void tst_reinit(void)
 
 	fd = SAFE_OPEN(path, O_RDWR);
 
-	ptr = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	tst_futexes = (char*)ptr + sizeof(struct results);
+	results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	tst_futexes = (char*)results + sizeof(struct results);
 	tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
 
 	SAFE_CLOSE(fd);
-- 
2.13.6

