From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Fri, 26 Feb 2021 17:06:15 +0800
Subject: [LTP] [PATCH] lib/tst_supported_fs_types.c: Add tmpfs to filesystem
 whitelist
Message-ID: <20210226090615.231970-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In many Embedded system, we need add tmpfs wo filesystem whitelist since
there is only tmpfs can be used to test.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 lib/tst_supported_fs_types.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 00ede549d..696b6731e 100644
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
@@ -55,8 +60,8 @@ static int has_kernel_support(const char *fs_type, int flags)
 	if (!tmpdir)
 		tmpdir = "/tmp";

-	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
-	if (errno != ENODEV) {
+	ret = mount("/dev/zero", tmpdir, fs_type, 0, NULL);
+	if (!ret) {
 		tst_res(TINFO, "Kernel supports %s", fs_type);
 		return 1;
 	}
--
2.17.1

