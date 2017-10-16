From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 17:42:01 +0200
Subject: [LTP] [PATCH v4 10/14] hotplug/memory_hotplug: Exit with TCONF when
	NUMA headers not available
In-Reply-To: <20171016154205.4814-1-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
Message-ID: <20171016154205.4814-11-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/hotplug/memory_hotplug/memtoy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
index 1a96d914a..296788e30 100644
--- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
+++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
@@ -24,6 +24,8 @@
 
 #include <stdio.h>
 #include "config.h"
+#include "tst_res_flags.h"
+
 /* Shortcut because the test requires numa and mempolicy support. */
 #if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
 #include <sys/types.h>
@@ -495,6 +497,6 @@ int main(int argc, char *argv[])
 int main(void)
 {
 	printf("System doesn't have required numa support.\n");
-	return 0;
+	return TCONF;
 }
 #endif /* HAVE_NUMA_H && HAVE_NUMAIF_H */
-- 
2.14.2

