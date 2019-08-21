From: zhe.he@windriver.com <zhe.he@windriver.com>
Date: Wed, 21 Aug 2019 16:27:24 +0800
Subject: [LTP] [PATCH v2] cve: Fix kernel symbol finding for meltdown case
Message-ID: <1566376044-175216-1-git-send-email-zhe.he@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: He Zhe <zhe.he@windriver.com>

meltdown case fails as below.
safe_file_ops.c:219: BROK: Expected 3 conversions got 2 at meltdown.c:272

find_kernel_symbol is defined to try twice with each of /proc/kallsyms and
/boot/System.map-%s. Currently if the symbol is not found in /proc/kallsyms,
when kernel option CONFIG_KALLSYMS_ALL is disabled, it would stop the case
immediately due to SAFE_FILE_LINES_SCANF.

This patch turns to use FILE_LINES_SCANF to give find_kernel_symbol second
chance.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 testcases/cve/meltdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index f78c38b..2d66c1e 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -255,7 +255,7 @@ find_symbol_in_file(const char *filename, const char *symname)
 
 	sprintf(fmt, "%%lx %%c %s%%c", symname);
 
-	ret = SAFE_FILE_LINES_SCANF(filename, fmt, &addr, &type, &read);
+	ret = FILE_LINES_SCANF(filename, fmt, &addr, &type, &read);
 	if (ret)
 		return 0;
 
-- 
2.7.4

