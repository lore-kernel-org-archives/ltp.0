Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B79C0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739178624; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+Ox5ckXV1RxbJ6lrdeV5Z9zfCpcFlxV2YC5LDPdPcLg=;
 b=L9Keegw8ODJ5hOgxuNv+xOurYI1urYIY9AWr0+wHkCiGrGOjSFkAXZ6Jl1fRhAZ1JTHMv
 1D+M6esGWZVpafwX7o96rDeHwz63PSXPmjQ4J/1xx4jCpLICdR7lBca5VCXU0BoFUPojLdX
 itYIEOZBBXfcLtKAbz7L55XLBv0qYQU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E8433C987D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:10:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88D0B3C988B
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E76CD6094CD
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739178435; x=1770714435;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nBTXF8cSCbWv8mn4xSxITfuBOpEhEz9Pq97DnqtIvnI=;
 b=aNJfCgTbz6rA8yTM5B+Ddhl+Q1QFWzeSNuM2CIES4p6MgAQhtAUBhMT5
 C5EsTrHKpAfsgwsn2muoM+MZZ8ViB2hRv/xSrHsITtFGm7zumIJtX1N0c
 kIZc0rsVW8SPbCLAIjJpLXhw/W8ty8jiOGDA/ENPR3LP7/DdNXsJNVa9q
 Qp7dnSjkZLof0cJZMpbfHAN1xRP74i6thQ3BRhnMQIB5EDaJxAoXRL9Mp
 zmYRkqfoRFG8NRxqKZQ0VveWobmMdU1sGFavs/dM6nXxZ7Ct951P+KroG
 GnaRyCU9NdPMv1TXRy9DNwlEvKtGeogN+OmgFujet3RDgbY60EaXWR0fF w==;
X-CSE-ConnectionGUID: E0EAnEWZRmuXyQFvDk7q3w==
X-CSE-MsgGUID: BnTjc7/4T565QFBdaOeQsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="177445015"
X-IronPort-AV: E=Sophos;i="6.13,274,1732546800"; d="scan'208";a="177445015"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 18:07:13 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 726DE96743
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 18:07:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3651BD5043
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 18:07:11 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 9090E1A000B;
 Mon, 10 Feb 2025 17:07:10 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 17:07:20 +0800
Message-ID: <20250210090720.358890-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] msgctl05: Convert docs to docparse
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
 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
index cd2643bc1..721b08c58 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * Cross verify the _high fields being set to 0 by the kernel.
  */
 #include <sys/msg.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
