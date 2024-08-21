Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B820C52D7C
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 08:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724227626; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=x3YZn3gA0vUwXid8vmIn0AZM0jCLhDGoczQ3J3Ao7sQ=;
 b=TqiK6mqNTOAvoGNsXBGtsMCP+eQKi5RS6DPw6NZWBDgrRd/ghN3v1nh2G5jnXG9o406+9
 VcAVofQPiPW+JVJ7kVnnS+6I+NHD1pBes2Fms4cn3msXOKg8+GoVSKZT0AGUSElr/zmX0QM
 VkHgGHcknf3L02pUCb8wtKhCyO3lTxI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C98363D222B
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 10:07:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB2383D1B68
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 10:06:46 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD036608A89
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 10:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1724227605; x=1755763605;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AmoqB5D3hAuvuOqMve69kecc+kxp88/H0QAQJvF2D5o=;
 b=ViuJ8bL1Pwnwq/skglRHuvxoORTd95CVfkPUzX/zNVhfL15kwmZ0We0U
 jvn/e+2CbLwxTjpdVfCzeWSbpphYYzFNgxobmtRRYuevITwgA0aMcu3cl
 CuZy/96PgKmIasSTvvYzRZwoGmOZlV2cDPbzzy999eCnf8rQsSoYkIyrm
 XYoZBop8+EBKJ5W1aBiE9p6pONPWi+uvWZ3Elmfnw/LGeDqIX+W+JB+59
 pQDrZc2fM3Va6y0G6Fesilic3B6Kza2ZBox0f3wn38KD1+aNbkPJwbcOu
 R4fib3CqAN4mzOE6oN8QNDLwMjClsl8kc1SLiutWxNAgi/aqoxMobg41z g==;
X-CSE-ConnectionGUID: AoN7gSq/RgW4aV9irDlLEA==
X-CSE-MsgGUID: cuGgOrg9Q/uKvC50M0YMcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="150207019"
X-IronPort-AV: E=Sophos;i="6.10,164,1719846000"; d="scan'208";a="150207019"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2024 17:06:43 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 37C6AD9224
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 17:06:41 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6EC5ED52EA
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 17:06:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id EE61E224624
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 17:06:39 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 7368D1A000A;
 Wed, 21 Aug 2024 16:06:39 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 21 Aug 2024 16:08:08 +0800
Message-ID: <20240821080808.3311245-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28608.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28608.005
X-TMASE-Result: 10--6.040100-10.000000
X-TMASE-MatchedRID: /Iblp89iIQBa6JkWul/UfE7nLUqYrlslFIuBIWrdOeOU8ftiyKjZrQZp
 CoZWwX7ZvB8I+9mEnCdvp+b/wK4TT1lDiuV7LjH+BDoR8w7C9OZIvK4LrXs1ad+CFgPG/6Vd45e
 esIUwtzOqffmRegzerIAy6p60ZV62fJ5/bZ6npdjiRhduhvElspRO/VmQHkd1Ac5p4PSCOv9C3H
 znwYDiz6CEGO7mDuURhwsbHzaRpU/HWO8HKlVa/r7rweoAIK8o
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kcmp: Convert docs to docparse
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

+ update copyright

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/kcmp/kcmp01.c | 16 ++++++++++------
 testcases/kernel/syscalls/kcmp/kcmp02.c | 20 ++++++++++++--------
 testcases/kernel/syscalls/kcmp/kcmp03.c | 17 +++++++++--------
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
index 0e7cc7a22..c91c34d44 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp01.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -1,14 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ * Copyright (c) Linux Test Project, 2015-2024
  */
 
- /* Description:
- *   Verify that:
- *		1) kcmp returns 0 with two process and two fd refering to the
- *			same open file
- *		2) kcmp doesn't return 0 with two process and two fd not
- *		   refering to the same open file
+/*\
+ * [Description]
+ *
+ * Verify that
+ *
+ * 1. kcmp() returns 0 with two process and two fd refering to the same
+ * open file
+ * 2. kcmp() doesn't return 0 with two process and two fd not refering
+ * to the same open file
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index 076b4a723..eae8bb9cc 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -1,16 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ * Copyright (c) Linux Test Project, 2015-2024
  */
 
- /* Description:
- *   Verify that:
- *		1) kcmp fails with bad pid
- *		2) kcmp fails with invalid flag
- *		3) kcmp fails with invalid flag
- *		4) kcmp fails with invalid flag
- *		5) kcmp fails with invalid flag
- *		6) kcmp fails with invalid fd
+/*\
+ * [Description]
+ *
+ * Verify that, kcmp() returns -1 and sets errno to
+ *
+ * 1. ESRCH if pid does not exist
+ * 2. EINVAL if type is invalid
+ * 3. EINVAL if type is invalid
+ * 4. EINVAL if type is invalid
+ * 5. EINVAL if type is invalid
+ * 6. EBADF if fd is invalid
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index 7af5cb150..4ae6e0295 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -1,17 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) Linux Test Project, 2016-2024
  */
 
- /*
- * Testname: kcmp03.c
+/*\
+ * [Description]
  *
- * Description:
- * 1) kcmp() returns 0 if the processes share the same file system information.
- * 2) kcmp() returns 0 if the processes share I/O context.
- * 3) kcmp() returns 0 if the processes share the same list of System V
- *    semaphore undo operations.
- * 4) kcmp() returns 0 if the processes share the same address space.
+ * Verify that, kcmp() returns 0 if the processes
+ *
+ * 1. share the same file system information
+ * 2. share I/O context
+ * 3. share the same list of System V semaphore undo operations
+ * 4. share the same address space
  */
 
 #define _GNU_SOURCE
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
