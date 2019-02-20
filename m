From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Feb 2019 16:17:49 +0100
Subject: [LTP] [PATCH] [COMMITTED] lapi/include/ustat.h: Include config.h
Message-ID: <20190220151749.5506-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Otherwise we don't use the system ustat.h header at all.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/ustat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/lapi/ustat.h b/include/lapi/ustat.h
index b32749925..12c073582 100644
--- a/include/lapi/ustat.h
+++ b/include/lapi/ustat.h
@@ -3,6 +3,8 @@
 #ifndef LAPI_USTAT_H
 #define LAPI_USTAT_H
 
+#include "config.h"
+
 #include <sys/types.h>
 
 #ifdef HAVE_SYS_USTAT_H
-- 
2.19.2

