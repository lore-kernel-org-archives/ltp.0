Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CB4C5478C
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709024263; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lRJwTMH2urhesDdtsHMZWnulnbtRR7jifisjXUNlmvI=;
 b=ljCUzpDNE4PrVwT5RfJv5IRYkIoxJpWVL1ZRJZqW2zaWSySmDiBcgv/bht7qllHsQN3EQ
 7u+k6jUp+7o0kScmEePkspP42WvuL+H8QBLCu9YtWzGg+Glo+AEjOafGgvWD6xcmOOEiWLE
 BnDX/Tn4pLUJzsxvOToEFy4O21xPq1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EAEA3CEEE7
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 09:57:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EEEA3CEF12
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 09:56:59 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6DB8D6008C2
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 09:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1709024218; x=1740560218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=toJl4eTBYSDK6BxB62zwyBNRh5WBrJftjdtySJZUcaI=;
 b=qXHrdXa/HdCZgIneRC7haF35NfRgMw/nctFpiKaJhnYkfzS34LeL6CgM
 OLeLWG/OgH4p42GivBAMyMGqnEwxfnBsSp6quWCT91/Hol6uCQQ1sNOyD
 VfMsV+NWylvow8x4EIhLIB9O1JCsC2DOPfSqRkS5sMuQ7eu80uJkKzlNk
 zZ2RMYyhaXl9oLKUgd6/ycRLBkiYHfaxEIhwLEWJe/KGgtr+0PGbrwubD
 i4dm0I3EniERQGE2eX89l5NjPv8EDeiFHXZ6SrEKathLNZc9WX8i5faJx
 bhk9INpBkX29LcIzrEblntz0CCDoIzMaII4sO1b99q0EqSzDtR4kRos7U w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="150559668"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; d="scan'208";a="150559668"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 17:56:56 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 043AE5DDE7
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:56:53 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 43349D7B6A
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:56:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C1EB66BE50
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:56:51 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6E0371A006A;
 Tue, 27 Feb 2024 16:56:51 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 27 Feb 2024 03:56:41 -0500
Message-Id: <20240227085641.33715-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240227085641.33715-1-xuyang2018.jy@fujitsu.com>
References: <20240227085641.33715-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28216.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28216.006
X-TMASE-Result: 10--5.076900-10.000000
X-TMASE-MatchedRID: Y8KQO0q7nHqhhjsqgSuNbxF4zyLyne+AVBDQSDMig9EnyU5/nZpxULiR
 FJnWDxklc4u9Bvo0YaW9SB1aT+6PzeUgeblHhHsaKiJEqUFWRggnhzAhgvoq55soi2XrUn/J8m+
 hzBStantdY+ZoWiLImyAHAopEd76vCCXYGVA0S5NoM9xpo29kQPbcePGqMUITxcKjCpcNIO43gr
 URT1HD/Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] iopl02: Convert docs to docparse
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
 testcases/kernel/syscalls/iopl/iopl02.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index 7301442f9..1a588590e 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -1,19 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Copyright (c) Linux Test Project, 2020
- *  Copyright (c) Wipro Technologies Ltd, 2002
+ * Copyright (c) Linux Test Project, 2020
+ * Copyright (c) Wipro Technologies Ltd, 2002
+ * Author: Subhab Biswas <subhabrata.biswas@wipro.com>
  */
 
-/*
- * This is an error test for iopl(2) system call.
+/*\
+ * [Description]
  *
- * Verify that
- *  1) iopl(2) returns -1 and sets errno to EINVAL for privilege
- *     level greater than 3.
- *  2) iopl(2) returns -1 and sets errno to EPERM if the current
- *     user is not the super-user.
+ * Test for iopl(2) system call error.
  *
- * Author: Subhab Biswas <subhabrata.biswas@wipro.com>
+ * - iopl(2) fail with EINVAL when privilege level greater than 3.
+ * - iopl(2) fail with EPERM when the current user is not the super-user.
  */
 
 #include <errno.h>
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
