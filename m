From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 16 Nov 2020 10:52:09 +0000
Subject: [LTP] [PATCH] madvise06: Allow for kmem and memsw counters being
 disabled
Message-ID: <20201116105209.20395-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These may be missing and we only access them for printing diagnostic
info.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 2ba2bac6f..dc515d528 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -64,14 +64,16 @@ static void check_path(const char *path)
 }
 
 #define READ_CGMEM(item)						\
-	({long tst_rval;						\
-	  SAFE_FILE_LINES_SCANF(MNT_NAME"/"GROUP_NAME"/memory."item, 	\
-				"%ld",					\
-				&tst_rval);				\
+	({long tst_rval = 0;						\
+	  const char *cgpath = MNT_NAME"/"GROUP_NAME"/memory."item;	\
+	  if (!access(cgpath, R_OK))					\
+		  SAFE_FILE_LINES_SCANF(cgpath, "%ld", &tst_rval);	\
 	  tst_rval;})
 
 static void meminfo_diag(const char *point)
 {
+	long rval;
+
 	FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
 	tst_res(TINFO, "%s", point);
 	tst_res(TINFO, "\tSwap: %ld Kb",
@@ -82,10 +84,14 @@ static void meminfo_diag(const char *point)
 		SAFE_READ_MEMINFO("Cached:") - init_cached);
 	tst_res(TINFO, "\tcgmem.usage_in_bytes: %ld Kb",
 		READ_CGMEM("usage_in_bytes") / 1024);
-	tst_res(TINFO, "\tcgmem.memsw.usage_in_bytes: %ld Kb",
-		READ_CGMEM("memsw.usage_in_bytes") / 1024);
-	tst_res(TINFO, "\tcgmem.kmem.usage_in_bytes: %ld Kb",
-		READ_CGMEM("kmem.usage_in_bytes") / 1024);
+
+	rval = READ_CGMEM("memsw.usage_in_bytes") / 1024;
+	if (rval)
+		tst_res(TINFO, "\tcgmem.memsw.usage_in_bytes: %ld Kb", rval);
+
+	rval = READ_CGMEM("kmem.usage_in_bytes") / 1024;
+	if (rval)
+		tst_res(TINFO, "\tcgmem.kmem.usage_in_bytes: %ld Kb", rval);
 }
 
 static void setup(void)
-- 
2.29.1

