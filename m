Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1Yxpfh-0000Xu-Ij
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:43:57 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Yxpff-0006Er-Rp
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:43:57 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NP10339QMGVXVB0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 28 May 2015 13:43:43 +0900 (KST)
Date: Thu, 28 May 2015 04:42:57 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <2119318669.190461432788177017.JavaMail.weblogic@epmlwas05c>
Subject: [LTP]  [PATCH]: Fix possible NULL pointer derefrence
Reply-To: manjeet.p@samsung.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, Yogesh Narayan Gaur <yn.gaur@samsung.com>

From: Manjeet Pawar <manjeet.p@samsung.com>
Subject: [PATCH] testcases/kernel/device-drivers/usb/tusb/tusb.c: Fix possible NULL pointer derefrence

pdev was accessed before its NULL check, this patch fixes this.

Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
Signed-off-by: Yogesh Gaur <yn.gaur@samsung.com>
---
 testcases/kernel/device-drivers/usb/tusb/tusb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/usb/tusb/tusb.c b/testcases/kernel/device-drivers/usb/tusb/tusb.c
index 774600a..258070a 100644
--- a/testcases/kernel/device-drivers/usb/tusb/tusb.c
+++ b/testcases/kernel/device-drivers/usb/tusb/tusb.c
@@ -386,14 +386,15 @@ static int test_hcd_probe()
 	int rc;
 	struct usb_hcd *hcd = NULL;
 	struct pci_dev *pdev = ltp_usb.pdev;
-	struct pci_device_id *id =
-	    (struct pci_device_id *)pdev->driver->id_table;
+	struct pci_device_id *id = NULL;
 
 	if (!pdev) {
 		printk("tusb: pdev pointer not set\n");
 		return 1;
 	}
 
+	id = (struct pci_device_id *)pdev->driver->id_table;
+
 	if (!id || !id->driver_data) {
 		printk("tusb: id_table not set\n");
 		return 1;
-- 
1.7.9.5


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
