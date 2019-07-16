From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jul 2019 16:16:19 +0200
Subject: [LTP] [COMMITTED] [PATCH] lapi/securebits.h: Fix.
Message-ID: <20190716141619.31427-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I managed to break the original file when applying and made the fallback
definition depend on the existence of the file, which is indeed wrong,
sorry everyone.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/securebits.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/lapi/securebits.h b/include/lapi/securebits.h
index 6207c06cd..2da137c3a 100644
--- a/include/lapi/securebits.h
+++ b/include/lapi/securebits.h
@@ -5,9 +5,13 @@
  */
 #ifndef LAPI_SECUREBITS_H
 #define LAPI_SECUREBITS_H
+
 # ifdef HAVE_LINUX_SECUREBITS_H
 #  include <linux/securebits.h>
-# else
+# endif
+
+# ifndef SECBIT_NO_CAP_AMBIENT_RAISE
 #  define SECBIT_NO_CAP_AMBIENT_RAISE  6
-# endif /* HAVE_LINUX_SECUREBITS_H*/
+# endif
+
 #endif /* LAPI_SECUREBITS_H */
-- 
2.21.0

