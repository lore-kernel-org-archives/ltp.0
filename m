From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  1 Aug 2019 11:26:09 +0200
Subject: [LTP] [RFC PATCH 2/9] lib: Add a canary for guarded buffers
In-Reply-To: <20190801092616.30553-1-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
Message-ID: <20190801092616.30553-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In a case that the buffer size is not a multiple of a page size there is
unused space before the start of the buffer. Let's fill that with
center mirrored random bytes and check that the buffer wasn't modified
before we unmap it.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/test_guarded_buf.c | 12 ++++++++--
 lib/tst_buffers.c                   | 36 +++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/lib/newlib_tests/test_guarded_buf.c b/lib/newlib_tests/test_guarded_buf.c
index 2951dce23..e41d3fa99 100644
--- a/lib/newlib_tests/test_guarded_buf.c
+++ b/lib/newlib_tests/test_guarded_buf.c
@@ -21,9 +21,17 @@ static char *buf3;
 
 static void do_test(unsigned int n)
 {
-	int pid = SAFE_FORK();
+	int pid;
 	int status;
 
+	if (n == 6) {
+		buf1[-1] = 0;
+		buf3[-1] = 0;
+		tst_res(TPASS, "Buffers dirtied!");
+		return;
+	}
+
+	pid = SAFE_FORK();
 	if (!pid) {
 		switch (n) {
 		case 0:
@@ -69,7 +77,7 @@ static void do_test(unsigned int n)
 static struct tst_test test = {
 	.forks_child = 1,
 	.test = do_test,
-	.tcnt = 6,
+	.tcnt = 7,
 	.bufs = (struct tst_buffers []) {
 		{&buf1, .size = BUF1_LEN},
 		{&buf2, .size = BUF2_LEN},
diff --git a/lib/tst_buffers.c b/lib/tst_buffers.c
index c4b2859d1..bc0cb50d8 100644
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
+				"pid %i: buffer modified before address %p %zu",
+				(char*)map->addr + map->buf_shift, i);
+		}
+	}
+}
+
 void *tst_alloc(size_t size)
 {
 	size_t page_size = getpagesize();
@@ -34,9 +61,13 @@ void *tst_alloc(size_t size)
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
@@ -97,6 +128,7 @@ void tst_free_all(void)
 	while (i) {
 		struct map *j = i;
 		tst_res(TINFO, "Freeing %p %zu", i->addr, i->size);
+		check_canary(i);
 		SAFE_MUNMAP(i->addr, i->size);
 		i = i->next;
 		free(j);
-- 
2.21.0

