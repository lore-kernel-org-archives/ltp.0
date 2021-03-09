From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 9 Mar 2021 21:01:15 +0800
Subject: [LTP] [PATCH] lib/tst_supported_fs_types.c: Add tmpfs to filesystem
 whitelist
Message-ID: <20210309130115.9693-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In many embedded system, we need add tmpfs to filesystem whitelist since
there is only tmpfs can be used to test.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>

---------------
v2->v3:
1)skipping mkfs for tmpfs gracefully.
2)replace sprintf with snprintf.
3)remove __func__ in the message
4)replace rmdir with SAFE_RMDIR
---------------
---
 lib/tst_supported_fs_types.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 00ede549d..b5e3cbe85 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -22,6 +22,7 @@ static const char *const fs_type_whitelist[] = {
 	"vfat",
 	"exfat",
 	"ntfs",
+	"tmpfs",
 	NULL
 };

@@ -32,6 +33,11 @@ static int has_mkfs(const char *fs_type)
 	char buf[128];
 	int ret;

+	if (strstr(fs_type, "tmpfs")) {
+		tst_res(TINFO, "mkfs is not needed for tmpfs");
+		return 1;
+	}
+
 	sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);

 	ret = tst_system(buf);
@@ -50,17 +56,28 @@ static int has_kernel_support(const char *fs_type, int flags)
 	static int fuse_supported = -1;
 	const char *tmpdir = getenv("TMPDIR");
 	char buf[128];
+	char template[PATH_MAX];
 	int ret;

 	if (!tmpdir)
 		tmpdir = "/tmp";

-	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
-	if (errno != ENODEV) {
+	snprintf(template, sizeof(template), "%s/mountXXXXXX", tmpdir);
+	if (mkdtemp(template) == NULL) {
+		tst_brk(TBROK | TERRNO , "mkdtemp(%s) failed", template);
+	}
+
+	ret = mount("/dev/zero", template, fs_type, 0, NULL);
+	if ((ret && errno != ENODEV) || !ret) {
+		if (!ret)
+			tst_umount(template);
 		tst_res(TINFO, "Kernel supports %s", fs_type);
+		SAFE_RMDIR(template);
 		return 1;
 	}

+	SAFE_RMDIR(template);
+
 	/* Is FUSE supported by kernel? */
 	if (fuse_supported == -1) {
 		ret = open("/dev/fuse", O_RDWR);
--
2.17.1

