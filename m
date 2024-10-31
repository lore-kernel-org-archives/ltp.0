Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44617E6895E
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730365062; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=JN83arME58VDnHAKB6ITEi0je8qOKX4aGeUb2jx0HdE=;
 b=o18/7vo+kUvyxSdG2CrB3qUgbcI2jZSzQbqE36is5KgViwoGtasgcjuXWoYp0dZmDzsr/
 6UAhmScb+fLJja369cbpO7ohBlH5ZoeWwAPHbVAQu3uTdAIHdcRQXv4m1gtCtm/GSto1Z+T
 JBT62b8vVYGIy5jcXVNTJKC+fx4Lksg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D1973CBD05
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 09:57:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CE643CBCE1
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 09:57:21 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E45511010419
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 09:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1730365042; x=1761901042;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=F8whDHmdTcV16WRx2r4OZZYGUKorUZQQvg4fOuF1J9A=;
 b=RZyVYBjnJ7ydJ3DUdtlZawu2z3em6zJHEdu+aAw2Dv5FVW6UlxJeGtHa
 4/eJXluHu5JlI1Ch13m4sJxyU8atxRn+7RVLCn3muDLffyN2WsUrGW3J7
 FyUXnzOChR3DlaPlXENGspexZT8rtTyXa0KlougX86DiFswEumN6XUjk4
 qBSHou1QF58LV8sOCGJe/zEbp/hVQrJxTni9gizMbAdpG7v6LJYW/uTKN
 Ab5tbrh5ZkLlt2L+xYpkDrOB5Sr6zWgmMSBL9XPiI2iP0G+7UOnQGuVo2
 K70uEyrSmbRYG0OLjJpEZdgSHEFb7g0hP9kRC4vbJkJHgaD7FoY1I/cxz g==;
X-CSE-ConnectionGUID: aoz6KUrBQtOwDvjRdBU0QA==
X-CSE-MsgGUID: fGXhxesFQHCJp3BVd/dN+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="178706430"
X-IronPort-AV: E=Sophos;i="6.11,247,1725289200"; d="scan'208";a="178706430"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 17:57:20 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4DB28D8011
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:57:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 879B4D5B41
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:57:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 268652007955C
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:57:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C142D1A000B;
 Thu, 31 Oct 2024 16:57:15 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 31 Oct 2024 16:59:04 +0800
Message-ID: <20241031085904.57020-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28764.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28764.006
X-TMASE-Result: 10--8.310900-10.000000
X-TMASE-MatchedRID: aulLGGssQIPyq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUEWY
 FvwCgnnKtfzRNo3PTRgvuxYn+JmB5xs7n0Ur0F2Y8Jb881FGn9k+oe2bfROzI5soi2XrUn/Jn6K
 dMrRsL14qtq5d3cxkNQwWxr7XDKH8NJLyIYUhbw/qTaNnqaxfIzI/O2wCntCILOU4oOEq0ZoUvJ
 Ew9BQ77Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] llistxattr02: Convert docs to docparse
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
 .../kernel/syscalls/llistxattr/llistxattr02.c | 34 ++++++++-----------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index 6974f013b..c91d05f35 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -1,25 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2016 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*/
-
-/*
-* Test Name: llistxattr02
-*
-* Description:
-* 1) llistxattr(2) fails if the size of the list buffer is too small
-* to hold the result.
-* 2) llistxattr(2) fails if path is an empty string.
-* 3) llistxattr(2) fails when attempted to read from a invalid address.
-* 4) llistxattr(2) fails if path is longer than allowed.
-*
-* Expected Result:
-* 1) llistxattr(2) should return -1 and set errno to ERANGE.
-* 2) llistxattr(2) should return -1 and set errno to ENOENT.
-* 3) llistxattr(2) should return -1 and set errno to EFAULT.
-* 4) llistxattr(2) should return -1 and set errno to ENAMETOOLONG.
-*/
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify llistxattr(2) returns -1 and set proper errno:
+ *
+ * - ERANGE if the size of the list buffer is too small to hold the result
+ * - ENOENT if path is an empty string
+ * - EFAULT when attempted to read from a invalid address
+ * - ENAMETOOLONG if path is longer than allowed
+ */
 
 #include "config.h"
 #include <errno.h>
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
