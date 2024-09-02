Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4BCCA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 03:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725249058; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=jLbPbuLwC9wC9Eyz98DZ8ixh6WrnIBvJHVX/rQnymbU=;
 b=TQYt/r0/O78mAMkDIJawFqm6pgZzeThD3UQRcLqGFK9MzP16SkMlcghcrfXYxK/4fCn1a
 XnSjy+yDDKaNnGnduGtQXONSZuSvU37lhM7Q1Xg6IB2iKpa7ZIPAWmmu/jp3JO7BFl6QTxM
 m+BlL9xcHkK3Ha0WBXun6BOb6yIT0RI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3E243C30FC
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 05:50:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1DA93C0352
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 05:50:36 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A91E6000BE
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 05:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1725249035; x=1756785035;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fbwLeEGbjQtz1LdV9MKAhM+DMEY57dfjZGjD+0elHuE=;
 b=C2Ql8kMreYWy+WbyqmqwE7dTHYR7UIaifVlaCq57JxNIn2qIRHRZ3Ntg
 LDA5l20/nJZv8tPlQarbh6Nct8l2EvQnfjw9ceZyryXCzyH6MJxuuaZoq
 IaWVKmNYIaJthy3vMJBNMiELNmFsrsgivNgmP3ck8a2fVpEz7YK4OWKEn
 CJu/qqIGPDLDimExujkFylAYqkVA0FPnYefkDdoTFh4NI0DM1Daq+T5TC
 PsrbRcW2wxhvBAw4FhU0+xzlcFz44cvtK9na6wUVmCxw+CGb8UNKDFXB4
 RgtRlx8D2H7w0MbgMYPeoAr/pDnjGk1XmQUUunVAs21Lj9MRiqGdWsvp0 Q==;
X-CSE-ConnectionGUID: 1kyZBksYT2WHGzF6cYPCDg==
X-CSE-MsgGUID: XiiMyw8ESeWgebL5JfyCUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="151215268"
X-IronPort-AV: E=Sophos;i="6.10,195,1719846000"; d="scan'208";a="151215268"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2024 12:50:31 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 14BAED9223
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 12:50:30 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5DAF1BF3C8
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 12:50:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B83DA6B8D3
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 12:50:28 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2F6411A0002;
 Mon,  2 Sep 2024 11:50:28 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon,  2 Sep 2024 11:51:56 +0800
Message-ID: <20240902035157.628689-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28636.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28636.004
X-TMASE-Result: 10--5.021700-10.000000
X-TMASE-MatchedRID: v71phiYrRiGhhjsqgSuNbxF4zyLyne+ATJDl9FKHbrld9QH9+oDGk0WY
 FvwCgnnK9VXChddGwqQKfxNpX2AZXB8TzIzimOwPlpYqKNmWxsHZs3HUcS/scCq2rl3dzGQ1ZlU
 p3FmUj7h8QJz4Y0T2ax1iNlqj16TtLRv4qrVJKWXEgQjzgAlkIA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] bind02: Convert docs to docparse
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
 testcases/kernel/syscalls/bind/bind02.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind02.c b/testcases/kernel/syscalls/bind/bind02.c
index 7720fd0d7..9f5f940e9 100644
--- a/testcases/kernel/syscalls/bind/bind02.c
+++ b/testcases/kernel/syscalls/bind/bind02.c
@@ -6,9 +6,10 @@
  *   Copyright (c) 2019 Martin Doucha <mdoucha@suse.cz>
  */
 
-/*
- * Test Description:
- *  Make sure bind() of privileged port gives EACCESS error for non-root users.
+/*\
+ * [Description]
+ *
+ * Make sure bind() of privileged port gives EACCESS error for non-root users.
  */
 
 #include <string.h>
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
