From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  8 Jan 2021 13:54:10 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/finit_module: Check for module
 existence
Message-ID: <20210108125410.13178-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ use tst_tmpdir so that we do not create directories in $PWD

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

I've missed this during the review, sorry.

 testcases/kernel/syscalls/finit_module/finit_module01.c | 9 +++++++--
 testcases/kernel/syscalls/finit_module/finit_module02.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index c31c0c2dc..d215fc0ff 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -19,12 +19,17 @@
 
 #define MODULE_NAME	"finit_module.ko"
 
-int fd;
+static int fd;
+
+static char *mod_path;
 
 static void setup(void)
 {
 	finit_module_supported_by_kernel();
-	fd = SAFE_OPEN(MODULE_NAME, O_RDONLY|O_CLOEXEC);
+
+	tst_module_exists(MODULE_NAME, &mod_path);
+
+	fd = SAFE_OPEN(mod_path, O_RDONLY|O_CLOEXEC);
 }
 
 static void run(void)
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 109de9482..96aec4591 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -22,6 +22,8 @@
 #define MODULE_NAME	"finit_module.ko"
 #define TEST_DIR	"test_dir"
 
+static char *mod_path;
+
 static int fd, fd_zero, fd_invalid = -1, fd_dir;
 
 static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
@@ -79,6 +81,9 @@ static void setup(void)
 	unsigned long int i;
 
 	finit_module_supported_by_kernel();
+
+	tst_module_exists(MODULE_NAME, &mod_path);
+
 	SAFE_MKDIR(TEST_DIR, 0700);
 	fd_dir = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
 
@@ -91,14 +96,13 @@ static void setup(void)
 static void cleanup(void)
 {
 	SAFE_CLOSE(fd_dir);
-	SAFE_RMDIR(TEST_DIR);
 }
 
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	fd = SAFE_OPEN(MODULE_NAME, tc->open_flags);
+	fd = SAFE_OPEN(mod_path, tc->open_flags);
 
 	if (tc->cap)
 		tst_cap_action(&cap_drop);
@@ -127,5 +131,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
+	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
-- 
2.26.2

