Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E464C54798
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709024234; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=3bqQ+GWiOcyhpneBrQ57iCQXZgwWkz8dzizhumt0LN4=;
 b=l9aovq1cdxSkdo/+cg2lAOAlYBdp7S5U1goZYgOiuaDF40vNaUcFuEcf/UDosQiAB1xup
 bKyPYJVsvHY7qxBb3Q8QyPi/g/SK3PVEJb+K9LaW0SNZ9rqhHLw3mvPSzCUxx4TjXsl7cGI
 EYYP7hbCzerKZ+pNLTb0K9w2TVaw5ts=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 795A23CEF14
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 09:57:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DA483CAB09
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 09:56:53 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4532120111A
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 09:56:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1709024213; x=1740560213;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w2cqtmCAAgU0oq3bxhXpEB+zYbQwytdniIpp2SCuz5U=;
 b=GGui+Kssi8B/Oz84ltHA3+XyW0VNr7GDq1EFER/0FAeHtdKeBz9oRxXj
 3JThmTUMlNRpEBuS/GwRn3za3a4hMqcmUb02HRgRtiiubmP7mT+fn45vy
 WyR6/cW8qIKSQuOt01OBmM0GtlsJx0RdGb0lR7F8kQK0kxWnLPF72Ep3k
 KtogMZUbqmCHalnSr//i35QirfaWjsoKpXQ2I7knpww+HMCiQEQmGU5+M
 g3S5EApGYHcyTBg+z+t4vjzQUgfgGiY4U5uwI7r3ij9gFwjJkOp2VhA/4
 E/+zzyAQJ2e5UJaoUe/qe8IJY4EWx+zUeh6KLI2JfPQ6gbT4i1l4WkcmT Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="150397184"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; d="scan'208";a="150397184"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 17:56:50 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id ACDE6221CCA
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:56:47 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E6956D506C
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:56:46 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7182C41055
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:56:46 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 190CA1A006A;
 Tue, 27 Feb 2024 16:56:46 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 27 Feb 2024 03:56:40 -0500
Message-Id: <20240227085641.33715-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28216.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28216.006
X-TMASE-Result: 10--4.437900-10.000000
X-TMASE-MatchedRID: 60gbRApQc+uhhjsqgSuNbxF4zyLyne+AVBDQSDMig9EnyU5/nZpxULiR
 FJnWDxklfgsc3BsCzViXhy+IQjYeYPH/uuICyxMCngIgpj8eDcBpkajQR5gb3mn0m688Eo38Kra
 uXd3MZDVdQFJd25n07rZ1uztdbPDS666s6l2OA3XVsFzO6LCmjqRas2W4xO+Nf+dyiHo9iFQFs5
 RfhimQFEELvrGk0EI7fonyx9CICjFYOUxqOZP8HxXFEH92Kf64nTtPxlIuIBW9Hzj86YHXBCnif
 x5AGfCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] iopl01: Convert docs to docparse
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/iopl/iopl01.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index 70e2a7ff1..8eadc03c9 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -1,17 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Copyright (c) Linux Test Project, 2020
- *  Copyright (c) Wipro Technologies Ltd, 2002
+ * Copyright (c) Linux Test Project, 2020
+ * Copyright (c) Wipro Technologies Ltd, 2002
+ * Author: Subhab Biswas <subhabrata.biswas@wipro.com>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * This is a basic test for iopl(2) system call.
  *
  * Test the system call for possible privelege levels.
  * As the privelge level for a normal process is 0, start by
  * setting/changing the level to 0.
- *
- * Author: Subhab Biswas <subhabrata.biswas@wipro.com>
  */
 
 #include <errno.h>
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
