Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Vb7yh-000652-7k
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 12:00:55 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vb7yf-0008Jj-BM
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 12:00:55 +0000
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 29 Oct 2013 16:00:11 +0400
Message-Id: <1383048011-29518-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers: pci: check memory region for flag
	IORESOURCE_PREFETCH
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

This is done to make sure there will be no side effects if we change it somehow
in the test (e.g. we're not changing I/O ports implemented as memory regions).

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 .../device-drivers/pci/tpci_kernel/ltp_tpci.c      |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index 4e92f5e..71d94db 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -99,8 +99,6 @@ static int probe_pci_dev(unsigned int bus, unsigned int slot)
 {
 	struct pci_dev *dev;
 
-	prk_info("find arbitrary pci device for test");
-
 	if (ltp_pci.dev) {
 		pci_dev_put(ltp_pci.dev);
 		ltp_pci.dev = NULL;
@@ -467,7 +465,7 @@ static int test_assign_resources(void)
 			r->name, r->flags,
 			(unsigned long)r->start, (unsigned long)r->end);
 
-		if ((r->flags & IORESOURCE_MEM) == IORESOURCE_MEM) {
+		if (r->flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH)) {
 			ret = pci_assign_resource(dev, i);
 			prk_info("assign resource to '%d', ret '%d'", i, ret);
 			rc |= (ret < 0 && ret != -EBUSY) ? TFAIL : TPASS;
@@ -718,8 +716,6 @@ static ssize_t sys_bus_slot(struct device *dev,
 	bus = res >> 8 & 0xFF;
 	slot = res & 0xFF;
 
-	prk_info("get bus '%u' slot '%u'", bus, slot);
-
 	ret = probe_pci_dev(bus, slot);
 	if (ret)
 		return ret;
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
