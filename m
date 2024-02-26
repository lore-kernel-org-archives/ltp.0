Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E078CC48BF6
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708955733; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=b1WLtTpoHUGH6MKFssFXtXku1Qk2VqhxXlfCSQJ7xIo=;
 b=ZedFF9f+f5ka+OZ98jmdHgXEeGEpKywygAyUVgD2M56nuOmey/sKU6FogyGuURjVNi4jW
 6ppECZbR7iFHMyDYfzeUCb3BnnL9XRKBYgK9JXdZ11eip8eJ4b20THUCin6LelYrtuVcP+v
 3a2DTseIZMvIgyJKaXqjywOsMmGVTLM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CFF73CEF94
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 14:55:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 070533CEFEE
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:27 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8DFC0601413
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708955666; x=1740491666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lP5J/y/OjHESszHbNaioE9G09kKVGxCN86QmfClSnVI=;
 b=ZLfZMTlSLld/jsqUnRzkuu4gQhsdCzXQok5FGNdLOWpyckugk6UI9+TQ
 9Uv7eTeRdgUpDTP8ZkJPIe48U5dbXGR0PR/QF7fYuDBxhIAaED7T5jJDe
 ih29E1Jtxjpv5rA8/p77nnaUKc5zWSTWE2NxgNG6VA4/gZST+1x7vvsRJ
 DhyrXu1NgrXmmtxTYHARnnfGaW5HAY3G38GhzQxkLh7Lk3PObVwj74ezQ
 t0OkzsyeT880T/VQVRIjc5I/6IWxtp84j3tJQzW3/KF7ZmKtVUTSOc1vm
 m1w0f8Bu7uJFdWohcicQbPdZIjXKlzOINmoutbsQQl66uAXR4O7Z0qNeU g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="138069046"
X-IronPort-AV: E=Sophos;i="6.06,185,1705330800"; d="scan'208";a="138069046"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:54:24 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 963FAF06E9
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:22 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BD223D6202
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 551F02008FF89
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:21 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id F29A91A006B;
 Mon, 26 Feb 2024 21:54:20 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 26 Feb 2024 08:53:33 -0500
Message-Id: <20240226135336.19733-4-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28214.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28214.007
X-TMASE-Result: 10--9.963700-10.000000
X-TMASE-MatchedRID: JBufqG2vPnQIGXYTUlAoHxIRh9wkXSlF9LMB0hXFSeikob0Y35+HFI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatXwzxAv8kID0Ss47mbT7SARcsgu/IQFPzpsoi2XrUn/J8m+
 hzBStansUGm4zriL0oQtuKBGekqUpI/NGWt0UYPCqkDOvNvb8v882kuXwGvR+YrDFqpbkdC3ecA
 a5HnFdqs67gNAKs+9o
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/7] swaponoff.h: Remove useless header
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

Since we have use tst_max_swapfiles() api in swapon03.c, so this header
is useless and can be removed safely.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swaponoff.h | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/swapon/swaponoff.h

diff --git a/testcases/kernel/syscalls/swapon/swaponoff.h b/testcases/kernel/syscalls/swapon/swaponoff.h
deleted file mode 100644
index 900761bda..000000000
--- a/testcases/kernel/syscalls/swapon/swaponoff.h
+++ /dev/null
@@ -1,8 +0,0 @@
-
-#ifndef __SWAP_ON_OFF_H_
-#define __SWAP_ON_OFF_H_
-
-#include <linux/version.h>
-#define MAX_SWAPFILES 30
-
-#endif
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
