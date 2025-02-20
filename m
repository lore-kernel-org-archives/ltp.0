Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE47C021AD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740038024; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=yDspC91YG3N2ZfOXjxwZ/3SBWJIjtlFncOqEb5LgF9M=;
 b=X2WAj1Dgf0zcS3r5RFFPCHX+jkF5voD9zeah1FWC/zRkUrb2DRdWJyATxaZll55hHlXwT
 hmkuYpj3pMXYbMGssyQvL67kjX/qd6615bemk1J/f9SCVku5T/hmKM19d81CTkvXEqqiV56
 noM4BjipAJha8ukHGPVD/+ynaJGqNt4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C2E53C551A
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 08:53:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4A8C3C0FCF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:53:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2AF06226E07
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740038002; x=1771574002;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dEszStPLR4Wh0c1m4gMr4rHoiAJPUgm3+Wvhh+FCCNo=;
 b=B8Q86hZTqTYntwFSg4Xy4ioO9rvVmruKjvaQidpjPjasRzWo3e34399Q
 zBiqo5zXO30ASYEL88iCw5eOot6LmQLD/wrtQtkzKPOJCwHisDqY6lsuP
 CMnETbLAHALgzvuLOW9VdEPqOjTIT9VaxKVupRgGBLU4ThpPLaY8crpG+
 kedPZwgGdIrCNPML6Eur3SEgI27vKh9z71qqzMGvRrk2LhIrhWIUIJHKf
 73Nlemr3kWvr3pmd+RfY9tX23zWzxE+baiNp6nRz7RTD1ork0xIcVwQxx
 41JD+rS4TR5hOBFcntN8z33cyrBiotR0VW4fRzNkfmLI1oIG/1JgzOZdh Q==;
X-CSE-ConnectionGUID: pO/7BekiSaS+MjWiJufN5w==
X-CSE-MsgGUID: IvQrUKCmTRWBaD/2t68sUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="179029366"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="179029366"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 16:53:20 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 057BDD4807
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:53:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BDB67BDB89
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 16:53:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2E7951A0003;
 Thu, 20 Feb 2025 15:53:17 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 20 Feb 2025 15:53:21 +0800
Message-ID: <20250220075321.1123647-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setpgid03: Fix comment indentation to fit RST format
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/setpgid/setpgid03.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 7f360f632..ed72fd347 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -10,12 +10,10 @@
  * Tests setpgid(2) errors:
  *
  * - EPERM The process specified by pid must not be a session leader.
- *
  * - EPERM The calling process, process specified by pid and the target
- *         process group must be in the same session.
- *
+ *   process group must be in the same session.
  * - EACCESS Proccess cannot change process group ID of a child after child
- *           has performed exec()
+ *   has performed exec()
  */
 
 #include <unistd.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
