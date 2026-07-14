Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043C6C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784018770; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=AfHc4mNp1aM5mg+LHtwRuXpK4cxwejumqkrEx1uA2xM=;
 b=ORukgTILyUtM11cOPSIyLFCnrOYG5LOz3tE8iOZ9svImRKFGlusr8Wix7+ugoNwVlxx0B
 tEeXe3BKE6oNjon6BeDyWkV3iVuoRGPm61fndpk9x2vc863zifoSOpsEXEfJCtlgVonIWmG
 e7UPxA2wsIKIplMFD6Ve+QnaWT6yan4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7008D3E490F
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:46:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFCEF3E212C
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:45:51 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28F7C200743
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:45:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6X5aweevi9nM4aeFDc3MUPxEAq/RyEjoKRJVhAKR7wM=;
 b=V7PkgyjAbVoTcYpVjAzpVO9AGM8/Ot8pBA6fUdbQGqYlCWlqZkr8Uyt7bpI2OrSs1IaqDv5ow
 Mq6P5Vyk4AVHgFpM6+yhN2M+n7TafrT1O23/uMFfQPvYHliN8+oO5eay889jAAIFzZjOdkJYgS/
 ygs33oodgmb93AKY4os4kXc=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gzt251tkGz1K98y;
 Tue, 14 Jul 2026 16:36:29 +0800 (CST)
Received: from dggpemr500010.china.huawei.com (unknown [7.185.36.210])
 by mail.maildlp.com (Postfix) with ESMTPS id BC9FB40586;
 Tue, 14 Jul 2026 16:45:45 +0800 (CST)
Received: from huawei.com (10.50.85.180) by dggpemr500010.china.huawei.com
 (7.185.36.210) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 14 Jul
 2026 16:45:45 +0800
To: <ltp@lists.linux.it>, <andrea.cervesato@suse.com>
Date: Tue, 14 Jul 2026 17:06:32 +0800
Message-ID: <20260714090632.2910506-1-zhanghongtao35@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.50.85.180]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr500010.china.huawei.com (7.185.36.210)
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Revert "tpci: unbind driver in
 test_assign_resources()"
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Hongtao Zhang via ltp <ltp@lists.linux.it>
Reply-To: Hongtao Zhang <zhanghongtao35@huawei.com>
Cc: liuyongqiang13@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

While the patch fixes a use-after-free in /proc/iomem by unbinding and
rebinding the driver around PCI resource reassignment, this approach is
too dangerous for a general test. Unbinding a driver from a critical device
(e.g. a network or block controller) can instantly break SSH connectivity or
cause filesystem corruption. Such side effects are unacceptable compared to the original issue.
So need to revert that patch.

Signed-off-by: Hongtao Zhang <zhanghongtao35@huawei.com>
---
 .../device-drivers/pci/tpci_kernel/ltp_tpci.c     | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index 45138d834..660b3a423 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -442,24 +442,9 @@ static int test_assign_resources(void)
 
 		if (r->flags & IORESOURCE_MEM &&
 			r->flags & IORESOURCE_PREFETCH) {
-
-			if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
-				if (dev->dev.driver)
-					device_release_driver(&dev->dev);
-			}
-
 			pci_release_resource(dev, i);
 			ret = pci_assign_resource(dev, i);
 			prk_info("assign resource to '%d', ret '%d'", i, ret);
-
-			if (ret == 0 && dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
-				int attach_ret;
-
-				attach_ret = device_attach(&dev->dev);
-				if (attach_ret < 0)
-					prk_info("device_attach failed for endpoint, ret: %d", attach_ret);
-			}
-
 			rc |= (ret < 0 && ret != -EBUSY) ? TFAIL : TPASS;
 		}
 	}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
