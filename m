Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4501BE7716A
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 05:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734414165; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=9k7Zo2GG3+vyU1/Y8sHkuajmzvEUKsg7kI75/lVrzOc=;
 b=D/D+x6QjlVsD3iowZ2q7rp4+ttyNYDYxg8qv9KSSfVS8d2QcTsUS72vXyyCju5Mt15yTT
 0rm2cK9aMnOjvMWHpyRGE5dUE4oweR7muBta/GC0I6ZxjVoKxSL0/x66P6Wq55cRAx9GIlq
 YKGxWyRMA2s2UhnuK5xvHIAECbuBHFA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57BAB3E298C
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 06:42:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4C993E1313
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 06:42:23 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 939DC14225C2
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 06:42:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1734414143; x=1765950143;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6YYCmqs9+5CQijca2yhUXNO6mOTB/Wr+Qajc8KtLitg=;
 b=XFC/zGLiO1WLJo366LyyNF8F8zISv9uF2MyMU3Yk8FIATIwik4PDqy6G
 NlAIPj92b8j+mzv6zo63rrzmvPYGe0zEvVOgFiTlKY3M9R4jXd//277GO
 bOFk3w1nykVekqK7gE1qXFkpIfFi60m0XKYI1TJDxVUBNh+rn1J6huVdn
 TdZ1Mdc+zKX3r8MNTU+1IVb6ymGqQbciVm+MRB+jZdFOjlJLGTbUCAqn/
 YXBqqYZrmGlFnJL5lYF+G0nObjpj1xWv3n1lpLwd/dWfbNSR4DDPgaQgT
 MSooHUFbE3ulgQxISAiyNOWokegBDokYI29JCLbdfdJzpAjsLUbVm1xrS A==;
X-CSE-ConnectionGUID: LNogJzBqQjinWHV4GzcncQ==
X-CSE-MsgGUID: tfYU6sEgSvamjqNG7+5WRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="162928237"
X-IronPort-AV: E=Sophos;i="6.12,240,1728918000"; d="scan'208";a="162928237"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 14:42:19 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id AD662D5015
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 14:42:16 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F332CF7F7
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 14:42:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 02FEA6BF56
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 14:42:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 90B3E1A000B;
 Tue, 17 Dec 2024 13:42:15 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 13:41:38 +0800
Message-ID: <20241217054138.2967010-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28864.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28864.005
X-TMASE-Result: 10--2.310000-10.000000
X-TMASE-MatchedRID: 60gbRApQc+uhhjsqgSuNbxF4zyLyne+AVBDQSDMig9EnyU5/nZpxUBDO
 9b78NniRb+SLxu/s2gUfMrPgF6OYQ6+/EguYor8cFEUknJ/kEl6YwzE9E8g5OfoLR4+zsDTthUf
 R2rvBju4x3aOcczvmuErRyUmhcwlyIXrZxYVfW0O42fKuo7kW1rgQrvE+hAU70CFP/Y0bIcPpVt
 f38x1UID5ZWl4J4VuJ5LD4QqUpZu4DzEnEoXMLKBXFEH92Kf64nTtPxlIuIBW9Hzj86YHXBCnif
 x5AGfCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] futex_cmp_requeue01: Convert docs to docparse
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
 testcases/kernel/syscalls/futex/futex_cmp_requeue01.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index 872704467..2f3bb70f9 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2019 Xiao Yang <ice_yangxiao@163.com>
+ */
+
+/*\
+ * [Description]
  *
- * Description:
- * Testcase to check the basic functionality of futex(FUTEX_CMP_REQUEUE).
+ * Verify the basic functionality of futex(FUTEX_CMP_REQUEUE).
  * futex(FUTEX_CMP_REQUEUE) can wake up the number of waiters specified
  * by val argument and then requeue the number of waiters limited by val2
  * argument(i.e. move some remaining waiters from uaddr to uaddr2 address).
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
