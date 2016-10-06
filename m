From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Oct 2016 10:17:52 +0200
Subject: [LTP] [PATCH] [RFC] readahead02: Fix on Btrfs
Message-ID: <20161006081752.GA9210@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The Btrfs uses anonymous block devices for its subvolumes hence
/sys/dev/block/$major:$minor/ is not created for these.

We have to use ioctl(BTRFS_IOC_FS_INFO, ...) to get fs UUID in order to
map a path on Btrfs to a sysfs path that contains links to the devices.

TODO: What happens to readahead if there is more than one device backing
      the Btrfs filesystem?

Also this is getting absurdly compliated, maybe we should rethink the
test assertions so that we don't have to rely on reading the
read_ahead_kb file, perhaps we can just try to guess the maximal size by
calling the readahead in a loop with increasing size until it fails
instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 57 ++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 2517a33..3c06596 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -42,6 +42,7 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <linux/btrfs.h>
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -184,7 +185,53 @@ static void create_testfile(void)
 	free(tmp);
 }
 
-static long get_device_readahead(const char *fname)
+static long btrfs_get_device_readahead(const char *fname)
+{
+	int fd;
+	struct btrfs_ioctl_fs_info_args args;
+	unsigned char *id = args.fsid;
+	char buf[128];
+	char path[128];
+	DIR *dir;
+	struct dirent *dent;
+	int dflag = 0;
+	unsigned long ra_kb = 0;
+
+	fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
+	SAFE_IOCTL(cleanup, fd, BTRFS_IOC_FS_INFO, &args);
+	SAFE_CLOSE(cleanup, fd);
+
+	snprintf(buf, sizeof(buf),
+	         "/sys/fs/btrfs/%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x/devices/",
+	         id[0], id[1], id[2], id[3], id[4], id[5], id[6], id[7],
+                 id[8], id[9], id[10], id[11], id[12], id[13], id[14], id[15]);
+
+	tst_resm(TINFO, "Looking for device in '%s'", buf);
+
+	dir = SAFE_OPENDIR(cleanup, buf);
+	while ((dent = SAFE_READDIR(cleanup, dir))) {
+		if (!strcmp(".", dent->d_name) || !strcmp("..", dent->d_name))
+			continue;
+
+		if (dflag) {
+			tst_brkm(TBROK, cleanup,
+		        "More than one device for Btrfs filesystem!");
+		}
+
+		snprintf(path, sizeof(path),
+		         "%s/%s/../queue/read_ahead_kb", buf, dent->d_name);
+
+		dflag = 1;
+	}
+	SAFE_CLOSEDIR(cleanup, dir);
+
+	tst_resm(TINFO, "Reading %s", path);
+	SAFE_FILE_SCANF(cleanup, path, "%ld", &ra_kb);
+
+	return ra_kb * 1024;
+}
+
+static long generic_get_device_readahead(const char *fname)
 {
 	struct stat st;
 	unsigned long ra_kb = 0;
@@ -205,6 +252,14 @@ static long get_device_readahead(const char *fname)
 	return ra_kb * 1024;
 }
 
+static long get_device_readahead(const char *fname)
+{
+	if (tst_fs_type(cleanup, ".") == TST_BTRFS_MAGIC)
+		return btrfs_get_device_readahead(fname);
+
+	return generic_get_device_readahead(fname);
+}
+
 /* read_testfile - mmap testfile and read every page.
  * This functions measures how many I/O and time it takes to fully
  * read contents of test file.
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
