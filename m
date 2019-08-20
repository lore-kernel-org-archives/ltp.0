From: zhe.he@windriver.com <zhe.he@windriver.com>
Date: Tue, 20 Aug 2019 22:25:28 +0800
Subject: [LTP] [PATCH] cve: Fix kernel symbol finding for meltdown case
Message-ID: <1566311128-454547-1-git-send-email-zhe.he@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: He Zhe <zhe.he@windriver.com>

meltdown case failed as below.
safe_file_ops.c:219: BROK: Expected 3 conversions got 2 at meltdown.c:272

The case used SAFE_FILE_LINES_SCANF which is a wrapper of vsscanf which cannot
extract the symbol name from the following line pattern of kernel symbol table.

01234567 T SYMBOL_NAME

Also the original format pattern is not correct.

This patch re-writes the symbol extraction process and adds a NULL pointer
check.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 testcases/cve/meltdown.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index f78c38b..4c3f3b2 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -248,15 +248,34 @@ set_cache_hit_threshold(void)
 static unsigned long
 find_symbol_in_file(const char *filename, const char *symname)
 {
-	unsigned long addr;
-	char type;
-	int ret, read;
-	char fmt[strlen(symname) + 64];
+	unsigned long addr = 0;
+	int found = 0;
+	char line[BUFSIZ] = {0};
+	FILE *fp = NULL;
+	char *p = NULL;
+
+	fp = fopen(filename, "r");
+	if (fp == NULL) {
+		tst_res(TBROK | TERRNO,
+			"Failed to open file:%s for symbol:%s",
+			filename, symname);
+		return 0;
+	}
 
-	sprintf(fmt, "%%lx %%c %s%%c", symname);
+	while (fgets(line, BUFSIZ, fp) != NULL) {
+		p = strstr(line, symname);
+		/* Make sure this line is exactly for this symbol.
+		 * Substract the EOL added by fgets for each line.
+		 */
+		if (p && ((strlen(p) - 1) == strlen(symname))) {
+			found = sscanf(line, "%lx", &addr);
+			if (found == 1)
+				break;
+		}
+	}
+	fclose(fp);
 
-	ret = SAFE_FILE_LINES_SCANF(filename, fmt, &addr, &type, &read);
-	if (ret)
+	if (found != 1)
 		return 0;
 
 	return addr;
@@ -322,6 +341,11 @@ static void run(void)
 
 	/* read address of saved_cmdline_addr */
 	addr = saved_cmdline_addr;
+	if (!addr) {
+		tst_res(TBROK | TERRNO, "saved_cmdline_addr is 0\n");
+		return;
+	}
+
 	size = sizeof(addr);
 	for (i = 0; i < size; i++) {
 		ret = readbyte(spec_fd, addr);
-- 
2.7.4

