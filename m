From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Wed, 7 Oct 2015 09:45:36 +0800
Subject: [LTP] [PATCH v2 2/2] cpuhotplug_hotplug.sh: change the style of
	for-loop
In-Reply-To: <1444182336-14628-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <20150930121613.GA8132@rei.suse.cz>
 <1444182336-14628-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <1444182336-14628-2-git-send-email-weijg.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Let do and for cycles on same line by using semicolon.

Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index d9cf965..f23463b 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -27,8 +27,7 @@ migrate_irq()
     CPU=${1#cpu}
     MASK=$((1<<${CPU}))
     IRQS=$2
-    for irq in ${IRQS}
-      do
+    for irq in ${IRQS}; do
       echo $MASK > /proc/irq/${irq}/smp_affinity || \
         tst_resm TINFO "It is NOT permitted to change the IRQ $irq smp_affinity"
     done
-- 
1.9.3

