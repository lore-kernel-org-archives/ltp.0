From: zhao gongyi <zhaogongyi@huawei.com>
Date: Thu, 18 Feb 2021 14:57:58 +0800
Subject: [LTP] [PATCH] lib/tst_mkfs: bugfix for lib/tst_mkfs.c
Message-ID: <20210218065758.230880-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tmpfs is the only one filesystem in many embedded system, so
LTP_DEV_FS_TYPE should be set to tmpfs in many testcases, for
example syscalls/chown04, and in these cases, tests will be failed
because there is no mkfs tool for tmpfs.

Signed-off-by: zhao gongyi <zhaogongyi@huawei.com>
---
 lib/tst_mkfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 45dd83ad3..40141fead 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -44,6 +44,11 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 		return;
 	}

+	if (!strcmp(fs_type, "tmpfs")) {
+		tst_resm_(file, lineno, TINFO, "Need not fomat for TMPFS filesystem");
+		return;
+	}
+
 	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);

 	if (fs_opts) {
--
2.17.1

