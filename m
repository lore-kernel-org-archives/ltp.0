Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442DEC4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707386849; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=jjAzDFe4MAhERhniI+p+xy6XnLc7QgOR9jSycMK9CUE=;
 b=FUl/KElCTeiLDy3WoECriMnXB/s0xeZzt2zV56e9vSUawOQic6rJU3cF0eouRo/THghp5
 8RCyeAUGYfDDIw10Mhisani701V4SukGY/G6C1gRfObsVNkW3A5vDrSKwhV76nq32LJ2cNM
 iCpguOrGm6SFgC8EZHFiKF2ndQsyK18=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3BBF3CDEAC
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 11:07:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D2623C5AC4
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:48 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E1101400F34
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707386747; x=1738922747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z1xHRP2Ek7YJeSS1pq7YTvaQCanZi7//foGZS2wgUd8=;
 b=CCxiGLHMZuIBb/COfGlGIdLimXPdPK6t5VGL1WHV36kjWaFbuNbPkg7J
 QcdZbZkobB+hlbLGaK4DkzQ3WK7iQyLaOa+XbwA7I9+ewMayNPRBwpeuq
 4n2qjc7e666bblaGClooBKjgNyc/KnOAHGXjAt6lH8KIFYwLL/u0ja++f
 bYgV1SgiSN5pjwoJT0SfFtXwwLtonxlSJPFAwsTcKAdNaLVZxCdFp+Bse
 7aAvlCTS5FvAmcn3m3iDIjJfpLAC7KirvcxxAP2utlTZqbN0Yo1RHO9EU
 ukBPndKHNjqbm8lxmR4dKF/u/sOZiyMM5iutWbH83FyKjTjPBZx81zIYo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="148804475"
X-IronPort-AV: E=Sophos;i="6.05,253,1701097200"; d="scan'208";a="148804475"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 19:05:45 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B07FB1625FF
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:42 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0367EF31B1
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8025E20097CDF
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:39 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 371441A009A;
 Thu,  8 Feb 2024 18:05:39 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 05:05:14 -0500
Message-Id: <20240208100517.1974-4-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28178.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28178.004
X-TMASE-Result: 10--9.963700-10.000000
X-TMASE-MatchedRID: JBufqG2vPnQIGXYTUlAoHxIRh9wkXSlF9LMB0hXFSeikob0Y35+HFI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatXwzxAv8kID0Ss47mbT7SARcsgu/IQFPzpsoi2XrUn/J8m+
 hzBStansUGm4zriL0oQtuKBGekqUpI/NGWt0UYPCI7sC4haewV/n9viGv+yGih2qTfLe5tYivgh
 rXlvlCEClDYiLWw5+B
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/7] swaponoff.h: Remove useless header
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
