Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D8FD41C1D
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731488907; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ZiSlCeuKzSRkL4EGAjmhn4ihPDW5YBHDpWfVUbPrNJQ=;
 b=FTelFlprs5JFah072dZ5vnTTbpL35mzi4kPQbOw3WHAlTQBO41wF7wnj3G25SnkFBidkR
 lD2j4kVvCPjF8y0+JNbmJ00EayAXdw4KStXV1+NwhRj8zTZHo3X1dIk4+YwChRCAMaX/t5y
 517wmkGuz6FzVuWClKcIg5JA52Nk/w8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 818663D6548
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 10:08:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A98A53D6449
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 10:08:07 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E2706637EC
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 10:08:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1731488886; x=1763024886;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6mWAAA6Z2Nl+6pnW/kAOhjyhQVvS/fsyOK+YlfehsMU=;
 b=I8TceILkkU6oDd/vH25srQIe9MKamBen8DmZACzSoHNr66mUcVFwMgT7
 /XOKsFTsdcpwM2Qv/dB/C4QD9/HPf7c6Hvm15ex41Z8Ye2SCQnw+uNt16
 OaFACXYtqat6xfWcFp7G7v0p7oah3iOGdOtfLz9yvNWjP/BfR/InGiZQ/
 xj6IbUXfBhpDqNWhLBiJdXyjNaOHIR/Sa4YEKEjq5LwHGRzSfvAOFbxaC
 +RU8xFBZ54B9Qs9eVF8UdaOWy7q4mwTPu4mUeQeiWMqESupZq7W/b/W4n
 l69EEMQoZXicJgHxCYJj/zaLravLwHk9BlvEz+WPCHjs7P5ay1K4zi2l6 w==;
X-CSE-ConnectionGUID: 465AeKbGScqt6XAmcApP3w==
X-CSE-MsgGUID: 8P7FSR3EThCYx+etxnNrqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="168263148"
X-IronPort-AV: E=Sophos;i="6.12,150,1728918000"; d="scan'208";a="168263148"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2024 18:08:03 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 966FCD6EAA
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 18:08:01 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D0C7D2ECA
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 18:08:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id AD4CB2007472F
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 18:08:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 293291A000A;
 Wed, 13 Nov 2024 17:08:00 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 13 Nov 2024 17:07:45 +0800
Message-ID: <20241113090745.21789-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28794.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28794.006
X-TMASE-Result: 10--12.429900-10.000000
X-TMASE-MatchedRID: QlNdUeMfyo6hhjsqgSuNbxF4zyLyne+ATJDl9FKHbrkoYw/JH0PMskWY
 FvwCgnnKBm33ka/xTVdURMm+dS/voXqDDsxI37Z830kDaWZBE1QnsBRgUEfdppsoi2XrUn/J8m+
 hzBStanvIM9mETCO709934/rDAK3zhG2qikEpQGXfyBth+xZALcd0IWJJCUmnFyiRWX//vWlxGE
 ApMk1LnPdUQRRfnUKB
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ftruncate01: Convert docs to docparse
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
 testcases/kernel/syscalls/ftruncate/ftruncate01.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate01.c b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
index 5ffdd0513..ea97edb1d 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate01.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
@@ -4,11 +4,13 @@
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Wayne Boyer
  */
-/*
- * Test Description:
- *  Verify that, ftruncate() succeeds to truncate a file to a certain length,
- *  if the file previously is smaller than the truncated size, ftruncate()
- *  shall increase the size of the file.
+
+/*\
+ * [Description]
+ *
+ * Verify that, ftruncate() succeeds to truncate a file to a certain length,
+ * if the file previously is smaller than the truncated size, ftruncate()
+ * shall increase the size of the file.
  */
 
 #include <sys/types.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
