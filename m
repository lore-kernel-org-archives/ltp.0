From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 23 Mar 2016 16:53:59 +0800
Subject: [LTP]  [PATCH] max_map_count: fix error by using runtime check
In-Reply-To: <20160322142842.GE10905@rei.suse.cz>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
 <56F14D59.1040701@huawei.com> <20160322142842.GE10905@rei.suse.cz>
Message-ID: <56F259A7.1080908@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is a error when compile the case to 32bit binary and
run it on 64bit arm kernel, which will wrongly skip one mapping.

Do runtimg check using the machine from uname(2) to fix it.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/tunable/max_map_count.c | 32 +++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index 295a47b..a69e560 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -59,6 +59,7 @@
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/utsname.h>
 #include "test.h"
 #include "mem.h"

@@ -70,6 +71,7 @@ int TST_TOTAL = 1;

 static long old_max_map_count;
 static long old_overcommit;
+struct utsname un;

 static long count_maps(pid_t pid);
 static void max_map_count_test(void);
@@ -104,6 +106,9 @@ void setup(void)
 	old_max_map_count = get_sys_tune("max_map_count");
 	old_overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 2, 1);
+
+	if (uname(&un) != 0)
+		tst_brkm(TBROK | TERRNO, NULL, "uname error");
 }

 void cleanup(void)
@@ -124,19 +129,20 @@ static bool filter_map(const char *line)
 	if (ret != 1)
 		return false;

-#if defined(__x86_64__) || defined(__x86__)
-	/* On x86, there's an old compat vsyscall page */
-	if (!strcmp(buf, "[vsyscall]"))
-		return true;
-#elif defined(__ia64__)
-	/* On ia64, the vdso is not a proper mapping */
-	if (!strcmp(buf, "[vdso]"))
-		return true;
-#elif defined(__arm__)
-	/* Older arm kernels didn't label their vdso maps */
-	if (!strncmp(line, "ffff0000-ffff1000", 17))
-		return true;
-#endif
+	if (strstr(un.machine, "x86") != NULL)
+		/* On x86, there's an old compat vsyscall page */
+		if (!strcmp(buf, "[vsyscall]"))
+			return true;
+
+	if (strstr(un.machine, "ia64") != NULL)
+		/* On ia64, the vdso is not a proper mapping */
+		if (!strcmp(buf, "[vdso]"))
+			return true;
+
+	if (strstr(un.machine, "armv") != NULL)
+		/* Older arm kernels didn't label their vdso maps */
+		if (!strncmp(line, "ffff0000-ffff1000", 17))
+			return true;

 	return false;
 }
-- 
1.8.3.4
