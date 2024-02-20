Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C294AC48BC4
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 07:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708415072; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ksVg0DAiD5Hf+l6xBpxOHfg8f+CZGnoYeMe5CPPFTgM=;
 b=Xr3fp5Vy//PIlkKnmBdPTi6LZgmQSYBmZ1dJb8+tz6U9N881NOYvrXHD2XeHOU5DOnZgd
 ExBLwi4Sj/AtSmjI9qk7xGnHMtcnnXmJWIEbQ6tlERmw4eM6avTOtJ/ED0f5aM1fXoOYTmH
 U7nPEAy0pN4G4SnZOS9JTn/L+qmM0mI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45DF13CE9F4
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 08:44:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 598CE3CCDAE
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:43:37 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A771600C18
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:43:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708415017; x=1739951017;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YU1aqFRO5VyT9UvW42jqDRESeMWOix7Fq/oBBjeQefg=;
 b=KEvuzfOf6q8lV8duB56L/uisHj11M14W50BSc9PwCNluDM8xe7Li4kon
 gyLmoaurnbIruH825av5KyOSK7LnUNRbe6JBGPIBf7JWzJeV7I1wn/UJg
 xFcBpAACQ9wbxAngfLh/uJF9q3OrYe4eCd4LrMo5AX6rqRaJJ4sIJ8oM0
 3ZQwmD5I0WwahSplwUjvqiUcsYXfJoNUs3yoWyfDbhVj3qcyiXa1HTLxk
 w+YDU50eKCtHMGph7c2HB9pV4mxJDLvghmgmrjRnbD+wBATyTmK0bsuWY
 NehO8WN/7enQNwYv3zYdIffAdZwhQcHH5+6H04zb9Qc5v+sPhEEach8qa A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="149736383"
X-IronPort-AV: E=Sophos;i="6.06,172,1705330800"; d="scan'208";a="149736383"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 16:43:35 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C2B21D4805
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:32 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 01A00BF3CE
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8BCED20097CE1
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:31 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 314481A006B;
 Tue, 20 Feb 2024 15:43:31 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 02:42:15 -0500
Message-Id: <20240220074218.13487-4-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28202.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28202.005
X-TMASE-Result: 10--9.963700-10.000000
X-TMASE-MatchedRID: JBufqG2vPnQIGXYTUlAoHxIRh9wkXSlF9LMB0hXFSeikob0Y35+HFI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatXwzxAv8kID0Ss47mbT7SARcsgu/IQFPzpsoi2XrUn/J8m+
 hzBStansUGm4zriL0oQtuKBGekqUpI/NGWt0UYPCI7sC4haewV/n9viGv+yGih2qTfLe5tYivgh
 rXlvlCEClDYiLWw5+B
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/7] swaponoff.h: Remove useless header
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
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
