From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jan 2021 15:54:55 +0100
Subject: [LTP] [PATCH v5 0/3] Kernel module detection (own implementation)
Message-ID: <20210122145458.27964-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

hopefully the latest version.

Changes v4->v5:
* return code is -1 instead of 1 (should be safe, thus I kept it in the
same commit, but can move to separate commit)
* update doc in the header

NOTE: there is a bit of mess in return codes in the C API
(-1 vs 1 returned on error), but that's for another effort.

Kind regards,
Petr

diff --git include/tst_kernel.h include/tst_kernel.h
index 71ab9466b..9e17bb71e 100644
--- include/tst_kernel.h
+++ include/tst_kernel.h
@@ -13,9 +13,11 @@ int tst_kernel_bits(void);
 /**
  * Checks support for the kernel driver.
  *
- * @param name The name of the driver.
- * @return Returns 0 if the kernel has the driver or modprobe is missing.
+ * @param driver The name of the driver.
+ * @return Returns 0 if the kernel has the driver,
+ * -1 when driver is missing or config file not available.
+ * On Android *always* 0 (always expect the driver is available).
  */
-int tst_check_driver(const char *name);
+int tst_check_driver(const char *driver);
 
 #endif	/* TST_KERNEL_H__ */
diff --git lib/tst_kernel.c lib/tst_kernel.c
index b5caf7b20..c908bb04c 100644
--- lib/tst_kernel.c
+++ lib/tst_kernel.c
@@ -139,7 +140,7 @@ static int tst_check_driver_(const char *driver)
 		!tst_search_driver(driver, "modules.builtin"))
 		return 0;
 
-	return 1;
+	return -1;
 }
 
 int tst_check_driver(const char *driver)
@@ -157,7 +158,7 @@ int tst_check_driver(const char *driver)
 	if (!tst_check_driver_(driver))
 		return 0;
 
-	int ret = 1;
+	int ret = -1;
 
 	if (strrchr(driver, '-') || strrchr(driver, '_')) {
 		char *driver2 = strdup(driver);



Petr Vorel (3):
  tst_check_driver(): Fix kernel module detection on BusyBox
  zram: Fix module detection on BusyBox
  tst_net.sh: Require veth for netns (again)

 include/tst_kernel.h                          |   8 +-
 lib/tst_kernel.c                              | 105 ++++++++++++++++--
 .../kernel/device-drivers/zram/zram_lib.sh    |   6 +-
 testcases/lib/tst_net.sh                      |   1 +
 4 files changed, 101 insertions(+), 19 deletions(-)

-- 
2.30.0

