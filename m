From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Aug 2021 16:29:49 +0200
Subject: [LTP] [PATCH] [COMMITTED] lapi/ip_tables.h: Fix build on older
 distributions
Message-ID: <20210805142949.10834-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On older distributions the linux/netfilter_ipv4/ip_tables.h does not
include a header that would define IFNAMSIZ and the build fails.

This effectivelly moves the #include <net/if.h> from the setsockopt03.c
to the lapi/ip_tables.h which fixes the build.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Fixes: 5684bec6b480 (API: Add lapi/ip_tables.h and use it in setsockopt03)
---
 include/lapi/ip_tables.h                            | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt03.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/ip_tables.h b/include/lapi/ip_tables.h
index e91238ffd..3ac62141c 100644
--- a/include/lapi/ip_tables.h
+++ b/include/lapi/ip_tables.h
@@ -5,6 +5,7 @@
 
 #include "config.h"
 
+#include <net/if.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 
 #ifndef HAVE_STRUCT_XT_ENTRY_MATCH
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
index 1434475db..b7a4447ba 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -19,7 +19,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
-#include <net/if.h>
 #include <limits.h>
 
 #include "tst_test.h"
-- 
2.31.1

