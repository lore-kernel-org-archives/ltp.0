From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 Sep 2017 18:09:12 +0200
Subject: [LTP] [RFC] [PATCH 09/15] syscalls/fallocate04: Run test for all
	filesystems
In-Reply-To: <20170905160918.6477-1-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
Message-ID: <20170905160918.6477-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fallocate/fallocate04.c | 49 +++++++++++++----------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 4916c8b47..e576d728d 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -34,19 +34,15 @@
 #include "lapi/fallocate.h"
 
 static int fd;
-static const char fname[] = "fallocate04.txt";
 static size_t block_size;
 static size_t buf_size;
 
+#define MNTPOINT "fallocate"
+#define FNAME MNTPOINT "/fallocate.txt"
 #define NUM_OF_BLOCKS	3
 
 static char *verbose;
 
-static void cleanup(void)
-{
-	SAFE_CLOSE(fd);
-}
-
 static void get_blocksize(void)
 {
 	struct stat file_stat;
@@ -77,13 +73,6 @@ static void fill_tst_buf(char buf[])
 		memset(buf + i * block_size, 'a' + i, block_size);
 }
 
-static void setup(void)
-{
-	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
-
-	get_blocksize();
-}
-
 static void check_file_data(const char exp_buf[], size_t size)
 {
 	char rbuf[size];
@@ -299,13 +288,26 @@ static void test05(void)
 	tst_res(TPASS, "test-case succeeded");
 }
 
-static void run(void)
+static void (*tcases[])(void) = {
+	test01, test02, test03, test04, test05
+};
+
+static void run(unsigned int i)
+{
+	tcases[i]();
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0700);
+
+	get_blocksize();
+}
+
+static void cleanup(void)
 {
-	test01();
-	test02();
-	test03();
-	test04();
-	test05();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_option opts[] = {
@@ -315,8 +317,13 @@ static struct tst_option opts[] = {
 
 static struct tst_test test = {
 	.options = opts,
-	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = run,
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
 	.needs_tmpdir = 1,
+	.needs_root = 1,
 };
-- 
2.13.0

