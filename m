From: Li Wang <liwang@redhat.com>
Date: Fri,  9 Jul 2021 15:52:03 +0800
Subject: [LTP] [PATCH v3 2/3] lib: limit the size of tmpfs in LTP
In-Reply-To: <20210709075204.999168-1-liwang@redhat.com>
References: <20210709075204.999168-1-liwang@redhat.com>
Message-ID: <20210709075204.999168-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP mount and make use of the whole tmpfs of the test system,
generally, it's fine. But if a test (e.g fallocate06) try to
fill full in the filesystem, it takes too long to complete
testing on a large memory system.

This patch adds a new function limit_tmpfs_mount_size with
appending '-o size=xxM' to the mount options in prepare_device()
which helps limit the tmpfs mount size.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 55449c80b..b996f1b2e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -882,8 +882,26 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
 	}
 }
 
+static char *limit_tmpfs_mount_size(const char *mnt_data,
+		char *buf, size_t buf_size, const char *fs_type)
+{
+	if (strcmp(fs_type, "tmpfs"))
+		return mnt_data;
+
+	if (mnt_data)
+		snprintf(buf, buf_size, "%s,size=%luM", mnt_data, tdev.size);
+	else
+		snprintf(buf, buf_size, "size=%luM", tdev.size);
+
+	tst_res(TINFO, "Limiting tmpfs size to %luMB", tdev.size);
+
+	return buf;
+}
+
 static void prepare_device(void)
 {
+	char *mnt_data, buf[1024];
+
 	if (tst_test->format_device) {
 		SAFE_MKFS(tdev.dev, tdev.fs_type, tst_test->dev_fs_opts,
 			  tst_test->dev_extra_opts);
@@ -896,8 +914,11 @@ static void prepare_device(void)
 	}
 
 	if (tst_test->mount_device) {
+		mnt_data = limit_tmpfs_mount_size(tst_test->mnt_data,
+				buf, sizeof(buf), tdev.fs_type);
+
 		SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
-			   tst_test->mnt_flags, tst_test->mnt_data);
+			   tst_test->mnt_flags, mnt_data);
 		mntpoint_mounted = 1;
 	}
 }
@@ -1015,6 +1036,8 @@ static void do_setup(int argc, char *argv[])
 		if (!tdev.dev)
 			tst_brk(TCONF, "Failed to acquire device");
 
+		tdev.size = tst_get_device_size(tdev.dev);
+
 		tst_device = &tdev;
 
 		if (tst_test->dev_fs_type)
-- 
2.31.1

