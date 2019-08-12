From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Aug 2019 16:39:31 +0200
Subject: [LTP] [PATCH v2 01/11] lib: Add support for guarded buffers
In-Reply-To: <20190812143941.8119-1-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
Message-ID: <20190812143941.8119-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds a support for guarder buffers. Guarded buffer is a
buffer allocated so that there is PROT_NONE page immediatelly after the
end of the buffer i.e. any access after the buffer generates
SEGFAULT/EFAULT etc.

The library is hooked into the tst_test structure so that all you need
is to fill up an NULL terminated array of buffer pointers and sizes to
get the respective buffers allocated. This library supports allocating
memory in test runtime as well as well as allocating more complex
buffers, which currently are iovec vectors.

All buffers are freeed automatically at the end of the test.

Example usage looks like:

static struct foo *foo_ptr;
static struct iovec *iov;
static void *buf_ptr;
static char *id;
...

static void run(void)
{
	...

	foo_ptr->bar = 1;
	foo_ptr->buf = buf_ptr;

	...
}

static void setup(void)
{
	...

	id = tst_strdup(string);

	...
}

static struct tst_test test = {
	...
	.bufs = (struct tst_buffers []) {
		{&foo_ptr, .size = sizeof(*foo_ptr)},
		{&buf_ptr, .size = BUF_SIZE},
		{&iov, .iov_sizes = (int[]){128, 32, -1},
		{}
	}
};

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_buffers.h               |  63 ++++++++++++++++
 include/tst_test.h                  |   6 ++
 lib/newlib_tests/.gitignore         |   1 +
 lib/newlib_tests/test_guarded_buf.c |  78 +++++++++++++++++++
 lib/tst_buffers.c                   | 111 ++++++++++++++++++++++++++++
 lib/tst_test.c                      |   5 ++
 6 files changed, 264 insertions(+)
 create mode 100644 include/tst_buffers.h
 create mode 100644 lib/newlib_tests/test_guarded_buf.c
 create mode 100644 lib/tst_buffers.c

diff --git a/include/tst_buffers.h b/include/tst_buffers.h
new file mode 100644
index 000000000..d19ac8cf0
--- /dev/null
+++ b/include/tst_buffers.h
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_BUFFERS_H__
+#define TST_BUFFERS_H__
+
+/*
+ * Buffer description consist of a pointer to a pointer and buffer type/size
+ * encoded as a different structure members.
+ *
+ * Only one of the size and iov_sizes can be set at a time.
+ */
+struct tst_buffers {
+	/*
+	 * This pointer points to a buffer pointer.
+	 */
+	void *ptr;
+	/*
+	 * Buffer size.
+	 */
+	size_t size;
+	/*
+	 * Array of iov buffer sizes terminated by -1.
+	 */
+	int *iov_sizes;
+};
+
+/*
+ * Allocates buffers based on the tst_buffers structure.
+ *
+ * @bufs NULL terminated array of test buffer descriptions.
+ *
+ * This is called from the test library if the tst_test->bufs pointer is set.
+ */
+void tst_buffers_alloc(struct tst_buffers bufs[]);
+
+/*
+ * strdup() that callls tst_alloc().
+ */
+char *tst_strdup(const char *str);
+
+/*
+ * Allocates size bytes, returns pointer to the allocated buffer.
+ */
+void *tst_alloc(size_t size);
+
+/*
+ * Allocates iovec structure including the buffers.
+ *
+ * @sizes -1 terminated array of buffer sizes.
+ */
+struct iovec *tst_iovec_alloc(int sizes[]);
+
+/*
+ * Frees all allocated buffers.
+ *
+ * This is called at the end of the test automatically.
+ */
+void tst_free_all(void);
+
+#endif	/* TST_BUFFERS_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 2e07ff16b..cdeaf6ad0 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -35,6 +35,7 @@
 #include "tst_path_has_mnt_flags.h"
 #include "tst_sys_conf.h"
 #include "tst_coredump.h"
+#include "tst_buffers.h"
 
 /*
  * Reports testcase result.
@@ -200,6 +201,11 @@ struct tst_test {
 	 * test.
 	 */
 	const char *const *needs_kconfigs;
+
+	/*
+	 * NULL-terminated array to be allocated buffers.
+	 */
+	struct tst_buffers *bufs;
 };
 
 /*
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index d92b89872..6788ddf90 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -26,3 +26,4 @@ test_exec
 test_exec_child
 test_kconfig
 variant
+test_guarded_buf
diff --git a/lib/newlib_tests/test_guarded_buf.c b/lib/newlib_tests/test_guarded_buf.c
new file mode 100644
index 000000000..2951dce23
--- /dev/null
+++ b/lib/newlib_tests/test_guarded_buf.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that acces after guarded buffer causes segfault.
+ */
+
+#include <stdlib.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+
+#define BUF1_LEN 10
+#define BUF2_LEN 4096
+#define BUF3_LEN 12004
+
+static char *buf1;
+static char *buf2;
+static char *buf3;
+
+static void do_test(unsigned int n)
+{
+	int pid = SAFE_FORK();
+	int status;
+
+	if (!pid) {
+		switch (n) {
+		case 0:
+			buf1[BUF1_LEN - 1] = 0;
+		break;
+		case 1:
+			buf2[BUF2_LEN - 1] = 0;
+		break;
+		case 2:
+			buf3[BUF3_LEN - 1] = 0;
+		break;
+		case 3:
+			buf1[BUF1_LEN] = 0;
+		break;
+		case 4:
+			buf2[BUF2_LEN] = 0;
+		break;
+		case 5:
+			buf3[BUF3_LEN] = 0;
+		break;
+		}
+
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (n < 3) {
+		if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+			tst_res(TPASS, "Exitted normally");
+			return;
+		}
+	} else {
+		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+			tst_res(TPASS, "Killed by SIGSEGV");
+			return;
+		}
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.test = do_test,
+	.tcnt = 6,
+	.bufs = (struct tst_buffers []) {
+		{&buf1, .size = BUF1_LEN},
+		{&buf2, .size = BUF2_LEN},
+		{&buf3, .size = BUF3_LEN},
+	}
+};
diff --git a/lib/tst_buffers.c b/lib/tst_buffers.c
new file mode 100644
index 000000000..4f3bbe68e
--- /dev/null
+++ b/lib/tst_buffers.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <sys/mman.h>
+#include <stdlib.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+struct map {
+	void *addr;
+	size_t size;
+	struct map *next;
+};
+
+static struct map *maps;
+
+void *tst_alloc(size_t size)
+{
+	size_t page_size = getpagesize();
+	unsigned int pages = (size / page_size) + !!(size % page_size) + 1;
+	void *ret;
+	struct map *map = SAFE_MALLOC(sizeof(struct map));
+	static int print_msg = 1;
+
+	if (print_msg) {
+		tst_res(TINFO, "Test is using guarded buffers");
+		print_msg = 0;
+	}
+
+	ret = SAFE_MMAP(NULL, page_size * pages, PROT_READ | PROT_WRITE,
+	                MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
+	mprotect(ret + (pages-1) * page_size, page_size, PROT_NONE);
+
+	map->addr = ret;
+	map->size = pages * page_size;
+	map->next = maps;
+	maps = map;
+
+	if (size % page_size)
+		ret += page_size - (size % page_size);
+
+	return ret;
+}
+
+static int count_iovec(int *sizes)
+{
+	int ret = 0;
+
+	while (sizes[ret++] != -1);
+
+	return ret - 1;
+}
+
+struct iovec *tst_iovec_alloc(int sizes[])
+{
+	int i, cnt = count_iovec(sizes);
+	struct iovec *iovec;
+
+	if (cnt <= 0)
+		return NULL;
+
+	iovec = tst_alloc(sizeof(struct iovec) * cnt);
+
+	for (i = 0; i < cnt; i++) {
+		if (sizes[i]) {
+			iovec[i].iov_base = tst_alloc(sizes[i]);
+			iovec[i].iov_len = sizes[i];
+		} else {
+			iovec[i].iov_base = NULL;
+			iovec[i].iov_base = 0;
+		}
+	}
+
+	return iovec;
+}
+
+void tst_buffers_alloc(struct tst_buffers bufs[])
+{
+	unsigned int i;
+
+	for (i = 0; bufs[i].ptr; i++) {
+		if (bufs[i].size)
+			*((void**)bufs[i].ptr) = tst_alloc(bufs[i].size);
+		else
+			*((void**)bufs[i].ptr) = tst_iovec_alloc(bufs[i].iov_sizes);
+	}
+}
+
+char *tst_strdup(const char *str)
+{
+	size_t len = strlen(str);
+	char *ret = tst_alloc(len + 1);
+	return strcpy(ret, str);
+}
+
+void tst_free_all(void)
+{
+	struct map *i = maps;
+
+	while (i) {
+		struct map *j = i;
+		SAFE_MUNMAP(i->addr, i->size);
+		i = i->next;
+		free(j);
+	}
+
+	maps = NULL;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 245e287fa..8dc71dbb3 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -283,6 +283,8 @@ static void do_test_cleanup(void)
 	if (tst_test->cleanup)
 		tst_test->cleanup();
 
+	tst_free_all();
+
 	tst_brk_handler = tst_vbrk_;
 }
 
@@ -802,6 +804,9 @@ static void do_setup(int argc, char *argv[])
 
 	setup_ipc();
 
+	if (tst_test->bufs)
+		tst_buffers_alloc(tst_test->bufs);
+
 	if (needs_tmpdir() && !tst_tmpdir_created())
 		tst_tmpdir();
 
-- 
2.21.0

