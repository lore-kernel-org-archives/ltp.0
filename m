From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 2 Apr 2021 11:46:11 +0800
Subject: [LTP] [PATCH 1/2] kernel/syscalls: Modify incorrect use of TERRNO
 and replace functions with safe_macros
In-Reply-To: <20210402034612.127912-1-xieziyao@huawei.com>
References: <20210402034612.127912-1-xieziyao@huawei.com>
Message-ID: <20210402034612.127912-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- modify some incorrect use of TERRNO/TTERRNO in kernel/syscalls;
- replace functions with safe_macros to check the return value in kernel/syscalls.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/bpf/bpf_map01.c              |  2 +-
 .../syscalls/clock_nanosleep/clock_nanosleep01.c       |  2 +-
 .../syscalls/copy_file_range/copy_file_range02.c       |  2 +-
 .../syscalls/copy_file_range/copy_file_range03.c       |  2 +-
 testcases/kernel/syscalls/dup/dup03.c                  |  4 ++--
 testcases/kernel/syscalls/execve/execve02.c            |  4 ++--
 testcases/kernel/syscalls/fallocate/fallocate04.c      |  2 +-
 testcases/kernel/syscalls/getcwd/getcwd01.c            |  4 ++--
 testcases/kernel/syscalls/getcwd/getcwd02.c            |  2 +-
 testcases/kernel/syscalls/init_module/init_module01.c  |  2 +-
 testcases/kernel/syscalls/init_module/init_module02.c  |  2 +-
 testcases/kernel/syscalls/io_uring/io_uring02.c        | 10 +++++-----
 testcases/kernel/syscalls/ioctl/ioctl04.c              |  4 ++--
 testcases/kernel/syscalls/ioperm/ioperm01.c            |  2 +-
 14 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
index 69473cd04..e0c3b1bf4 100644
--- a/testcases/kernel/syscalls/bpf/bpf_map01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -83,7 +83,7 @@ void run(unsigned int n)
 			if (i < VAL_SZ)
 				tst_res(TPASS, "Preallocated array map lookup");
 		} else {
-			tst_res(TFAIL | TERRNO, "Prellocated array map lookup");
+			tst_res(TFAIL | TTERRNO, "Prellocated array map lookup");
 		}
 	break;
 	}
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 516ab50f1..382497918 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -208,7 +208,7 @@ static void do_test(unsigned int i)
 		return;
 	}

-	tst_res(TPASS | TERRNO, "clock_nanosleep() failed with");
+	tst_res(TPASS | TTERRNO, "clock_nanosleep() failed with");
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index bc27fbe57..4bab393c7 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -221,7 +221,7 @@ static void setup(void)
 	SAFE_PIPE(fd_pipe);

 	SAFE_WRITE(1, fd_src, CONTENT, CONTSIZE);
-	close(fd_src);
+	SAFE_CLOSE(fd_src);
 	fd_src = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY, 0664);
 	fd_dup = SAFE_OPEN(FILE_SRC_PATH, O_WRONLY|O_CREAT, 0666);

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
index 253eb57ad..71014e9e2 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
@@ -21,7 +21,7 @@ unsigned long get_timestamp(int fd)
 {
 	struct stat filestat;

-	fstat(fd, &filestat);
+	SAFE_FSTAT(fd, &filestat);
 	return filestat.st_mtime;
 }

diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index caef078b2..0e99813f4 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -30,9 +30,9 @@ static void run(void)

 	if (TST_RET == -1) {
 		if (TST_ERR == EMFILE)
-			tst_res(TPASS | TERRNO, "dup() failed as expected");
+			tst_res(TPASS | TTERRNO, "dup() failed as expected");
 		else
-			tst_res(TFAIL | TERRNO, "dup() failed unexpectedly");
+			tst_res(TFAIL | TTERRNO, "dup() failed unexpectedly");
 		return;
 	}

diff --git a/testcases/kernel/syscalls/execve/execve02.c b/testcases/kernel/syscalls/execve/execve02.c
index d9fb5b919..0574f5c8b 100644
--- a/testcases/kernel/syscalls/execve/execve02.c
+++ b/testcases/kernel/syscalls/execve/execve02.c
@@ -49,9 +49,9 @@ static void do_child(void)
 		tst_brk(TFAIL, "execve() passed unexpectedly");

 	if (TST_ERR != EACCES)
-		tst_brk(TFAIL | TERRNO, "execve() failed unexpectedly");
+		tst_brk(TFAIL | TTERRNO, "execve() failed unexpectedly");

-	tst_res(TPASS | TERRNO, "execve() failed expectedly");
+	tst_res(TPASS | TTERRNO, "execve() failed expectedly");

 	exit(0);
 }
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 7ffc8f4fa..dfc27e3a8 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -43,7 +43,7 @@ static size_t get_allocsize(void)
 {
 	struct stat file_stat;

-	fsync(fd);
+	SAFE_FSYNC(fd);

 	SAFE_FSTAT(fd, &file_stat);

diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index 65d827873..4b60b86d8 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -54,12 +54,12 @@ static void verify_getcwd(unsigned int n)
 	}

 	if (TST_ERR != tc->exp_err) {
-		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
+		tst_res(TFAIL | TERRNO, "getcwd() failed unexpectedly, expected %s",
 			tst_strerrno(tc->exp_err));
 		return;
 	}

-	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
+	tst_res(TPASS | TERRNO, "getcwd() failed as expected");
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index e843a4896..b0c5f3750 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -73,7 +73,7 @@ static void verify_getcwd(unsigned int n)
 	res = getcwd(tc->buf, tc->size);
 	TST_ERR = errno;
 	if (!res) {
-		tst_res(TFAIL | TTERRNO, "getcwd() failed");
+		tst_res(TFAIL | TERRNO, "getcwd() failed");
 		goto end;
 	}

diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index 2f47eed32..ae08da5fd 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -45,7 +45,7 @@ static void run(void)

 static void cleanup(void)
 {
-	munmap(buf, sb.st_size);
+	SAFE_MUNMAP(buf, sb.st_size);
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index 3953f4f61..4ffda1956 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -86,7 +86,7 @@ static void run(unsigned int n)

 static void cleanup(void)
 {
-	munmap(buf, size);
+	SAFE_MUNMAP(buf, size);
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c b/testcases/kernel/syscalls/io_uring/io_uring02.c
index 5127ff980..8ec2e9187 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring02.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
@@ -134,7 +134,7 @@ static void drain_fallback(void)
 			if (cqe_ptr->res >= 0 || cqe_ptr->res == -EAGAIN)
 				continue;

-			tst_res(TFAIL | TTERRNO,
+			tst_res(TFAIL | TERRNO,
 				"Spam request failed unexpectedly");
 			continue;
 		}
@@ -150,10 +150,10 @@ static void drain_fallback(void)
 		if (cqe_ptr->res >= 0) {
 			tst_res(TFAIL, "Write outside chroot succeeded.");
 		} else if (cqe_ptr->res != -ENOENT) {
-			tst_res(TFAIL | TTERRNO,
+			tst_res(TFAIL | TERRNO,
 				"Write outside chroot failed unexpectedly");
 		} else {
-			tst_res(TPASS | TTERRNO,
+			tst_res(TPASS | TERRNO,
 				"Write outside chroot failed as expected");
 		}
 	}
@@ -197,12 +197,12 @@ static void check_result(void)
 	}

 	if (cqe_ptr->res != -ENOENT) {
-		tst_res(TFAIL | TTERRNO,
+		tst_res(TFAIL | TERRNO,
 			"Write outside chroot failed unexpectedly");
 		return;
 	}

-	tst_res(TPASS | TTERRNO, "Write outside chroot failed as expected");
+	tst_res(TPASS | TERRNO, "Write outside chroot failed as expected");
 }

 static void run(void)
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index 353114cc0..d9ddb8e59 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -47,11 +47,11 @@ static void verify_ioctl(void)
 	}

 	if (TST_ERR == EACCES) {
-		tst_res(TPASS | TERRNO, "Mounting RO device RW failed");
+		tst_res(TPASS | TTERRNO, "Mounting RO device RW failed");
 		goto next;
 	}

-	tst_res(TFAIL | TERRNO,
+	tst_res(TFAIL | TTERRNO,
 		"Mounting RO device RW failed unexpectedly expected EACCES");

 next:
diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index fc5754be9..6c50a0b75 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -64,7 +64,7 @@ static void cleanup(void)
 	 * Reset I/O privileges for the specified port.
 	 */
 	if ((ioperm(io_addr, NUM_BYTES, 0)) == -1)
-		tst_brk(TBROK | TTERRNO, "ioperm() cleanup failed");
+		tst_brk(TBROK | TERRNO, "ioperm() cleanup failed");
 }

 static struct tst_test test = {
--
2.17.1

