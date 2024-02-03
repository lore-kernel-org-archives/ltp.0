Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0CAC4828D
	for <ltp@archiver.kernel.org>; Sat,  3 Feb 2024 05:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1706937599; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=f5mQpb6hf4nu0+qzqiIG+DlYIUt7u0xIMXT60EOqHEI=;
 b=I+we7+qqS8bgQPrYzfAnt59vH8TvBBrEraBOJ552Hcq/jpUezY/9op8q913fUGlo7WsCS
 AikINiagHtZix7bI05aFxIwCWRUF8Ja7gfJshnp4c/1YG+3xUy7zAs7aN5BvovfNGjk26Yb
 TUWkynzauqxn9i5sPD+oHn/z1VOj/TI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 734323CF869
	for <ltp@archiver.kernel.org>; Sat,  3 Feb 2024 06:19:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11E573CF85E
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 06:19:13 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AF5B4140099A
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 06:19:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706937552; x=1738473552;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K16oxQPM7Zp7Oj5xK5tazH86L1o5RBAUPQiZE8QXjG0=;
 b=cFJTw5MLrGY/pWRnI/bR+r8KlOLvtcYwuWC7+OyftwQ41TYiq3dofvih
 4LVklXaCxtzpfbv0+86EaNPi43KzWWsh9MVV4JSYEvJu0TQrfDPrudxR3
 FVP6NMAM00laKxVqSo4kPUjDrdW3eAbKBLjyKrX0HXYaHXTakhoB1Qsdo
 Y+PpAhQg4aR+TWUfvRgP1349GEsFYue26qYyrpDoG0ap3hqv8AvynndxC
 CGgzqfPB9jm5FDEQA7T25Ci9jkWZphn0HkJnL0quzQ8ofbCSTwa8KfexF
 CoqxMNi/mumeyj0itj1uMze5QG6lKIcLxElwQVMAXJPt1Pb4KCn7TlcJG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="147732411"
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; d="scan'208";a="147732411"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 14:19:10 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B9A0B109BF8
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 14:19:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E376A21F5FF
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 14:19:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D5AC20059322
 for <ltp@lists.linux.it>; Sat,  3 Feb 2024 14:19:06 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1A4AA1A009A;
 Sat,  3 Feb 2024 13:19:06 +0800 (CST)
To: ltp@lists.linux.it
Date: Sat,  3 Feb 2024 00:19:01 -0500
Message-Id: <20240203051901.3000-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240203051901.3000-1-xuyang2018.jy@fujitsu.com>
References: <20240203051901.3000-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28162.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28162.002
X-TMASE-Result: 10--5.867500-10.000000
X-TMASE-MatchedRID: k/L/ofNtQd0dj9vNGYhpkU7nLUqYrlsl9LMB0hXFSei0sAt86s8nFHlb
 NLJMhGktSm1zD0R1vvk6gbIYokhQqZLaPACgg26O194/5X9VfCy061diBteN17s3Yh2IOCYzE0o
 8W+GU3zCbtw2XfFPBnKUS0MnJVHzyHxPMjOKY7A+u65UDD0aDgsRB0bsfrpPIfiAqrjYtFiQQ7E
 s4IgMJhBzfE8N6f0vi2NDd/6LlK9vgHGQVoQ6aLX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] settimeofday02:Simplify test using TST_ macros
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
 .../syscalls/settimeofday/settimeofday02.c    | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday02.c b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
index 0fa8a147a..157f72cfc 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday02.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- * Ported to LTP 07/2001 John George
- * Testcase to check that settimeofday() sets errnos correctly.
+ * Copyright (c) Linux Test Project, 2001-2024
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that settimeofday() sets errnos correctly.
  */
 
 #include <stdio.h>
@@ -27,16 +32,7 @@ static void verify_settimeofday(unsigned int n)
 	struct tcase *tc = &tcases[n];
 
 	tst_res(TINFO, "%s", tc->message);
-	TEST(settimeofday(&tc->tv, NULL));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "settimeofday() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR != tc->exp_errno)
-		tst_res(TFAIL | TTERRNO, "Expected %s got ", tst_strerrno(tc->exp_errno));
-	else
-		tst_res(TPASS | TTERRNO, "Received expected errno");
+	TST_EXP_FAIL(settimeofday(&tc->tv, NULL), tc->exp_errno);
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
