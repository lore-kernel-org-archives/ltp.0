From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jun 2020 12:47:32 +0200
Subject: [LTP] [PATCH] [COMMITTED] libltpvdso: Guard the sysv/auxv.h too
Message-ID: <20200626104732.24678-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Obviously this header is only present when the getauxval() function is
present. This should be the last fix.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 libs/libltpvdso/vdso_helpers.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libs/libltpvdso/vdso_helpers.c b/libs/libltpvdso/vdso_helpers.c
index 635270097..208c12f65 100644
--- a/libs/libltpvdso/vdso_helpers.c
+++ b/libs/libltpvdso/vdso_helpers.c
@@ -8,9 +8,12 @@
 #include "tst_test.h"
 
 #include "parse_vdso.h"
-#include <sys/auxv.h>
 #include "config.h"
 
+#ifdef HAVE_GETAUXVAL
+# include <sys/auxv.h>
+#endif /* HAVE_GETAUXVAL */
+
 static unsigned long sysinfo_ehdr;
 
 static void vdso_init(void)
-- 
2.26.2

