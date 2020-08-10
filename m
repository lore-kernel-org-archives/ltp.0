From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Aug 2020 15:32:10 +0200
Subject: [LTP] [PATCH] [COMMITTED] lapi/fs.h: Include <sys/types.h>
Message-ID: <20200810133210.19219-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To get the loff_t defined.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 430d21f27..8b54afd43 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -10,6 +10,7 @@
 # include <linux/fs.h>
 #endif
 
+#include <sys/types.h>
 #include <sys/user.h>
 #include <limits.h>
 #include "lapi/abisize.h"
-- 
2.26.2

