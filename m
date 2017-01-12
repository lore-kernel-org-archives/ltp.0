From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 14:23:37 +0100
Subject: [LTP] [PATCH 2/4] vma03: Disable the test on 64bit kernel as well
In-Reply-To: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
References: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
Message-ID: <1484227419-16955-2-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test works only on a 32bit kernel, otherwise we cannot cause the
overflow.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/vma/vma03.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index 31c7716..edad9f4 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -49,6 +49,7 @@
 #include <unistd.h>
 
 #include "test.h"
+#include "tst_kernel.h"
 
 char *TCID = "vma03";
 int TST_TOTAL = 1;
@@ -70,9 +71,11 @@ int main(int argc, char *argv[])
 	void *map, *remap;
 	off_t pgoff;
 
-#if __WORDSIZE != 32
-	tst_brkm(TCONF, NULL, "test is designed for 32-bit system only.");
-#endif
+	if (__WORDSIZE != 32 || tst_kernel_bits() != 32) {
+		tst_brkm(TCONF, NULL,
+			 "test is designed for 32-bit system only.");
+	}
+
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	pgsz = sysconf(_SC_PAGE_SIZE);
-- 
2.7.3

