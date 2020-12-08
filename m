From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Dec 2020 16:29:53 +0530
Subject: [LTP] [PATCH] syscalls: Allocate handles at setup time only
In-Reply-To: <20201124152446.GC12878@yuki.lan>
References: <20201124152446.GC12878@yuki.lan>
Message-ID: <ca094a13188d52cca6cfb913c2341429d3967bfb.1607425101.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move the allocation of handles to setup time only, so the run() helper
can focus on the syscall to test.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Cyril, I think you merged the patch for open_by_handle_at by mistake,
and that too without your signed-off.

commit 81e0821e1fc1 ("syscalls: Add tests for open_by_handle_at()")

Here is what you asked for in your earlier email.

 .../open_by_handle_at/open_by_handle_at01.c   | 83 +++++++++----------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
index 35597a13c182..2583bc3a186d 100644
--- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
@@ -21,42 +21,23 @@
 #define TEST_DIR "test_dir"
 
 static int dir_fd, fd_atcwd = AT_FDCWD, file_fd;
-static struct file_handle *fhp;
+static struct file_handle *f_fhp, *d_fhp, *at_fhp;
+static struct file_handle *f_fhp, *d_fhp, *at_fhp;
 
 static struct tcase {
 	int *dfd;
-	const char *pathname;
-	int name_flags;
+	struct file_handle **fhp;
 	int flags;
 } tcases[] = {
-	{&dir_fd, TEST_FILE, 0, O_RDWR},
-	{&dir_fd, TEST_FILE, 0, O_RDONLY},
-	{&dir_fd, TEST_FILE, 0, O_WRONLY},
-	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_RDWR},
-	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_RDONLY},
-	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_WRONLY},
-	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDWR},
-	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDONLY},
-	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_WRONLY},
-	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDWR},
-	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDONLY},
-	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_WRONLY},
-	{&dir_fd, "", AT_EMPTY_PATH, O_RDONLY},
-	{&file_fd, "", AT_EMPTY_PATH, O_RDONLY},
-
-	{&fd_atcwd, TEST_FILE, 0, O_RDWR},
-	{&fd_atcwd, TEST_FILE, 0, O_RDONLY},
-	{&fd_atcwd, TEST_FILE, 0, O_WRONLY},
-	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_RDWR},
-	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_RDONLY},
-	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_WRONLY},
-	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDWR},
-	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDONLY},
-	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_WRONLY},
-	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDWR},
-	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDONLY},
-	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_WRONLY},
-	{&fd_atcwd, "", AT_EMPTY_PATH, O_RDONLY},
+	{&dir_fd, &d_fhp, O_RDWR},
+	{&dir_fd, &d_fhp, O_RDONLY},
+	{&dir_fd, &d_fhp, O_WRONLY},
+	{&file_fd, &f_fhp, O_RDWR},
+	{&file_fd, &f_fhp, O_RDONLY},
+	{&file_fd, &f_fhp, O_WRONLY},
+	{&fd_atcwd, &at_fhp, O_RDWR},
+	{&fd_atcwd, &at_fhp, O_RDONLY},
+	{&fd_atcwd, &at_fhp, O_WRONLY},
 };
 
 static void cleanup(void)
@@ -67,28 +48,46 @@ static void cleanup(void)
 
 static void setup(void)
 {
+	int mount_id;
+
 	SAFE_MKDIR(TEST_DIR, 0700);
 	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
 	SAFE_CHDIR(TEST_DIR);
 	SAFE_TOUCH(TEST_FILE, 0600, NULL);
 	file_fd = SAFE_OPEN("foo_file", O_RDWR | O_CREAT);
-	fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
+
+	f_fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
+	d_fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
+	at_fhp = allocate_file_handle(AT_FDCWD, TEST_FILE);
+
+	TEST(name_to_handle_at(file_fd, "", f_fhp, &mount_id, AT_EMPTY_PATH));
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed");
+		return;
+	}
+
+	TEST(name_to_handle_at(dir_fd, TEST_FILE, d_fhp, &mount_id,
+			       AT_EMPTY_PATH | AT_SYMLINK_FOLLOW));
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed");
+		return;
+	}
+
+	TEST(name_to_handle_at(AT_FDCWD, TEST_FILE, at_fhp, &mount_id,
+			       AT_EMPTY_PATH | AT_SYMLINK_FOLLOW));
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed");
+		return;
+	}
 }
 
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	struct stat file_stat;
-	int fd, mount_id;
-
-	TEST(name_to_handle_at(*tc->dfd, tc->pathname, fhp, &mount_id,
-			       tc->name_flags));
-	if (TST_RET) {
-		tst_res(TFAIL | TTERRNO, "name_to_handle_at() failed (%d)", n);
-		return;
-	}
+	int fd;
 
-	TEST(fd = open_by_handle_at(*tc->dfd, fhp, tc->flags));
+	TEST(fd = open_by_handle_at(*tc->dfd, *tc->fhp, tc->flags));
 	if (fd < 0) {
 		tst_res(TFAIL | TTERRNO, "open_by_handle_at() failed (%d)", n);
 		return;
@@ -97,7 +96,7 @@ static void run(unsigned int n)
 	SAFE_FSTAT(fd, &file_stat);
 
 	/* Don't check stats when pathname is empty */
-	if (file_stat.st_size == 0 || !tc->pathname[0])
+	if (file_stat.st_size == 0 || (tc->fhp == &f_fhp))
 		tst_res(TPASS, "open_by_handle_at() passed (%d)", n);
 	else
 		tst_res(TFAIL, "fstat() didn't work as expected (%d)", n);
-- 
2.25.0.rc1.19.g042ed3e048af

