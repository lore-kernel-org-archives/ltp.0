From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Wed, 30 Sep 2015 11:25:56 +0800
Subject: [LTP] [PATCH 2/2] cpuhotplug_hotplug.sh: do/done should be
	left-aligned
In-Reply-To: <1443583556-20470-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1443583556-20470-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <1443583556-20470-2-git-send-email-weijg.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index d9cf965..ad8675a 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -28,7 +28,7 @@ migrate_irq()
     MASK=$((1<<${CPU}))
     IRQS=$2
     for irq in ${IRQS}
-      do
+    do
       echo $MASK > /proc/irq/${irq}/smp_affinity || \
         tst_resm TINFO "It is NOT permitted to change the IRQ $irq smp_affinity"
     done
-- 
1.9.3

