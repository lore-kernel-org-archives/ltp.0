From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 13:11:01 +0200
Subject: [LTP] [PATCH v5 07/12] hotplug/memory_hotplug: Remove unused header
In-Reply-To: <20171018111106.17215-1-pvorel@suse.cz>
References: <20171018111106.17215-1-pvorel@suse.cz>
Message-ID: <20171018111106.17215-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/hotplug/memory_hotplug/commands.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 7f271c341..35056b5b6 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -29,8 +29,7 @@
  */
 
 #include "config.h"
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H
-#include <linux/mempolicy.h>
+#if HAVE_NUMA_H && HAVE_NUMAIF_H
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
-- 
2.14.2

