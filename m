Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606FDE7717F
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 07:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734332657; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=3UMbqcABAsaYWQQqGd2OHYa64U7j/hXdghhDHOLjesM=;
 b=ojjbSaMujPhKkdM+BTx25w50QdxoXo3GqhInXycQgky6+XJueL5RTjQ3hxbU6ro7tKzsd
 pQVlKucrj2wwWKazEEKgKPHUw6HrxnuzghufftnmzIpmgGdTwEKILcm7IdsdJB+Rmwk+cNO
 Qmq3eWEfA/GNY+/ZM2V5rqBIoiL2aNs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D56D3E2A2B
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 08:04:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54BFD3E29DF
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 08:03:55 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5B7621BC8496
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 08:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1734332635; x=1765868635;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MTCv3vnOWvrU43jrVDEAYmQJsCiPQqo74bkFrcarveY=;
 b=UxWAqJtT0wB/nliaKWGV1T1Vec7kNZYNNUfW7B3Jf6y+eA+WzgUytJum
 5acrqCQAXZP3J6E9OsHG2fMvEFenJcdP5ecMXPs/X8y0jghMYPVEvZrzE
 XCVRc7ySGYvRDd6m+OWpxmCQeaZ7uGS3EdRd7SHU/ZBjrJU6XG1wCVFvx
 xT/zwEL9zQDU9O5s3BDEwPYGBHwp6w54OIv3KkSC+WV0r52Vn6TqlAUCp
 scpKRP7OKc34VM2IgNOEqDd1VXbeChauw/FIOTs4J+LnqBiEZ6tmCQELC
 c3TrEzU0wzgCYHbBU95V6XPK8UrkNORyQTPnRI0v8eeWHd+t+DHl9GApy w==;
X-CSE-ConnectionGUID: DjUOxBsoQhK/wCEg00wRdQ==
X-CSE-MsgGUID: gfRPMulzRIiKsDCdxmatHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="171175934"
X-IronPort-AV: E=Sophos;i="6.12,237,1728918000"; d="scan'208";a="171175934"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 16:03:52 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BE082C2266
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 16:03:50 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 958E0D73B9
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 16:03:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E769224966
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 16:03:50 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8C1B01A000B;
 Mon, 16 Dec 2024 15:03:49 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 16 Dec 2024 15:03:29 +0800
Message-ID: <20241216070329.2892491-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28862.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28862.005
X-TMASE-Result: 10--12.123100-10.000000
X-TMASE-MatchedRID: gk5wloW7liihhjsqgSuNbxF4zyLyne+ATJDl9FKHbrmY0QQ8kxqAzJGH
 Z85Onc+24PKuGN+8yk1BkRBFNEKJqbejROPl/CmS5CghTisABMxf3ennYqHe2F/8lGqVstJXD4m
 1gZ6zeMTi8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSkgbhiVsIMQK9LdHHLXgng3Ihig5xFCeYe1Vq
 5q0xWDH1wPHDI+xMSDyQQuHnPzpXschXTZ3Wukbw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fchmod05: Convert docs to docparse
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
 testcases/kernel/syscalls/fchmod/fchmod05.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 0c731d601..e5de86117 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -2,18 +2,18 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Author: Wayne Boyer
+ */
+
+/*\
+ * [Description]
  *
- * Test Description:
- *  Verify that, fchmod(2) will succeed to change the mode of a directory
- *  but fails to set the setgid bit on it if invoked by non-root (uid != 0)
- *  process with the following constraints,
- *	- the process is the owner of the directory.
- *	- the effective group ID or one of the supplementary group ID's of the
- *	  process is not equal to the group ID of the directory.
+ * Verify that, fchmod(2) will succeed to change the mode of a directory
+ * but fails to set the setgid bit on it if invoked by non-root (uid != 0)
+ * process with the following constraints,
  *
- * Expected Result:
- *  fchmod() should return value 0 on success and though succeeds to change
- *  the mode of a directory but fails to set setgid bit on it.
+ * - the process is the owner of the directory.
+ * - the effective group ID or one of the supplementary group ID's of the
+ *   process is not equal to the group ID of the directory.
  */
 
 #include <pwd.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
