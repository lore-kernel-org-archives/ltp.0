From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Jun 2018 12:52:48 +0200
Subject: [LTP] [PATCH] readahead02: create loop device if TMPDIR is tmpfs
Message-ID: <94d4c00514e5f57d488199e0aa146e342f5b4403.1528887039.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

readahead doesn't work on tmpfs. Detect it and create loop
device if necessary.

After patch (4.16.0, /tmp if tmpfs):
  readahead02    0  TINFO  :  TMPFS detected, creating loop device
  readahead02    0  TINFO  :  Found free device '/dev/loop1'
  readahead02    0  TINFO  :  Formatting /dev/loop1 with ext2 opts='' extra opts='' mke2fs 1.43.6 (29-Aug-2017)
  readahead02    0  TINFO  :  creating test file of size: 67108864
  readahead02    0  TINFO  :  read_testfile(0)
  readahead02    0  TINFO  :  read_testfile(1)
  readahead02    0  TINFO  :  max ra estimate: 1118208
  readahead02    0  TINFO  :  readahead calls made: 61
  readahead02    1  TPASS  :  offset is still at 0 as expected
  readahead02    0  TINFO  :  read_testfile(0) took: 25650 usec
  readahead02    0  TINFO  :  read_testfile(1) took: 17931 usec
  readahead02    0  TINFO  :  read_testfile(0) read: 67108864 bytes
  readahead02    0  TINFO  :  read_testfile(1) read: 0 bytes
  readahead02    2  TPASS  :  readahead saved some I/O
  readahead02    0  TINFO  :  cache can hold at least: 66516 kB
  readahead02    0  TINFO  :  read_testfile(0) used cache: 65156 kB
  readahead02    0  TINFO  :  read_testfile(1) used cache: 65156 kB
  readahead02    3  TPASS  :  using cache as expected

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
This is follow-up to:
  https://github.com/linux-test-project/ltp/pull/307

 testcases/kernel/syscalls/readahead/readahead02.c | 31 ++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 319dc91f5fda..c9d92a6a475c 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -51,14 +51,18 @@ char *TCID = "readahead02";
 int TST_TOTAL = 1;
 
 #if defined(__NR_readahead)
-static const char testfile[] = "testfile";
+static char testfile[PATH_MAX] = "testfile";
 static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
 static const char meminfo_fname[] = "/proc/meminfo";
 static size_t testfile_size = 64 * 1024 * 1024;
 static int opt_fsize;
 static char *opt_fsizestr;
 static int pagesize;
+static const char *fs_type;
+static const char *device;
+static int mount_flag;
 
+#define MNTPOINT        "mntpoint"
 #define MIN_SANE_READAHEAD (4u * 1024u)
 
 option_t options[] = {
@@ -382,12 +386,37 @@ static void setup(void)
 	ltp_syscall(__NR_readahead, 0, 0, 0);
 
 	pagesize = getpagesize();
+
+	if (tst_fs_type(cleanup, ".") == TST_TMPFS_MAGIC) {
+		tst_resm(TINFO, "TMPFS detected, creating loop device");
+
+		fs_type = tst_dev_fs_type();
+		device = tst_acquire_device(cleanup);
+		if (!device) {
+			tst_brkm(TCONF, cleanup,
+				"Failed to obtain block device");
+		}
+
+		tst_mkfs(cleanup, device, fs_type, NULL, NULL);
+
+		SAFE_MKDIR(cleanup, MNTPOINT, 0755);
+		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
+		mount_flag = 1;
+
+		sprintf(testfile, MNTPOINT"/testfile");
+	}
 	create_testfile();
 }
 
 static void cleanup(void)
 {
 	unlink(testfile);
+	if (mount_flag && tst_umount(MNTPOINT) < 0)
+		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
+
+	if (device)
+		tst_release_device(device);
+
 	tst_rmdir();
 }
 
-- 
1.8.3.1

