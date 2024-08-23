Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8E1C52D7C
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724398950; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=epm0n/EfjMUIY/MuMTiOxKYdgdXXq+XstvjEROeh7Hw=;
 b=IPDWKBxVGGGGsu2xYsVC7DNtIYCccnwXvLCYCwrdeYGMdBgm7jv1cn/Mm0VPQjxNF+k1r
 Bsikwg05sJyx+I08GexX+aBAeQtc8gGGLwzbe9IR4M6xgeroRxcz6kP6arl1UzxoO5nWaAJ
 mblkW1naMXYpOBhW6y5i09rB3eKcBQc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2560B3D2317
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 09:42:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2424E3D226D
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 09:42:09 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F5F21B60EE3
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 09:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1724398927; x=1755934927;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dh4C4rMy9OXsWktizOZsh8c5p6w6UXUqUeusH5TrT7g=;
 b=YyjtPOl8tsj716PsfLzXwl2WFtFzDhW2fSf8sqpYVFdl7Mu/fQ35kWQS
 T9NqbPJxOx56a5DbjK5EYY359MjJc+nBUh+ZXt6NFTf0efZloVyBPTodz
 XV2QtUSE+s+ImeXh4yWqJIdGB+v2EH8ICqUs4hYaQfYisL1MGKD9B26yC
 3sAUaO+CM8lK/T143cHoORE94DR6fyM4vvWyP41XSddrh4Y7voNlMXI8q
 bv2RFkAhj7XxrTbgh/2bd/vCoiaE/yjwRNE2JXgNiPfDF9KxyEp1qNRy/
 Dgx1P/r9fQtqS3ra8QZEHV4Hzx+78LKHFF34rvYlhoPj8nHpvpSLN12tR w==;
X-CSE-ConnectionGUID: 5kc8KYxSRvu5bMcNeYgMjw==
X-CSE-MsgGUID: 9M2HWspXR7urDdM1YHMMTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="150331184"
X-IronPort-AV: E=Sophos;i="6.10,169,1719846000"; d="scan'208";a="150331184"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2024 16:42:04 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1121FD2ABF
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 16:42:03 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5208ABF4BC
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 16:42:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D06A11E9C81
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 16:42:01 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5C4171A000A;
 Fri, 23 Aug 2024 15:42:01 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 23 Aug 2024 15:43:44 +0800
Message-ID: <20240823074344.192453-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28614.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28614.005
X-TMASE-Result: 10--4.566000-10.000000
X-TMASE-MatchedRID: cisyxejsi47yq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUEWY
 FvwCgnnKezEj+0i6bhhG77nj4gxZpJH0YXYnbGozFEUknJ/kEl5lVdRvgpNpe/oLR4+zsDTtuVf
 c976pNyq7puXdIVXHqmwennX9Lazi1uibJmhn7Rg03OMMC8m9aPBB1+SrUbyNmzEHLORxy1x476
 axPyHClE9xZpWm3uu2Oz7+3kBuN8aGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lgetxattr01: Convert docs to docparse
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
 .../kernel/syscalls/lgetxattr/lgetxattr01.c   | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
index 5c92d2317..221f9157a 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
@@ -1,18 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2016 Fujitsu Ltd.
-* Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
-*/
-
-/*
-* Test Name: lgetxattr01
-*
-* Description:
-* The testcase checks the basic functionality of the lgetxattr(2).
-* In the case of a symbolic link, we only get the value of the
-* extended attribute related to the link itself by name.
-*
-*/
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check the basic functionality of the lgetxattr(2).
+ *
+ * In the case of a symbolic link, lgetxattr(2) only gets the value of the
+ * extended attribute related to the link itself by name.
+ */
 
 #include "config.h"
 #include <errno.h>
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
