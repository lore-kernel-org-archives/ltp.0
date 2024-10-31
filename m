Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BB2E68960
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730365031; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=MCPQYlz+jpp1Y4hHW+dPbzWCPbtJg3mX5vEOZbVQzQY=;
 b=AdARMADgxx4JRfFfOIIDmL3lUx2b8dFA+MwKxtfCf8iqNN50LHluZ3yBC7HkUxX6nMwRm
 Fy0itmao63uGlUA8SUbukbB7RD9iO7MzTVDyWSHMjxzJzDZswm5Ubi+N5x4CJbtNFLhiBpL
 rDJEz2lXzi8fdX8aqfRP6eDR/f6Kdz8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E22B3CBCFE
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 09:57:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 069393C7E0B
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 09:56:48 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 302741430CFD
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 09:56:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1730365009; x=1761901009;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VPKzMSIkmT3q29a40wN9+u7fYTZhTPDrBXuGhI8YcEM=;
 b=TyjI47+XCGA0EzQpqObjRMkKuw+nbmmltoLBEB2HX7ZS+cECdZ/x3MNS
 jz8MONoX39QkY1fKPIQQiIcBc8pGQus8kwPTAQ07XAUTyY3LJMvwI4516
 sYdvQdU+jh8hY0W43DHnEYFdQkk+uDEICrjbMfEsjCNLAro9OpSPbnhSX
 6rBhmBa1KdtsWYFjzBCWpKMyA25J1aHfpylnZVgqJKPcbFnCbOlgxLH7B
 014UQXJDuU4d47NA5jQQCwh9tKNB1zRK/Q2KOWKo4GQ8gyy2V9tU0ZBoB
 3mjYFgv10Iv57ZjkgjcPEIr1ONQjDtP0dsKIuxS+LDmprOjNoOZbrF3/N w==;
X-CSE-ConnectionGUID: 4ZktNMbDRc+pZqVOrA284Q==
X-CSE-MsgGUID: 9VLTNDWxR7KHx3fdEeb3Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="178706367"
X-IronPort-AV: E=Sophos;i="6.11,247,1725289200"; d="scan'208";a="178706367"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 17:56:47 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2CDA6D64A6
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:56:44 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 74541D4C13
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:56:43 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 11486411AB
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:56:43 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 794FE1A000B;
 Thu, 31 Oct 2024 16:56:42 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 31 Oct 2024 16:58:09 +0800
Message-ID: <20241031085809.56982-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28764.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28764.006
X-TMASE-Result: 10--8.039100-10.000000
X-TMASE-MatchedRID: cisyxejsi47yq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUEWY
 FvwCgnnKtyjUMgzCwc1+NZ4lfSspsx8TzIzimOwPbyHxYOKot3xp9JuvPBKN/Cq2rl3dzGQ1il/
 Tr8kJxaUP2cTHQ7hZTCoWl1qCopLK1ylwGnFm0BShdONI86j2Hg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] llistxattr01: Convert docs to docparse
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
 .../kernel/syscalls/llistxattr/llistxattr01.c | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index f59413265..5002fe96f 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -1,18 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2016 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*/
-
-/*
-* Test Name: llistxattr01
-*
-* Description:
-* The testcase checks the basic functionality of the llistxattr(2).
-* llistxattr(2) retrieves the list of extended attribute names
-* associated with the link itself in the filesystem.
-*
-*/
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic test for llistxattr(2), retrieves the list of extended attribute names
+ * associated with the link itself in the filesystem.
+ */
 
 #include "config.h"
 #include <errno.h>
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
