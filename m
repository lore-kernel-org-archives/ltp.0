From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 20 Jul 2021 12:39:41 +0200
Subject: [LTP] [PATCH 3/3] Add lockdown checks to init_module* and
 finit_module* tests
In-Reply-To: <20210720103941.9767-1-mdoucha@suse.cz>
References: <20210720103941.9767-1-mdoucha@suse.cz>
Message-ID: <20210720103941.9767-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../syscalls/finit_module/finit_module01.c    |  2 ++
 .../syscalls/finit_module/finit_module02.c    | 23 +++++++++++++--
 .../syscalls/init_module/init_module01.c      |  2 ++
 .../syscalls/init_module/init_module02.c      | 29 +++++++++++++------
 4 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index 9c34282e1..21c35f101 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -51,4 +51,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	/* lockdown requires signed modules */
+	.skip_in_lockdown = 1,
 };
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 9d9255c6d..503c8e994 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -25,6 +25,7 @@
 static char *mod_path;
 
 static int fd, fd_zero, fd_invalid = -1, fd_dir;
+static int kernel_lockdown;
 
 static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
 static struct tst_cap cap_drop = TST_CAP(TST_CAP_DROP, CAP_SYS_MODULE);
@@ -64,11 +65,19 @@ static void dir_setup(struct tcase *tc)
 		tc->exp_errno = EINVAL;
 }
 
+static void lockdown_setup(struct tcase *tc)
+{
+	if (kernel_lockdown)
+		tc->exp_errno = EPERM;
+}
+
 static struct tcase tcases[] = {
 	{"invalid-fd", &fd_invalid, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, bad_fd_setup},
 	{"zero-fd", &fd_zero, "", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL, NULL},
-	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT, NULL},
-	{"invalid-param", &fd, "status=invalid", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL, NULL},
+	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT,
+		lockdown_setup},
+	{"invalid-param", &fd, "status=invalid", O_RDONLY | O_CLOEXEC, 0, 0,
+		EINVAL, lockdown_setup},
 	{"invalid-flags", &fd, "", O_RDONLY | O_CLOEXEC, -1, 0, EINVAL, NULL},
 	{"no-perm", &fd, "", O_RDONLY | O_CLOEXEC, 0, 1, EPERM, NULL},
 	{"module-exists", &fd, "", O_RDONLY | O_CLOEXEC, 0, 0, EEXIST, NULL},
@@ -84,6 +93,7 @@ static void setup(void)
 
 	tst_module_exists(MODULE_NAME, &mod_path);
 
+	kernel_lockdown = tst_lockdown_enabled();
 	SAFE_MKDIR(TEST_DIR, 0700);
 	fd_dir = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
 
@@ -108,8 +118,15 @@ static void run(unsigned int n)
 		tst_cap_action(&cap_drop);
 
 	/* Insert module twice */
-	if (tc->exp_errno == EEXIST)
+	if (tc->exp_errno == EEXIST) {
+		if (kernel_lockdown) {
+			tst_res(TCONF, "Kernel is locked down, skipping %s",
+				tc->name);
+			return;
+		}
+
 		tst_module_load(MODULE_NAME, NULL);
+	}
 
 	TST_EXP_FAIL(finit_module(*tc->fd, tc->param, tc->flags), tc->exp_errno,
 		     "TestName: %s", tc->name);
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index 2f47eed32..79e567cd6 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -53,4 +53,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	/* lockdown requires signed modules */
+	.skip_in_lockdown = 1,
 };
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index 3953f4f61..dac99a4da 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -22,6 +22,7 @@
 #define MODULE_NAME	"init_module.ko"
 
 static unsigned long size, zero_size;
+static int kernel_lockdown;
 static void *buf, *faulty_buf, *null_buf;
 
 static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
@@ -34,14 +35,15 @@ static struct tcase {
 	const char *param;
 	int cap;
 	int exp_errno;
+	int lockdown_errno;
 } tcases[] = {
-	{"NULL-buffer", &null_buf, &size, "", 0, EFAULT},
-	{"faulty-buffer", &faulty_buf, &size, "", 0, EFAULT},
-	{"null-param", &buf, &size, NULL, 0, EFAULT},
-	{"zero-size", &buf, &zero_size, "", 0, ENOEXEC},
-	{"invalid_param", &buf, &size, "status=invalid", 0, EINVAL},
-	{"no-perm", &buf, &size, "", 1, EPERM},
-	{"module-exists", &buf, &size, "", 0, EEXIST},
+	{"NULL-buffer", &null_buf, &size, "", 0, EFAULT, EFAULT},
+	{"faulty-buffer", &faulty_buf, &size, "", 0, EFAULT, EFAULT},
+	{"null-param", &buf, &size, NULL, 0, EFAULT, EPERM},
+	{"zero-size", &buf, &zero_size, "", 0, ENOEXEC, ENOEXEC},
+	{"invalid_param", &buf, &size, "status=invalid", 0, EINVAL, EPERM},
+	{"no-perm", &buf, &size, "", 1, EPERM, EPERM},
+	{"module-exists", &buf, &size, "", 0, EEXIST, EPERM},
 };
 
 static void setup(void)
@@ -51,6 +53,7 @@ static void setup(void)
 
 	tst_module_exists(MODULE_NAME, NULL);
 
+	kernel_lockdown = tst_lockdown_enabled();
 	fd = SAFE_OPEN(MODULE_NAME, O_RDONLY|O_CLOEXEC);
 	SAFE_FSTAT(fd, &sb);
 	size = sb.st_size;
@@ -68,10 +71,18 @@ static void run(unsigned int n)
 		tst_cap_action(&cap_drop);
 
 	/* Insert module twice */
-	if (tc->exp_errno == EEXIST)
+	if (tc->exp_errno == EEXIST) {
+		if (kernel_lockdown) {
+			tst_res(TCONF, "Kernel is locked down, skipping %s",
+				tc->name);
+			return;
+		}
+
 		tst_module_load(MODULE_NAME, NULL);
+	}
 
-	TST_EXP_FAIL(init_module(*tc->buf, *tc->size, tc->param), tc->exp_errno,
+	TST_EXP_FAIL(init_module(*tc->buf, *tc->size, tc->param),
+		     kernel_lockdown ? tc->lockdown_errno : tc->exp_errno,
 		     "TestName: %s", tc->name);
 
 	if (tc->exp_errno == EEXIST)
-- 
2.32.0

