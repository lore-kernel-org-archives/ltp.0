From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  1 Aug 2019 11:26:08 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190801092616.30553-1-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
Message-ID: <20190801092616.30553-2-chrubis@suse.cz>
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
get the respective buffers allocated. The library supports allocating
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

	id = strdup(string);

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
 include/tst_buffers.h                       |  63 ++++++++++++
 include/tst_test.h                          |   6 ++
 lib/newlib_tests/.gitignore                 |   1 +
 lib/newlib_tests/test_guarded_buf.c         |  78 ++++++++++++++
 lib/tst_buffers.c                           | 106 ++++++++++++++++++++
 lib/tst_test.c                              |   5 +
 testcases/kernel/syscalls/accept/accept02.c |  41 ++++----
 7 files changed, 281 insertions(+), 19 deletions(-)
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
index 000000000..c4b2859d1
--- /dev/null
+++ b/lib/tst_buffers.c
@@ -0,0 +1,106 @@
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
+		tst_res(TINFO, "Freeing %p %zu", i->addr, i->size);
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
 
diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index df048ede4..1a0f625c9 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -33,10 +33,9 @@ static int client_sockfd;
 static int server_port;
 static socklen_t addr_len;
 
-static struct sockaddr_in server_addr;
-static struct sockaddr_in client_addr;
-static struct group_req mc_group;
-
+static struct sockaddr_in *server_addr;
+static struct sockaddr_in *client_addr;
+static struct group_req *mc_group;
 
 static void *server_thread(void *arg)
 {
@@ -44,27 +43,27 @@ static void *server_thread(void *arg)
 
 	op = 1;
 	op_len = sizeof(op);
-	mc_group_len = sizeof(mc_group);
+	mc_group_len = sizeof(*mc_group);
 
 	server_sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
 
 	SAFE_SETSOCKOPT(server_sockfd, SOL_SOCKET, SO_REUSEADDR, &op, op_len);
 	SAFE_SETSOCKOPT(server_sockfd, SOL_IP, MCAST_JOIN_GROUP,
-			&mc_group, mc_group_len);
+			mc_group, mc_group_len);
 
-	SAFE_BIND(server_sockfd, (struct sockaddr *)&server_addr, addr_len);
+	SAFE_BIND(server_sockfd, (struct sockaddr *)server_addr, addr_len);
 	SAFE_LISTEN(server_sockfd, 1);
 
 	TST_CHECKPOINT_WAKE(0);
 
-	TEST(accept(server_sockfd, (struct sockaddr *)&client_addr, &addr_len));
+	TEST(accept(server_sockfd, (struct sockaddr *)client_addr, &addr_len));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "Could not accept connection");
 
 	clone_server_sockfd = TST_RET;
 
 	TEST(setsockopt(clone_server_sockfd, SOL_IP, MCAST_LEAVE_GROUP,
-			&mc_group, mc_group_len));
+			mc_group, mc_group_len));
 
 	if (TST_RET != -1)
 		tst_res(TFAIL, "Multicast group was copied!");
@@ -80,9 +79,9 @@ static void *server_thread(void *arg)
 static void *client_thread(void *arg)
 {
 	client_sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	SAFE_BIND(client_sockfd, (struct sockaddr *)&client_addr, addr_len);
+	SAFE_BIND(client_sockfd, (struct sockaddr *)client_addr, addr_len);
 
-	SAFE_CONNECT(client_sockfd, (struct sockaddr *)&server_addr, addr_len);
+	SAFE_CONNECT(client_sockfd, (struct sockaddr *)server_addr, addr_len);
 
 	SAFE_CLOSE(client_sockfd);
 	return arg;
@@ -92,8 +91,8 @@ static void run(void)
 {
 	pthread_t server_thr, client_thr;
 
-	server_addr.sin_port = server_port;
-	client_addr.sin_port = htons(0);
+	server_addr->sin_port = server_port;
+	client_addr->sin_port = htons(0);
 
 	SAFE_PTHREAD_CREATE(&server_thr, NULL, server_thread, NULL);
 	TST_CHECKPOINT_WAIT(0);
@@ -107,16 +106,20 @@ static void setup(void)
 {
 	struct sockaddr_in *mc_group_addr;
 
-	mc_group.gr_interface = 0;
-	mc_group_addr = (struct sockaddr_in *) &mc_group.gr_group;
+	server_addr = tst_alloc(sizeof(*server_addr));
+	client_addr = tst_alloc(sizeof(*client_addr));
+	mc_group = tst_alloc(sizeof(*mc_group));
+
+	mc_group->gr_interface = 0;
+	mc_group_addr = (struct sockaddr_in *) &mc_group->gr_group;
 	mc_group_addr->sin_family = AF_INET;
 	inet_aton(MULTICASTIP, &mc_group_addr->sin_addr);
 
-	server_addr.sin_family = AF_INET;
-	inet_aton(LOCALHOSTIP, &server_addr.sin_addr);
+	server_addr->sin_family = AF_INET;
+	inet_aton(LOCALHOSTIP, &server_addr->sin_addr);
 
-	client_addr.sin_family = AF_INET;
-	client_addr.sin_addr.s_addr = htons(INADDR_ANY);
+	client_addr->sin_family = AF_INET;
+	client_addr->sin_addr.s_addr = htons(INADDR_ANY);
 
 	addr_len = sizeof(struct sockaddr_in);
 
-- 
2.21.0

