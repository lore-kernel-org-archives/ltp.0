Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ED2D6DDD7
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 06:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731650931; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=QSMUIk4yqx+ns7/3HpKazjLS8ZGErXXYGMW2F9LLmpw=;
 b=MFxtfBcpCXhRpbdkHZeoiur1dtxWZJBDchQVzThB7UK6wvhJ7glCK212mO/EnzdEavcF1
 NGHjRVJiU2IgN4rClXzJN/klSkGmjTAew0R0+R2fJC+E8/++eRFkmLL/CxnD9QIjNR+7dXr
 n7wb5mzE9uOhtM/WdVrXcbEK2ASazHU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FD493D72E3
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 07:08:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71C3F3D721B
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 07:08:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A5C564DB70
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 07:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1731650908; x=1763186908;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hCUrdudU55TF46Rj371KqeofZ3lRQjKX9d/xBSv/BxA=;
 b=qkWwyzkUNvZga1ty0wJa1KZi2JH6ZvupjVNddsE6Z3m14uaZJ//QtlBk
 usicsei5M4MQDitSycieaasNMdR4VVDW96HWPNgaGP6thJfKmyg9Bllhm
 jS2I/clFv38Aupk30YJ7zCOkOnZBffYF32+Z7qdUYdkXx90OXcYnUH2CG
 nuXmTnlWbz/BTuN2tSaKsljmZe5GSpGpP5mvDHptJlMQtrdMPUchu773N
 NUYeuLys9/M9BiDkd4o4IsqHe9ssmEgy1Nme/SFWrH/TkqjYmD48cxN2P
 jJX5oBnxkyfiT1+Tu4jp/4zxO+d8JkjyTpLeAWF/BGN0GCJDuAw4tly4h w==;
X-CSE-ConnectionGUID: byfohJ+hSnOSSbTcWRqKCw==
X-CSE-MsgGUID: 66aMmMH7QxqXXGB1M0TAdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="168877841"
X-IronPort-AV: E=Sophos;i="6.12,155,1728918000"; d="scan'208";a="168877841"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2024 15:08:25 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 38D4FD7AC5
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 15:08:23 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id BC2E9D6170
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 15:08:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7DE4C40B7D
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 15:08:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E719D1A000B;
 Fri, 15 Nov 2024 14:08:20 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 14:08:04 +0800
Message-ID: <20241115060804.130544-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28798.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28798.005
X-TMASE-Result: 10--2.340700-10.000000
X-TMASE-MatchedRID: FMY5IFaWNFChhjsqgSuNbxF4zyLyne+ATJDl9FKHbrmvY+2jZ6Y7ZZUX
 tMTov77hXSjVgziIU9OAMuqetGVetk6N1CbkSyKE3QfwsVk0Ubv+efAnnZBiL5K13zeQcKlRjQE
 md0Hvg8tsa5GG4C2XkC3RD/DG9XAyXimSit+d22lM/DT2tOYoaYCvK0e1CWOmQ+Tug43iztPZU4
 QAssAowHjKdkPZVDsmW4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tee02: Convert docs to docparse
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
 testcases/kernel/syscalls/tee/tee02.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/tee/tee02.c b/testcases/kernel/syscalls/tee/tee02.c
index 5ebb3c3f6..c3b991189 100644
--- a/testcases/kernel/syscalls/tee/tee02.c
+++ b/testcases/kernel/syscalls/tee/tee02.c
@@ -3,15 +3,15 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
  */
-/*
- * Description:
- *   Verify that,
- *   1) tee() returns -1 and sets errno to EINVAL if fd_in does
- *      not refer to a pipe.
- *   2) tee() returns -1 and sets errno to EINVAL if fd_out does
- *      not refer to a pipe.
- *   3) tee() returns -1 and sets errno to EINVAL if fd_in and
- *      fd_out refer to the same pipe.
+
+/*\
+ * [Description]
+ *
+ * Verify that, tee(2) returns -1 and sets errno to
+ *
+ * 1. EINVAL if fd_in does not refer to a pipe.
+ * 2. EINVAL if fd_out does not refer to a pipe.
+ * 3. EINVAL if fd_in and fd_out refer to the same pipe.
  */
 
 #define _GNU_SOURCE
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
