From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 13 May 2020 15:06:54 +0800
Subject: [LTP] [PATCH v1 2/2] tpci: Remove deprecated CONFIG_HOTPLUG
In-Reply-To: <1589353614-24423-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1589353614-24423-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1589353614-24423-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel commit 40b313608ad4 ("Finally eradicate CONFIG_HOTPLUG"),
it always supports hotplug. It is about 7 years old and many distributions
don't have this config, so we can remove it safely.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 README.kernel_config                                       | 1 -
 testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/README.kernel_config b/README.kernel_config
index ffb2dec95..547dd4f33 100644
--- a/README.kernel_config
+++ b/README.kernel_config
@@ -131,7 +131,6 @@ CONFIG_KEXEC_JUMP=y
 ---------------------------------
 Enabling HOTPLUG for your Kernels
 ---------------------------------
-CONFIG_HOTPLUG=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ACPI_HOTPLUG_CPU=y
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index a57953db6..e29821dda 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -290,7 +290,6 @@ static int test_find_subsys(void)
  */
 static int test_scan_bus(void)
 {
-#ifdef CONFIG_HOTPLUG
 	int num;
 	struct pci_bus *bus = ltp_pci.bus;
 
@@ -307,10 +306,6 @@ static int test_scan_bus(void)
 	}
 	prk_info("success scan bus");
 	return TPASS;
-#else
-	prk_info("pci_rescan_bus() is not supported");
-	return TSKIP;
-#endif
 }
 
 /*
-- 
2.23.0



