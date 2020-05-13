From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 13 May 2020 17:29:14 +0200
Subject: [LTP] [PATCH] Add missing mode argument to open(..., O_CREAT)
Message-ID: <20200513152914.2703-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/fallocate/fallocate05.c         | 5 +++--
 testcases/kernel/syscalls/fallocate/fallocate06.c         | 4 ++--
 testcases/kernel/syscalls/getdents/getdents02.c           | 2 +-
 testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c | 2 +-
 testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c | 2 +-
 testcases/kernel/syscalls/kcmp/kcmp01.c                   | 2 +-
 testcases/kernel/syscalls/kcmp/kcmp02.c                   | 4 ++--
 testcases/kernel/syscalls/msync/msync04.c                 | 3 ++-
 testcases/kernel/syscalls/tee/tee02.c                     | 2 +-
 9 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 550d10258..55ec1aee4 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -39,7 +39,7 @@ static void setup(void)
 	int fd;
 	struct stat statbuf;
 
-	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
+	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT, 0644);
 
 	/*
 	 * Use real FS block size, otherwise fallocate() call will test
@@ -57,7 +57,8 @@ static void run(void)
 	int fd;
 	long extsize, tmp;
 
-	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT | O_TRUNC);
+	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT | O_TRUNC,
+		0644);
 	TEST(fallocate(fd, 0, 0, bufsize));
 
 	if (TST_RET) {
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 272edf161..409fd1321 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -77,7 +77,7 @@ static void setup(void)
 	int fd;
 	struct stat statbuf;
 
-	fd = SAFE_OPEN(TEMPFILE, O_WRONLY | O_CREAT | O_TRUNC);
+	fd = SAFE_OPEN(TEMPFILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
 
 	/*
 	 * Set FS_NOCOW_FL flag on the temp file. Non-CoW filesystems will
@@ -166,7 +166,7 @@ static void run(unsigned int n)
 
 	tst_res(TINFO, "Case %u. Fill FS: %s; Use copy on write: %s", n+1,
 		tc->fill_fs ? "yes" : "no", tc->no_cow ? "no" : "yes");
-	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT | O_TRUNC);
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
 
 	if (cow_support)
 		toggle_cow(fd, !tc->no_cow);
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 7b023c53f..4cf54aea3 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -158,7 +158,7 @@ static void test_enotdir(void)
 	struct linux_dirent64 dir64;
 	struct linux_dirent dir;
 
-	fd = SAFE_OPEN(cleanup, "test", O_CREAT | O_RDWR);
+	fd = SAFE_OPEN(cleanup, "test", O_CREAT | O_RDWR, 0644);
 
 	if (longsyscall)
 		getdents64(fd, &dir64, sizeof(dir64));
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
index 50d2c5f9a..e6077e479 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -29,7 +29,7 @@ static void run(void)
 	cbs[0] = &cb;
 	sigemptyset(&sigmask);
 
-	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT);
+	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT, 0644);
 	io_prep_pwrite(&cb, fd, data, 4096, 0);
 
 	ret = io_setup(1, &ctx);
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
index 7cca7fc08..62a8afba3 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -42,7 +42,7 @@ static void setup(void)
 
 	sigemptyset(&sigmask);
 
-	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT);
+	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT, 0644);
 	io_prep_pwrite(&cb, fd, data, 4096, 0);
 
 	ret = io_setup(1, &ctx);
diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
index 31c2ef3b1..a03a25a2b 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp01.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -43,7 +43,7 @@ static struct test_case {
 
 static void setup(void)
 {
-	fd1 = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
+	fd1 = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR | O_TRUNC, 0666);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index 1885dc968..993d9a4a4 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -54,8 +54,8 @@ static void setup(void)
 	pid1 = getpid();
 	pid_unused = tst_get_unused_pid();
 
-	fd1 = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
-	fd2 = SAFE_OPEN(TEST_FILE2, O_CREAT | O_RDWR | O_TRUNC);
+	fd1 = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR | O_TRUNC, 0644);
+	fd2 = SAFE_OPEN(TEST_FILE2, O_CREAT | O_RDWR | O_TRUNC, 0644);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index dad07b264..7c295d961 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -47,7 +47,8 @@ static void test_msync(void)
 {
 	uint64_t dirty;
 
-	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR);
+	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR,
+		0644);
 	SAFE_WRITE(0, test_fd, STRING_TO_WRITE, sizeof(STRING_TO_WRITE) - 1);
 	mmaped_area = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
 			MAP_SHARED, test_fd, 0);
diff --git a/testcases/kernel/syscalls/tee/tee02.c b/testcases/kernel/syscalls/tee/tee02.c
index 21296e968..899e93e5f 100644
--- a/testcases/kernel/syscalls/tee/tee02.c
+++ b/testcases/kernel/syscalls/tee/tee02.c
@@ -44,7 +44,7 @@ static struct tcase {
 
 static void setup(void)
 {
-	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT);
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0644);
 	SAFE_PIPE(pipes);
 	SAFE_WRITE(1, pipes[1], STR, sizeof(STR) - 1);
 }
-- 
2.26.2

