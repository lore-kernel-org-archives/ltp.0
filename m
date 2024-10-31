Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E34E68960
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730365085; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=FCS9F5AW34YwyZlG1QINwpQ8AO6buso75pVKf+qqmZg=;
 b=WHZLot98LFf+UOYIjvWtgjb+Njxa/1bCaC0pf7ZSk2cvjp5h9k+LEi4gvyoW5WEjzUi5O
 dXwMyd0Rg+ZEbNaZkQpdNeu+ohLqbocZ4Ns7oYZv+u4UZDFyE7MPL0qOzfIGxVLqSxJiwbJ
 TdPEtumWa08AJ2hx6DqZtd4AIkoaNjw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E592F3CBCFD
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 09:58:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C756F3CBCF4
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 09:57:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9685F6111A0
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 09:57:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1730365063; x=1761901063;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WjpQlMkgFf5y8QJj6NngoliI531+wUV/WCzy7xXj8pQ=;
 b=qnbxHihrFSo+SqZ8Y9U/3fUBfekhqz/y2Snr749J+S6BNv0I8AidS6A0
 Tv9V1+kvLeeHNFf9FAMzfewraGWF7DWX4MuSad5JhXZnKgzZ8cAyS7/G6
 NmQPpcBF1Dd4FgGy49xi3fst/Vg8Zarp00d8TJhV+5IE1iCeKpWT++TTI
 0qiI7V9AGT6v08xl3Cb02/RniFvyGLma91ORVw7lDphYidh+Wbb6ryyiW
 QSle7OYFUohPrE20+mJFHSJUYAJR0uYkmGMBH8JBE7S8JhDKAmo/yzjxx
 qJUmT1rjz5201eiy2D8cf1kazd2pahypsuB5ML2T0A/IEUxBfd5AS1vC1 g==;
X-CSE-ConnectionGUID: YDLjuaUYSHCKfxxEuwtXHQ==
X-CSE-MsgGUID: dZ0prF3uSOGbMybh+LDjig==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="178639863"
X-IronPort-AV: E=Sophos;i="6.11,247,1725289200"; d="scan'208";a="178639863"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 17:57:42 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A1568D6EEF
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:57:39 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id EE2F7D21AD
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:57:38 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7D3FCE2519
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:57:38 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 193DE1A000B;
 Thu, 31 Oct 2024 16:57:38 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 31 Oct 2024 16:59:34 +0800
Message-ID: <20241031085934.57039-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28764.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28764.006
X-TMASE-Result: 10--7.160900-10.000000
X-TMASE-MatchedRID: BrApPpprBkTyq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUEWY
 FvwCgnnKWSDhIpxNWArGlmUjw5FYzOQu+8z9/q/lngIgpj8eDcBpkajQR5gb3lQwtQm7iV5jKra
 uXd3MZDXs6TDoV9zlz6uJFxIyzoL26BJVV+qg7RTgBg+vsezPhRzmiWflRJPa
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] llistxattr03: Convert docs to docparse
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
 .../kernel/syscalls/llistxattr/llistxattr03.c | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index 940851f40..3280e91aa 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -1,17 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2016 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*/
-
-/*
-* Test Name: llistxattr03
-*
-* Description:
-* llistxattr is identical to listxattr. an empty buffer of size zero
-* can return the current size of the list of extended attribute names,
-* which can be used to estimate a suitable buffer.
-*/
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * llistxattr is identical to listxattr. An empty buffer of size zero
+ * can return the current size of the list of extended attribute names,
+ * which can be used to estimate a suitable buffer.
+ */
 
 #include "config.h"
 #include <errno.h>
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
