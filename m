Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VbTql-0000vW-Lj
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 11:22:11 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VbTqj-0002gQ-Qy
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 11:22:11 +0000
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Oct 2013 15:21:33 +0400
Message-Id: <1383132093-4920-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers: pci: fix PCI_EXP_CAP_CONFIG test-case
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

There is another way to check that PCI Express config space of pci devices
can be read successfully.
Firstly, find out if a device has a PCI Express Capability: we should get
a correct config address offset from the dev's structure (dev->pcie_cap).
Using the offset, read a PCI Express header. Check if we can get the right
PCI Express CAP ID from the header (it must match the PCI_CAP_ID_EXP macro).

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 .../device-drivers/pci/tpci_kernel/ltp_tpci.c      |   54 ++++++--------------
 .../kernel/device-drivers/pci/tpci_kernel/tpci.h   |    1 -
 2 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index d2ffacd..4cfcc30 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -541,28 +541,6 @@ static int test_find_cap(void)
 }
 
 /*
- * test_find_pci_exp_cap
- *	make call to pci_find_capability, which will
- *	determine if a device has PCI-EXPRESS capability,
- *	use second parameter to specify which capability
- *	you are looking for
- */
-static int test_find_pci_exp_cap(void)
-{
-	struct pci_dev *dev = ltp_pci.dev;
-
-	prk_info("find PCIe capability");
-
-	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
-		prk_info("device has PCI-EXP capability");
-		return TPASS;
-	}
-
-	prk_info("device doesn't have PCI-EXP capability");
-	return TFAIL;
-}
-
-/*
  * test_read_pci_exp_config
  *	make call to pci_config_read and determine if
  *	the PCI-Express enhanced config space of this
@@ -570,37 +548,35 @@ static int test_find_pci_exp_cap(void)
  */
 static int test_read_pci_exp_config(void)
 {
-	/* PCI-Exp enhanced config register 0x100, 4 implies dword access */
-	int reg = 100;
+	int pos;
+	u32 header;
 	struct pci_dev *dev = ltp_pci.dev;
-	u32 data;
 
 	/* skip the test if device doesn't have PCIe capability */
-	if (test_find_pci_exp_cap() == TFAIL)
+	pos = pci_pcie_cap(dev);
+	if (!pos) {
+		prk_info("device doesn't have PCI-EXP capability");
 		return TSKIP;
+	}
+	prk_info("read the PCI Express configuration registers at 0x%x", pos);
 
-	prk_info("dev on bus(%d) & slot (%d)", dev->bus->number, dev->devfn);
-	prk_info("reading the PCI Express configuration registers---");
-	prk_info("reading PCI-Express AER CAP-ID REGISTER at Enh-Cfg AddrSpace 0x100");
-
-	if (pci_read_config_dword(dev, reg, &data)) {
-		prk_err("failed to read config word");
+	if (pci_read_config_dword(dev, pos, &header)) {
+		prk_err("failed to read config dword");
 		return TFAIL;
 	}
 
-	/* comparing the value read with AER_CAP_ID_VALUE macro */
-	if (data == AER_CAP_ID_VALUE) {
-		prk_info("correct val read using PCIE driver installed: '%u'",
-			data);
+	/* comparing the value read with PCI_CAP_ID_EXP macro */
+	if ((header & 0x000000ff) == PCI_CAP_ID_EXP) {
+		prk_info("correct val read using PCIE driver installed: 0x%x",
+			header);
 		return TPASS;
 	}
 
-	prk_err("incorrect val read. PCIE driver/device not installed: '%u'",
-		data);
+	prk_err("incorrect val read. PCIE driver/device not installed: 0x%x",
+		header);
 	return TFAIL;
 }
 
-
 static int test_case(unsigned int cmd)
 {
 	int rc = TSKIP;
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
index d5ee669..f65c6fc 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
@@ -20,7 +20,6 @@
 #define PCI_DEVICE_NAME		"ltp_tpci"
 #define MAX_DEVFN		256
 #define MAX_BUS			256
-#define AER_CAP_ID_VALUE	0x14011
 
 enum PCI_TCASES {
 	PCI_DISABLE = 0,
-- 
1.7.1


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
