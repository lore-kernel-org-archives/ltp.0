From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Aug 2019 16:39:32 +0200
Subject: [LTP] [PATCH v2 02/11] lib: Add a canary for guarded buffers
In-Reply-To: <20190812143941.8119-1-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
Message-ID: <20190812143941.8119-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In a case that the buffer size is not a multiple of a page size there is
unused space before the start of the buffer. Let's fill that with
center mirrored random bytes and check that the buffer wasn't modified
before we unmap it.

The tst_free_all() function is also set to be executed atexit() in the
safe_fork() function for all child processes, which guaratees that
canaries are checked in child processes as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/test_guarded_buf.c | 18 +++++++++++++--
 lib/tst_buffers.c                   | 36 +++++++++++++++++++++++++++--
 lib/tst_test.c                      |  3 +++
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/lib/newlib_tests/test_guarded_buf.c b/lib/newlib_tests/test_guarded_buf.c
index 2951dce23..506802114 100644
--- a/lib/newlib_tests/test_guarded_buf.c
+++ b/lib/newlib_tests/test_guarded_buf.c
@@ -21,9 +21,16 @@ static char *buf3;
 
 static void do_test(unsigned int n)
 {
-	int pid = SAFE_FORK();
+	int pid;
 	int status;
 
+	if (n == 6) {
+		buf1[-1] = 0;
+		buf3[-1] = 0;
+		tst_res(TPASS, "Buffers dirtied!");
+	}
+
+	pid = SAFE_FORK();
 	if (!pid) {
 		switch (n) {
 		case 0:
@@ -44,6 +51,10 @@ static void do_test(unsigned int n)
 		case 5:
 			buf3[BUF3_LEN] = 0;
 		break;
+		case 6:
+			buf1[-2] = 0;
+			buf3[-2] = 0;
+		break;
 		}
 
 		exit(0);
@@ -51,6 +62,9 @@ static void do_test(unsigned int n)
 
 	SAFE_WAITPID(pid, &status, 0);
 
+	if (n == 6)
+		return;
+
 	if (n < 3) {
 		if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
 			tst_res(TPASS, "Exitted normally");
@@ -69,7 +83,7 @@ static void do_test(unsigned int n)
 static struct tst_test test = {
 	.forks_child = 1,
 	.test = do_test,
-	.tcnt = 6,
+	.tcnt = 7,
 	.bufs = (struct tst_buffers []) {
 		{&buf1, .size = BUF1_LEN},
 		{&buf2, .size = BUF2_LEN},
diff --git a/lib/tst_buffers.c b/lib/tst_buffers.c
index 4f3bbe68e..b8b597a12 100644
--- a/lib/tst_buffers.c
+++ b/lib/tst_buffers.c
@@ -11,11 +11,38 @@
 struct map {
 	void *addr;
 	size_t size;
+	size_t buf_shift;
 	struct map *next;
 };
 
 static struct map *maps;
 
+static void setup_canary(struct map *map)
+{
+	size_t i;
+	char *buf = map->addr;
+
+	for (i = 0; i < map->buf_shift/2; i++) {
+		char c = random();
+		buf[map->buf_shift - i - 1] = c;
+		buf[i] = c;
+	}
+}
+
+static void check_canary(struct map *map)
+{
+	size_t i;
+	char *buf = map->addr;
+
+	for (i = 0; i < map->buf_shift/2; i++) {
+		if (buf[map->buf_shift - i - 1] != buf[i]) {
+			tst_res(TWARN,
+				"pid %i: buffer modified address %p[%zi]",
+				getpid(), (char*)map->addr + map->buf_shift, -i-1);
+		}
+	}
+}
+
 void *tst_alloc(size_t size)
 {
 	size_t page_size = getpagesize();
@@ -40,9 +67,13 @@ void *tst_alloc(size_t size)
 	maps = map;
 
 	if (size % page_size)
-		ret += page_size - (size % page_size);
+		map->buf_shift = page_size - (size % page_size);
+	else
+		map->buf_shift = 0;
+
+	setup_canary(map);
 
-	return ret;
+	return ret + map->buf_shift;
 }
 
 static int count_iovec(int *sizes)
@@ -102,6 +133,7 @@ void tst_free_all(void)
 
 	while (i) {
 		struct map *j = i;
+		check_canary(i);
 		SAFE_MUNMAP(i->addr, i->size);
 		i = i->next;
 		free(j);
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8dc71dbb3..39f261472 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -390,6 +390,9 @@ pid_t safe_fork(const char *filename, unsigned int lineno)
 	if (pid < 0)
 		tst_brk_(filename, lineno, TBROK | TERRNO, "fork() failed");
 
+	if (!pid)
+		atexit(tst_free_all);
+
 	return pid;
 }
 
-- 
2.21.0

