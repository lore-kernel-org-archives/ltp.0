Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAE9ECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725962940; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=OsPcrTgLN4wnfCFcX1Etw+Vz8zhbAeLAo6C6aV1SyYE=;
 b=gd0A9F8Rpe85UhsoYDkJOM6R5+wrUP8WHJh7DSy+uEcZXi/ozUf2+PEX3EeRAyu5TP0zO
 8MCmI5+e3BA4ME0OiMLgHe8mB2c4+YpDQyd7/VyornJ+WPeW8s2unUDk8jblmQ9U1KQLXno
 5JxDHIw8XPBgaj9SlNbcHlt4YbevXLw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EB693C1A87
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 12:09:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D6943C020C
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 12:08:38 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F23EC6008BD
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 12:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1725962917; x=1757498917;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8LaHET/DrxwPOnqauJ7EDedJpcQ69Zjd4Ulkr5Gvlb8=;
 b=s/PY8pUY3JGoTwFPDRDCxzIYe08773RM67YJW2luv6N+rDm/LNpiIG2e
 LHwufH9MsokGRV/tTQqpRR7XItlJM/cmaA19pDNWmt1DWpldN7KBtVr1h
 0mk467eGm1l/BI8IK5Z8AhPg3OiJLAvH2zdxoApvC/eJHpy0h7NsPxt2n
 hSOhEAtgP98SDZHei+TcH/Nknu+s/EIq7C/KHpyzH/d2LQbf4EDbxvjuG
 JdS9PMn0eXRvYLjidcITMe/nNSWegOF8ApyipsYdBdOpgjny/ZHMuxqkp
 F3c+Ol0CKSxyRwYIDX+sH+mVl9VqYJN9u6uPS/Pa2qwvmW8GPopBs8Rr1 Q==;
X-CSE-ConnectionGUID: OnxINav+QdGVt1SI4pfIXA==
X-CSE-MsgGUID: iz89ZhQfT3af+SZ9+/FqtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="161250989"
X-IronPort-AV: E=Sophos;i="6.10,216,1719846000"; d="scan'208";a="161250989"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 19:08:34 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D22C4D4F55
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 19:08:32 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 263C31027D
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 19:08:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B8A8D41055
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 19:08:31 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 36C9C1A000B;
 Tue, 10 Sep 2024 18:08:31 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 10 Sep 2024 18:10:23 +0800
Message-ID: <20240910101023.58695-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28654.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28654.006
X-TMASE-Result: 10--8.657500-10.000000
X-TMASE-MatchedRID: QlNdUeMfyo6hhjsqgSuNbxF4zyLyne+ATJDl9FKHbrkWxRFlzVAvGhpl
 bnRIZ6aEtfzRNo3PTRhMQ8GITGODLdzZGrP764sOoCqoO2BspQh9LQinZ4QefCP/VFuTOXUT3n8
 eBZjGmUzkwjHXXC/4I+JGF26G8SWypfzLa08EuFCcU3N3e4qcwVvpp9cc5yEEUhLuFJN83tfPHl
 D3zdZS6Lc6cJ4uYUQo
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fchmod01: Convert docs to docparse
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
 testcases/kernel/syscalls/fchmod/fchmod01.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod01.c b/testcases/kernel/syscalls/fchmod/fchmod01.c
index 05b566791..417ea0a70 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod01.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod01.c
@@ -2,9 +2,12 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Author: Wayne Boyer and William Roske
+ */
+
+/*\
+ * [Description]
  *
- * Test Description:
- * fchmod() will succeed to change the mode permissions of a file specified
+ * Verify that fchmod() can succeed to change the mode permissions of a file specified
  * by file descriptor.
  */
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
