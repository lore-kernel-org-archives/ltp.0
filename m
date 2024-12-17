Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A267E7716A
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734424301; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=2lZY8GvVZwdk0IefkEN6MiboG+yrycoQxNn7UJMpKfM=;
 b=lDL7muwb8QZ0m1FVVJ91CT2FpyR0/kxlS/T8QcCIR+9YEemKWJ6eN7cZ2JQuUDFlM+CSW
 Refnp57NjsTydluLunCpKFIz6iKgRijL0ZFKVtINUZRYiVPYDlp4yw+xqiHF+aeGKw0ThVU
 oIf0j0wEfzIAgQyXGk2IvVciev0d/hs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDACC3EB33D
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 09:31:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBDC73E5232
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 09:31:20 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2629463A4FC
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 09:31:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1734424279; x=1765960279;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OOoOBH9c87vI1geQ6ccaUCcXlRX+riSsrbT86nt9iZc=;
 b=h6c41X5Qs5chI68rbUHw7x95tHLjf0ckqrMeJQ4fTSH0SObTJVIS8d8p
 +gk6S1GUTvyW/QGe+ieY7jlSPnsl1wHuz475Xaw6aSf3raT9dvKnp4Pof
 HvbNTO2FDk+GFfezGXpL9ydaONwSMETvP+A/F67uUzaNA7sZNi4AXtAdY
 7OOGqufiESY4I12Ww8C/19UfaeeM13BZLCuXzk8zHtn7CUu/q5I2FrEHf
 Ji0RYMS/wvvUEpCt56O6hnriDSnZyAUBjr1ntxbocfBbvAYuas9y6lJyH
 tOuSOaYWd0wP/T0qZ6JFIQFUAEI+ux4FfjrLAZIVle2HZ+hcX8doGIyOW g==;
X-CSE-ConnectionGUID: jMBfKGbmT0yibpBgsTBekw==
X-CSE-MsgGUID: A+p6OFPLSZyCgplNiR9TLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="184235599"
X-IronPort-AV: E=Sophos;i="6.12,241,1728918000"; d="scan'208";a="184235599"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 17:31:16 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7300BD5019
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 17:31:14 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 44AEED50E3
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 17:31:14 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CDB8A3479C
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 17:31:13 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3964D1A000B;
 Tue, 17 Dec 2024 16:31:13 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 16:30:55 +0800
Message-ID: <20241217083055.2995853-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28864.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28864.006
X-TMASE-Result: 10--4.337700-10.000000
X-TMASE-MatchedRID: BrApPpprBkTyq/cli2hvDU7nLUqYrlslNmVjpriVEtmmOWRsO8Mnh6Jf
 gPmvd/XOQDpE8046et1gRWLzgh5fxo9oUcx9VMLgFEUknJ/kEl6YwzE9E8g5OfoLR4+zsDTthUf
 R2rvBju5fM4b1zazFrQ/LoyBXG0xsO6un6n0klX9sQMCzouJ+J1uk4WADmyiX9K3hyhvaFS1Utb
 1m4P8/hyrYb2mwfcv6Ti/P/Uh+rWNYOUxqOZP8HxXFEH92Kf64nTtPxlIuIBW9Hzj86YHXBCnif
 x5AGfCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] vmsplice02: Convert docs to docparse
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
 .../kernel/syscalls/vmsplice/vmsplice02.c      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index 8f1965c2e..24ff3c0f8 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -3,15 +3,15 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
  */
-/*
- * Description:
- *   Verify that,
- *   1) vmsplice() returns -1 and sets errno to EBADF if fd
- *      is not valid.
- *   2) vmsplice() returns -1 and sets errno to EBADF if fd
- *      doesn't refer to a pipe.
- *   3) vmsplice() returns -1 and sets errno to EINVAL if
- *      nr_segs is greater than IOV_MAX.
+
+/*\
+ * [Description]
+ *
+ * Verify that, vmsplice(2) returns -1 and sets errno to:
+ *
+ * - EBADF if fd is not valid.
+ * - EBADF if fd doesn't refer to a pipe.
+ * - EINVAL if nr_segs is greater than IOV_MAX.
  */
 
 #define _GNU_SOURCE
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
