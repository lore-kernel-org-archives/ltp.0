Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F30EF43683
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776415888; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=hvztE4AMkbCR5lpgN5k18NRS0NRkMlAM8XVR3N3jgAM=;
 b=mxfWYD0tkrpXQII7OrijHAd1nfovZjYKZwSg8I7ok76oS5fxK27dOVOkC9CyQqZ3F5eDV
 ou1Jko57rOJRQ0vbwXZ9GcKl2hrOgSJCsUfHcNfLvChq5faeyTgCfcR3XneiPmvoomNNHZe
 56oEWUighdYHeY/CqkDjCFHG0ctGxBo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D39D73E2DF1
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 10:51:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 100993C22A5
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 04:06:49 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 931FB6006F0
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 04:06:47 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=mst2VvAGexRkgpsJeGTSWLDVEZQy44lplyCZkLL3GP8=;
 b=Eryvz9kGZuGBAiIv5r9FbQAQ3nA3kzC7C6tNDcB4AT5jqiQ42giE/LaTHh0PtWAx+0Iaxzj7P
 Sc24FfoDi2WbPF9pcwgmJd14e1+qyGD8xgcRwfbh/UEFecQq2YXlxFMoz2qlsbRk7i6AMfr014r
 LBOs2x0pf7qs5E5WhLbp3FM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fxdPg45mTzLlYX;
 Fri, 17 Apr 2026 10:00:23 +0800 (CST)
Received: from dggpemr500010.china.huawei.com (unknown [7.185.36.210])
 by mail.maildlp.com (Postfix) with ESMTPS id 3154F40561;
 Fri, 17 Apr 2026 10:06:42 +0800 (CST)
Received: from huawei.com (10.50.85.180) by dggpemr500010.china.huawei.com
 (7.185.36.210) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Apr
 2026 10:06:41 +0800
To: <ltp@lists.linux.it>, <krzysztof.kozlowski@canonical.com>, <pvorel@suse.cz>
Date: Fri, 17 Apr 2026 10:29:49 +0800
Message-ID: <20260417022949.2881047-1-zhanghongtao35@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.50.85.180]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr500010.china.huawei.com (7.185.36.210)
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 17 Apr 2026 10:51:05 +0200
Subject: [LTP] [PATCH] tpci: Unbind/rebind driver in test_assign_resources()
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
Cc: bhelgaas@google.com, liuyongqiang13@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

[Problem]
A kernel panic (UAF) occurs during cat /proc/iomem following this sequence:
ltp_tpci test -> remove driver module -> cat /proc/iomem.
The crash happens when the kernel traverses the iomem tree and attempts to
access the driver name of a hinic NIC node.

[Panic Log]
[ 1621.313131] Unable to handle kernel paging request at virtual address ffffc272c2eb21c0
...
[ 1621.699915] Call trace:
[ 1621.706132]  string+0x54/0x130
[ 1621.712899]  vsnprintf+0x248/0x6f0
[ 1621.719989]  seq_printf+0xc4/0xe8
[ 1621.726941]  r_show+0xc4/0x100
[ 1621.733555]  seq_read_iter+0x358/0x478
[ 1621.740846]  proc_reg_read_iter+0x68/0xe8
[ 1621.748410]  vfs_read+0x200/0x2b0
[ 1621.755224]  ksys_read+0x78/0x118
[ 1621.761961]  __arm64_sys_read+0x24/0x38
[ 1621.769169]  invoke_syscall+0x50/0x128
[ 1621.776226]  el0_svc_common.constprop.0+0xc8/0xf0
[ 1621.784206]  do_el0_svc+0x24/0x38
[ 1621.790723]  el0_svc+0x44/0x200
[ 1621.796996]  el0t_64_sync_handler+0x100/0x130
[ 1621.804445]  el0t_64_sync+0x188/0x190

[Output of cat /proc/iomem in vmcore]
(res@ffff284005be3b00):30a000000000-313fffffffff : PCI Bus 0000:95 (name@ffff08400fd074e8)
  (res@ffff282006696778):30a000000000-30a0113fffff : PCI Bus 0000:96 (name@ffff28200668d0e8)
    (res@ffff282006690778):30a000000000-30a0113fffff : PCI Bus 0000:97 (name@ffff28200668f8e8)
      (res@ffff282006693778):30a000000000-30a0044fffff : PCI Bus 0000:9b (name@ffff2820066990e8)
        (res@ffff2820066a7678):30a000000000-30a003bfffff : 0000:9b:00.0 (name@ffff08400fd063d0)
        (res@ffff2820066a74b8):30a003c00000-30a003cfffff : 0000:9b:00.0 (name@ffff08400fd063d0)
        (res@ffff2820066a73b8):30a003d00000-30a003d1ffff : 0000:9b:00.0 (name@ffff08400fd063d0)
        (res@ffff2820066a75f8):30a003d20000-30a003efffff : 0000:9b:00.0 (name@ffff08400fd063d0)
        (res@ffff2820066a7438):30a003f00000-30a003f07fff : 0000:9b:00.0 (name@ffff08400fd063d0)
			(res@ffff28201699cf00):30a0044a0000-30a0044a7fff : gdb: invalid kernel virtual address:	ffffc272c2eb21c0: type:	"gdb readmem callback"
gdb: gdb request failed: dump_iomem
crash>

[Root Cause]
In test_assign_resources(), a hinic BAR is reassigned to a different physical
address. When the hinic driver is later removed, its .remove callback fails to
release the resource because the driver's claimed range no longer matches the
reassigned BAR range.
Consequently, the resource node remains in the iomem tree after the module is
unloaded. Since resource->name points to the module's reclaimed memory,
it becomes a dangling pointer. Traversing /proc/iomem dereferences this
invalid pointer, triggering the UAF panic.

[Fix]
In test_assign_resources(), for end-devices:
unbind drivers before calling pci_release_resource;
rebind driver after pci_assign_resource().

Fixes: d631e9caef68 ("ltp_tpci.c: Add release operation before allocation")
Signed-off-by: Hongtao Zhang <zhanghongtao35@huawei.com>
---
 .../device-drivers/pci/tpci_kernel/ltp_tpci.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index 660b3a423..2790a15d6 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -442,9 +442,26 @@ static int test_assign_resources(void)
 
 		if (r->flags & IORESOURCE_MEM &&
 			r->flags & IORESOURCE_PREFETCH) {
+
+			if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+				if (dev->dev.driver)
+					device_release_driver(&dev->dev);
+			}
+
 			pci_release_resource(dev, i);
 			ret = pci_assign_resource(dev, i);
 			prk_info("assign resource to '%d', ret '%d'", i, ret);
+
+			if (ret == 0) {
+				if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+					int attach_ret;
+
+					attach_ret = device_attach(&dev->dev);
+					if (attach_ret < 0)
+						prk_info("device_attach failed for endpoint, ret: %d", attach_ret);
+				}
+			}
+
 			rc |= (ret < 0 && ret != -EBUSY) ? TFAIL : TPASS;
 		}
 	}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
