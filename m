From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Mar 2021 11:53:17 +0100
Subject: [LTP] [PATCH v3 3/4] lib: Apply the skip_filesystems to rest of
 test as well
In-Reply-To: <20210317105318.32017-1-chrubis@suse.cz>
References: <20210317105318.32017-1-chrubis@suse.cz>
Message-ID: <20210317105318.32017-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is no reason to use the newly introduced .skip_filesystems only
for .all_filesystems tests.

So if .all_filesystems is not enabled and .skip_filesystems is set we
check if test temporary directory filesystem type is in the list of
supported filesystem types.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c                                | 12 ++++++++++++
 testcases/kernel/syscalls/fcntl/fcntl33.c     | 19 +++++++------------
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 11 +++++------
 .../kernel/syscalls/vmsplice/vmsplice01.c     |  9 ++++-----
 .../kernel/syscalls/vmsplice/vmsplice02.c     |  9 ++++-----
 5 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 639e21727..2f728de28 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1051,6 +1051,18 @@ static void do_test_setup(void)
 {
 	main_pid = getpid();
 
+	if (!tst_test->all_filesystems && tst_test->skip_filesystems) {
+		long fs_type = tst_fs_type(".");
+		const char *fs_name = tst_fs_type_name(fs_type);
+
+		if (tst_fs_in_skiplist(fs_name, tst_test->skip_filesystems)) {
+			tst_brk(TCONF, "Skipping %s as requested by the test",
+				fs_name);
+		} else {
+			tst_res(TINFO, "%s is supported by the test", fs_name);
+		}
+	}
+
 	if (tst_test->caps)
 		tst_cap_setup(tst_test->caps, TST_CAP_REQ);
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index 70d5ec5ff..8d0d1a5a1 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -81,17 +81,6 @@ static void setup(void)
 	SAFE_FILE_SCANF(PATH_LS_BRK_T, "%d", &ls_brk_t);
 	SAFE_FILE_PRINTF(PATH_LS_BRK_T, "%d", 45);
 
-	switch ((type = tst_fs_type("."))) {
-	case TST_NFS_MAGIC:
-	case TST_RAMFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brk(TCONF,
-			"Cannot do fcntl(F_SETLEASE, F_WRLCK) on %s filesystem",
-			tst_fs_type_name(type));
-	default:
-		break;
-	}
-
 	SAFE_TOUCH("file", FILE_MODE, NULL);
 
 	sigemptyset(&newset);
@@ -230,5 +219,11 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(test_cases),
 	.setup = setup,
 	.test = do_test,
-	.cleanup = cleanup
+	.cleanup = cleanup,
+	.skip_filesystems = (const char *const []) {
+		"tmpfs",
+		"ramfs",
+		"nfs",
+		NULL
+	},
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index f8fa413a9..58aa6f0d8 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -98,12 +98,6 @@ static void setup(void)
 {
 	char bd_path[100];
 
-	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
-		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
-
-	if (tst_fs_type(".") == TST_OVERLAYFS_MAGIC)
-		tst_brk(TCONF, "device isn't properly detected in overlay fs");
-
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
@@ -151,6 +145,11 @@ static struct tst_test test = {
 	.test_all = verify_ioctl_loop,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.skip_filesystems = (const char *const []) {
+		"tmpfs",
+		"overlayfs",
+		NULL
+	},
 	.needs_drivers = (const char *const []) {
 		"loop",
 		NULL
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 833af239f..1d1b66d12 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -103,11 +103,6 @@ static void setup(void)
 {
 	int i;
 
-	if (tst_fs_type(".") == TST_NFS_MAGIC) {
-		tst_brk(TCONF, "Cannot do splice() "
-			 "on a file located on an NFS filesystem");
-	}
-
 	for (i = 0; i < TEST_BLOCK_SIZE; i++)
 		buffer[i] = i & 0xff;
 }
@@ -123,5 +118,9 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = vmsplice_test,
 	.needs_tmpdir = 1,
+	.skip_filesystems = (const char *const []) {
+		"nfs",
+		NULL
+	},
 	.min_kver = "2.6.17",
 };
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index 978633d31..39c407cb8 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -52,11 +52,6 @@ static struct tcase {
 
 static void setup(void)
 {
-	if (tst_fs_type(".") == TST_NFS_MAGIC) {
-		tst_brk(TCONF, "Cannot do splice() "
-			"on a file located on an NFS filesystem");
-	}
-
 	filefd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, 0644);
 
 	SAFE_PIPE(pipes);
@@ -106,5 +101,9 @@ static struct tst_test test = {
 	.test = vmsplice_verify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
+	.skip_filesystems = (const char *const []) {
+		"nfs",
+		NULL
+	},
 	.min_kver = "2.6.17",
 };
-- 
2.26.2

