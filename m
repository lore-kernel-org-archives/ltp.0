From: xiao yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 5 Jan 2018 10:48:51 +0800
Subject: [LTP] [PATCH v5 2/3] syscalls/migrate_pages*: Small cleanup
In-Reply-To: <1515120532-4372-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180104153045.GA25335@rei>
 <1515120532-4372-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1515120532-4372-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Remove unused code
2) Use #ifdef instead of #if

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/include/numa_helper.h                    |  8 ++++----
 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c | 10 ++--------
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c |  9 +--------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
index 39cf7aa..ed45ec8 100644
--- a/testcases/kernel/include/numa_helper.h
+++ b/testcases/kernel/include/numa_helper.h
@@ -20,11 +20,11 @@
 #define NUMA_HELPER_H
 
 #include "config.h"
-#if HAVE_NUMA_H
-#include <numa.h>
+#ifdef HAVE_NUMA_H
+# include <numa.h>
 #endif
-#if HAVE_NUMAIF_H
-#include <numaif.h>
+#ifdef HAVE_NUMAIF_H
+# include <numaif.h>
 #endif
 
 #define NH_MEMS (1 << 0)
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 01409f3..7cdcb31 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -30,18 +30,12 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <errno.h>
-#if HAVE_NUMA_H
-#include <numa.h>
-#endif
-#if HAVE_NUMAIF_H
-#include <numaif.h>
-#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <pwd.h>
-#include "config.h"
+
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/syscalls.h"
@@ -55,7 +49,7 @@ option_t options[] = {
 	{NULL, NULL, NULL}
 };
 
-#if defined(HAVE_NUMA_V2) && defined(__NR_migrate_pages)
+#ifdef HAVE_NUMA_V2
 
 static unsigned long *sane_old_nodes;
 static unsigned long *sane_new_nodes;
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index faf96b6..800b575 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -35,18 +35,11 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <errno.h>
-#if HAVE_NUMA_H
-#include <numa.h>
-#endif
-#if HAVE_NUMAIF_H
-#include <numaif.h>
-#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <pwd.h>
 
-#include "config.h"
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/syscalls.h"
@@ -66,7 +59,7 @@
 char *TCID = "migrate_pages02";
 int TST_TOTAL = 1;
 
-#if defined(HAVE_NUMA_V2) && defined(__NR_migrate_pages)
+#ifdef HAVE_NUMA_V2
 
 static const char nobody_uid[] = "nobody";
 static struct passwd *ltpuser;
-- 
1.8.3.1



