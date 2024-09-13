Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104BAEEE245
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726213598; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Ncx9ygV2kKFhw3TZEoN2A8FVXca+5EiegXL2+s35OT8=;
 b=PEn7xWilD62pdXZTD+WOwC0fuDSgA+XZBL8YbvQHa53JRJKrd2anNV8BVwKcgkvLobW/e
 as0jL8Pmtkav7+f27u8VR1EC5kB1i2dYenaPa0YZdX/px+QmWyzan8p8KmO3ZtxLMX+XczF
 8tf9AbQR50aV2l8TFbv7f+jJ7pJI5Dg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D31503C27A5
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 09:46:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 700E93C1AE3
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 09:46:17 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 462F76020A0
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 09:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1726213576; x=1757749576;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XReQ5d9MtUJjv/cUf6aFPEF81dnG0mjB2B7IolaHCfE=;
 b=S1jhVkiy9IUTD0zxJQunc4rMvMqSJvQsuBKm0Xy3XDj2WcuZEQHsz0D+
 9clGwhxj9+iPXuMr8vG8qt4sFudXlE3UfFOZFQMBj+5sy4TzTgbtKzxd5
 FnJ2YX2WPOIUrRw3COD/I8Cr+pG1QhUtCcMNr/EDvPHrsWFOVT3ycyC+7
 JQkcObbHm9xVPqHHn0jOOiH6SzGaqQgjK80p8L9HlGHBOqLx4q7+xdTL9
 HZ3rVgL7B4nWrce1hSL6A0fx9hecxnidYGcSbGn2mqVd5/LjZJzZvA58s
 bXWcVW8EaiBEaqKWJMQ6gQL7Yjq585/tEpqX/pTDVpHHaiW1TQZj7wege w==;
X-CSE-ConnectionGUID: yNKtj888Q5igkW5TGOkU4w==
X-CSE-MsgGUID: 67YjVSOoSKikLlO67IBuow==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="175692821"
X-IronPort-AV: E=Sophos;i="6.10,225,1719846000"; d="scan'208";a="175692821"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2024 16:46:14 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id CE0F2CC142
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 16:46:11 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1847EBDC8B
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 16:46:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A781020086EA8
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 16:46:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 22D8D1A000B;
 Fri, 13 Sep 2024 15:46:10 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 13 Sep 2024 15:47:43 +0800
Message-ID: <20240913074743.171417-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28660.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28660.006
X-TMASE-Result: 10--8.887900-10.000000
X-TMASE-MatchedRID: QlNdUeMfyo6hhjsqgSuNbxF4zyLyne+ATJDl9FKHbrktgrJnRjazPLD7
 bvwvswdMwPjoyxtY8IAZCFRTM+r3uWshKDeAIEIiSs47mbT7SATYUDvAr2Y/1x7C++U0wwZ4o8W
 MkQWv6iXBcIE78YqRWvcUt5lc1lLgOMB0shqXhHqIn3Vd6aw/6A1rnPd07t4waS+eSRI9sRndcq
 B5Oytq1j+/LgzxCEE1
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] splice03: Convert docs to docparse
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
 testcases/kernel/syscalls/splice/splice03.c | 30 +++++++++------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/splice/splice03.c b/testcases/kernel/syscalls/splice/splice03.c
index c054e6c1c..91e9bf9e7 100644
--- a/testcases/kernel/syscalls/splice/splice03.c
+++ b/testcases/kernel/syscalls/splice/splice03.c
@@ -3,23 +3,19 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
  */
-/*
- * Description:
- *   Verify that,
- *   1) splice() returns -1 and sets errno to EBADF if the file
- *      descriptor fd_in is not valid.
- *   2) splice() returns -1 and sets errno to EBADF if the file
- *      descriptor fd_out is not valid.
- *   3) splice() returns -1 and sets errno to EBADF if the file
- *      descriptor fd_in does not have proper read-write mode.
- *   4) splice() returns -1 and sets errno to EINVAL if target
- *      file is opened in append mode.
- *   5) splice() returns -1 and sets errno to EINVAL if neither
- *      of the descriptors refer to a pipe.
- *   6) splice() returns -1 and sets errno to ESPIPE if off_in is
- *      not NULL when the file descriptor fd_in refers to a pipe.
- *   7) splice() returns -1 and sets errno to ESPIPE if off_out is
- *      not NULL when the file descriptor fd_out refers to a pipe.
+
+/*\
+ * [Description]
+ *
+ * Verify that, splice(2) returns -1 and sets errno to
+ *
+ * 1. EBADF if the file descriptor fd_in is not valid.
+ * 2. EBADF if the file descriptor fd_out is not valid.
+ * 3. EBADF if the file descriptor fd_in does not have proper read-write mode.
+ * 4. EINVAL if target file is opened in append mode.
+ * 5. EINVAL if neither of the descriptors refer to a pipe.
+ * 6. ESPIPE if off_in is not NULL when the file descriptor fd_in refers to a pipe.
+ * 7. ESPIPE if off_out is not NULL when the file descriptor fd_out refers to a pipe.
  */
 
 #define _GNU_SOURCE
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
