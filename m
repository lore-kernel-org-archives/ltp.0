From: Chen Li <chenli@uniontech.com>
Date: Sat, 07 Mar 2020 15:14:52 +0800
Subject: [LTP] Subject: [PATCH] Update legacy codes in ltp_tpci.c
Message-ID: <87mu8smyab.wl-chenli@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The kernel api used in ltp_tpci.c is too old and connot pass compile
after 3.12.

Signed-off-by: Li Chen <chenli@uniontech.com>
---
 .../device-drivers/pci/tpci_kernel/ltp_tpci.c | 30 ++-----------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index 2cf8cefc8..7cbabfaa5 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -61,7 +61,7 @@ MODULE_LICENSE("GPL");
 #define TFAIL	1
 #define TSKIP	32

-static DEFINE_PCI_DEVICE_TABLE(ltp_pci_tbl) = {
+static const struct pci_device_id ltp_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) },
 	{ 0, }
 };
@@ -104,7 +104,7 @@ static int probe_pci_dev(unsigned int bus, unsigned int slot)
 		ltp_pci.dev = NULL;
 	}

-	dev = pci_get_bus_and_slot(bus, slot);
+	dev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), bus, slot);
 	if (!dev || !dev->driver)
 		return -ENODEV;

@@ -360,29 +360,6 @@ static int test_bus_add_devices(void)
 	return TFAIL;
 }

-/*
- * test_enable_bridges
- *	make call to pci_enable_bridges,
- *	use bus pointer from the ltp_pci
- *	structure
- */
-static int test_enable_bridges(void)
-{
-	struct pci_bus *bus = ltp_pci.bus;
-
-	prk_info("enable bridges");
-
-	pci_enable_bridges(bus);
-
-	if (bus) {
-		prk_info("called enable bridges");
-		return TPASS;
-	}
-
-	prk_err("enable_bridges failed");
-	return TFAIL;
-}
-
 /*
  * test_match_device
  *	make call to pci_match_device, returns a
@@ -609,9 +586,6 @@ static int test_case(unsigned int cmd)
 	case BUS_ADD_DEVICES:
 		rc = test_bus_add_devices();
 		break;
-	case ENABLE_BRIDGES:
-		rc = test_enable_bridges();
-		break;
 	case MATCH_DEVICE:
 		rc = test_match_device();
 		break;
--
2.25.0


