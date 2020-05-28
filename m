From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2020 13:15:04 +0200
Subject: [LTP] [PATCH 1/1] tst_taint.h Add taint for randstruct
Message-ID: <20200528111504.12638-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added in kernel 4.17.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_taint.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/tst_taint.h b/include/tst_taint.h
index 0acc1140c..cfa84dded 100644
--- a/include/tst_taint.h
+++ b/include/tst_taint.h
@@ -60,7 +60,8 @@
 #define TST_TAINT_E     (1 << 13) /* unsigned module was loaded */
 #define TST_TAINT_L     (1 << 14) /* A soft lock-up has previously occurred */
 #define TST_TAINT_K     (1 << 15) /* kernel has been live-patched */
-#define TST_TAINT_X	(1 << 16) /* auxiliary taint, for distro's use */
+#define TST_TAINT_X     (1 << 16) /* auxiliary taint, for distro's use */
+#define TST_TAINT_T     (1 << 17) /* kernel was built with the struct randomization plugin */
 
 /*
  * Initialize and prepare support for checking tainted kernel.
-- 
2.26.2

