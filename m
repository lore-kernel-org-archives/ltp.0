From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 12 Jul 2018 16:56:50 +0800
Subject: [LTP] [PATCH] zram/zram03.c: Fix obsolete zram status files
Message-ID: <1531385810-22036-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel commit c87d1655c295, separate zram status files("compr_data_size",
"num_reads" etc.) which can be accessed via one of zram<id>/stat or
zram<id>/io_stat or zram<id>/mm_stat were removed.

This commit broke zram03, as below:
----------------------------------------------------------------------
safe_file_ops.c:144: Failed to open FILE '/sys/block/zram0/compr_data_size'
for reading at zram03.c:181: errno=ENOENT(2): No such file or directory
----------------------------------------------------------------------

Also, zero pages in zram<id>/mm_stat was extended to same element pages
since kernel commit 8e19d540d107.

We try to get requested zram status by zram<id>/stat and zram<id>/mm_stat
if separate zram status files don't exist.

URL for detailed zram status:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/blockdev/zram.txt
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/stat.txt

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/device-drivers/zram/zram03.c | 50 +++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index 3f7ab4e..06995fd 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -40,6 +40,9 @@ char *TCID = "zram03";
 int TST_TOTAL = 1;
 
 #define PATH_ZRAM	"/sys/block/zram0"
+#define OBSOLETE_ZRAM_FILE	"/sys/block/zram0/num_reads"
+#define PATH_ZRAM_STAT	"/sys/block/zram0/stat"
+#define PATH_ZRAM_MM_STAT	"/sys/block/zram0/mm_stat"
 #define SIZE		(512 * 1024 * 1024L)
 #define DEVICE		"/dev/zram0"
 
@@ -182,14 +185,49 @@ static void print(char *string)
 	tst_resm(TINFO, "%s is %s", filename, value);
 }
 
+static void print_stat(char *nread, char *nwrite)
+{
+	char nread_val[BUFSIZ], nwrite_val[BUFSIZ];
+
+	SAFE_FILE_SCANF(cleanup, PATH_ZRAM_STAT, "%s %*s %*s %*s %s",
+			nread_val, nwrite_val);
+	tst_resm(TINFO, "%s from %s is %s", nread, PATH_ZRAM_STAT,
+		 nread_val);
+	tst_resm(TINFO, "%s from %s is %s", nwrite, PATH_ZRAM_STAT,
+		 nwrite_val);
+}
+
+static void print_mm_stat(char *orig, char *compr, char *mem, char *zero)
+{
+	char orig_val[BUFSIZ], compr_val[BUFSIZ];
+	char mem_val[BUFSIZ], zero_val[BUFSIZ];
+
+	SAFE_FILE_SCANF(cleanup, PATH_ZRAM_MM_STAT, "%s %s %s %*s %*s %s",
+			orig_val, compr_val, mem_val, zero_val);
+	tst_resm(TINFO, "%s from %s is %s", orig, PATH_ZRAM_MM_STAT,
+		 orig_val);
+	tst_resm(TINFO, "%s from %s is %s", compr, PATH_ZRAM_MM_STAT,
+		compr_val);
+	tst_resm(TINFO, "%s from %s is %s", mem, PATH_ZRAM_MM_STAT,
+		 mem_val);
+	tst_resm(TINFO, "%s from %s is %s", zero, PATH_ZRAM_MM_STAT,
+		 zero_val);
+}
+
 static void dump_info(void)
 {
 	print("initstate");
-	print("compr_data_size");
-	print("orig_data_size");
 	print("disksize");
-	print("mem_used_total");
-	print("num_reads");
-	print("num_writes");
-	print("zero_pages");
+	if (!access(OBSOLETE_ZRAM_FILE, F_OK)) {
+		print("orig_data_size");
+		print("compr_data_size");
+		print("mem_used_total");
+		print("zero_pages");
+		print("num_reads");
+		print("num_writes");
+	} else {
+		print_mm_stat("orig_data_size", "compr_data_size",
+			      "mem_used_total", "zero/same_pages");
+		print_stat("num_reads", "num_writes");
+	}
 }
-- 
1.8.3.1



