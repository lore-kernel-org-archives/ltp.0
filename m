From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Mar 2021 16:57:38 +0200
Subject: [LTP] [PATCH 1/1] tst_mkfs: Add -I option to mkfs.vfat
Message-ID: <20210329145738.986-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to workaround occasional error on tests with .all_filesystems flag:

tst_test.c:888: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0',
 not making filesystem (use -I to override)
tst_test.c:888: TBROK: mkfs.vfat failed with exit code 1

Tested also on BusyBox v1.33.0, which accept but ignores -I since
beginning (1.14.0).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Richard also suggested to wipe the device, but not sure how to do it
quickly and don't bring any more dependency.

Kind regards,
Petr

 lib/tst_mkfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 736324f04..2d335a3ad 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -52,6 +52,16 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
 
+	/*
+	 * Workaround a problem:
+	 * mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
+	 * making filesystem (use -I to override)
+	 */
+	if (!strcmp(fs_type, "vfat")) {
+		argv[pos] = "-I";
+		strcat(fs_opts_str, argv[pos++]);
+	}
+
 	if (fs_opts) {
 		for (i = 0; fs_opts[i]; i++) {
 			argv[pos++] = fs_opts[i];
-- 
2.30.2

