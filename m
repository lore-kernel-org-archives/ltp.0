From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 4 Mar 2021 10:08:38 +0800
Subject: [LTP] [PATCH] lib/tst_supported_fs_types.c: Add tmpfs to filesystem
 whitelist
Message-ID: <20210304020838.259422-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In many Embedded system, we need add tmpfs wo filesystem whitelist since
there is only tmpfs can be used to test.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>

---------------
v1->v2:
1)create a unique temporary directory under TMPDIR and use it as a mount
point in the has_kernel_support() function.
2)add tst_umount after mount.
---------------

---
 lib/tst_supported_fs_types.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 00ede549d..964efb659 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -22,6 +22,7 @@ static const char *const fs_type_whitelist[] = {
 	"vfat",
 	"exfat",
 	"ntfs",
+	"tmpfs",
 	NULL
 };

@@ -34,6 +35,10 @@ static int has_mkfs(const char *fs_type)

 	sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);

+	if (strstr(buf, "mkfs.tmpfs")) {
+		return 1;
+	}
+
 	ret = tst_system(buf);

 	if (WEXITSTATUS(ret) == 127) {
@@ -50,17 +55,30 @@ static int has_kernel_support(const char *fs_type, int flags)
 	static int fuse_supported = -1;
 	const char *tmpdir = getenv("TMPDIR");
 	char buf[128];
+	char template[PATH_MAX];
 	int ret;

 	if (!tmpdir)
 		tmpdir = "/tmp";

-	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
-	if (errno != ENODEV) {
+	sprintf(template, "%s/mountXXXXXX", tmpdir);
+	if (mkdtemp(template) == NULL) {
+		tst_res(TWARN | TERRNO , "%s: mkdtemp(%s) failed", __func__, template);
+	}
+
+	ret = mount("/dev/zero", template, fs_type, 0, NULL);
+	if ((ret && errno != ENODEV) || !ret) {
+		if (!ret)
+			tst_umount(template);
 		tst_res(TINFO, "Kernel supports %s", fs_type);
+		if (rmdir(template) == -1)
+			tst_res(TWARN | TERRNO, "rmdir %s failed", template);
 		return 1;
 	}

+	if (rmdir(template) == -1)
+		tst_res(TWARN | TERRNO, "rmdir %s failed", template);
+
 	/* Is FUSE supported by kernel? */
 	if (fuse_supported == -1) {
 		ret = open("/dev/fuse", O_RDWR);
--
2.17.1

