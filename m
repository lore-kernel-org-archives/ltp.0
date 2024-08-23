Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F2FC52D7C
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 08:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724400139; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=XKYqwzh768+8TpCkPI3QvFyNu7Q9IQ8/CSyf8WyisKc=;
 b=Gj+WE6TEOG1YQBeliZcpZ+DmMH7BiaHx9sJ3kCT5SIuI0gg/I/Ak3+5Ayp95TYhDYmmVU
 L9+FKlygQXjgWEONxMJYzc4/3BQdXOtHNkIokF61CEB61d6h9IJfOxuMdSTMrqAicZNZ8gY
 J9GTBCrHtY2u91fUUdDuM616uygy5MQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E16893D232E
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 10:02:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 216393D1B52
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 10:01:58 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4CA811B60EEC
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 10:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1724400119; x=1755936119;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gbJMKRvTR8nOsEfIh0gxe18dg+M3eO9A9duNRZ77Un4=;
 b=WMboM2M8nWoKHSVe8Lu1+jIh1QcRXky8SZp7A0yvLK8P92fgexhJR4Pv
 iGU0VW0Pw9crB1q8JI1vEFlCUhGC64X7Cd+OZZmDfbf9rOnWPx/oQT6ci
 I9xLHelIMv1VB2NdMWP9u6U4knls8GnRWT681lA7+8kzx8u33Ufm0uCZM
 TyM3EuIAHlXIxgAcJRwOSFj8YRQgUFQsJ7nX4GTDgj7Ehm69mn+b2d2JS
 yZXchydMCMK1c5RazEf1egh0RjrkERKuHdVqSMqpIMZ+zlpS8c5a96P6k
 ifTs+wQ85ZlLxUUFy+SviQVIEPaGFRihGYhlcw/Oar9VB+T+olUEjuqP2 w==;
X-CSE-ConnectionGUID: fZA6PT2UQa+Kj4GOrBzagA==
X-CSE-MsgGUID: isyBGALFT6qGYhtasTM9Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="171432979"
X-IronPort-AV: E=Sophos;i="6.10,169,1719846000"; d="scan'208";a="171432979"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2024 17:01:55 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B8169D8008
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 17:01:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 08B5DD72A0
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 17:01:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 89E42200838BA
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 17:01:51 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 78C931A000A;
 Fri, 23 Aug 2024 16:01:50 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 23 Aug 2024 16:03:37 +0800
Message-ID: <20240823080337.199654-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28614.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28614.005
X-TMASE-Result: 10--7.553900-10.000000
X-TMASE-MatchedRID: mJkk328f4R7yq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUEWY
 FvwCgnnKtfzRNo3PTRgvuxYn+JmB5xs7n0Ur0F2Y8Jb881FGn9mX2rvknNYlE5qX7orObbEbo8W
 MkQWv6iV3LAytsQR4e42j49Ftap9E4kYXbobxJbKl/MtrTwS4UIkVFBVY9Q5u6snvQ+Dz+zjRou
 0btpD30kViffAGMmAAEaaWrbC1PlU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lgetxattr02: Convert docs to docparse
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
 .../kernel/syscalls/lgetxattr/lgetxattr02.c   | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
index 183239a26..57a422953 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
@@ -1,23 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2016 Fujitsu Ltd.
-* Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
-*/
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
+ */
 
 /*
-* Test Name: lgetxattr02
-*
-* Description:
-* 1) lgetxattr(2) fails if the named attribute does not exist.
-* 2) lgetxattr(2) fails if the size of the value buffer is too small
-*    to hold the result.
-* 3) lgetxattr(2) fails when attemptes to read from a invalid address.
-*
-* Expected Result:
-* 1) lgetxattr(2) should return -1 and set errno to ENODATA.
-* 2) lgetxattr(2) should return -1 and set errno to ERANGE.
-* 3) lgetxattr(2) should return -1 and set errno to EFAULT.
-*/
+ * [Description]
+ *
+ * Verify that, lgetxattr(2) returns -1 and sets errno to
+ *
+ * 1. ENODATA if the named attribute does not exist.
+ * 2. ERANGE if the size of the value buffer is too small to hold the result.
+ * 3. EFAULT when reading from an invalid address.
+ */
 
 #include "config.h"
 #include <errno.h>
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
