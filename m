From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:33 +0200
Subject: [LTP] [PATCH v3 16/18] hotplug/memory_hotplug: Remove unused header
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-17-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/hotplug/memory_hotplug/commands.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 7f271c341..2264346c7 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -30,7 +30,6 @@
 
 #include "config.h"
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H
-#include <linux/mempolicy.h>
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
-- 
2.14.2

