From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 12 Apr 2016 15:15:58 +0800
Subject: [LTP]  [PATCH v2] max_map_count: fix error by using runtime check
In-Reply-To: <20160411170358.GB3466@rei.lan>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
 <56F14D59.1040701@huawei.com> <20160322142842.GE10905@rei.suse.cz>
 <56F259A7.1080908@huawei.com>
 <1242994016.13404335.1458728559657.JavaMail.zimbra@redhat.com>
 <20160331120726.GB21298@rei.lan> <5703A5C6.3000102@huawei.com>
 <20160411170358.GB3466@rei.lan>
Message-ID: <570CA0AE.6020804@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is a error when compile the case to 32bit binary and
run it on 64bit arm kernel, which will wrongly skip one mapping.

Add runtimg check by using the machine from uname(2) to fix it.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/mem/tunable/max_map_count.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index 295a47b..cc7a4e1 100644
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
+static struct utsname un;

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
@@ -133,6 +138,10 @@ static bool filter_map(const char *line)
 	if (!strcmp(buf, "[vdso]"))
 		return true;
 #elif defined(__arm__)
+	/* Skip it when run it in aarch64 */
+	if (strcmp(un.machine, "aarch64"))
+		return false;
+
 	/* Older arm kernels didn't label their vdso maps */
 	if (!strncmp(line, "ffff0000-ffff1000", 17))
 		return true;
-- 
1.8.3.4
