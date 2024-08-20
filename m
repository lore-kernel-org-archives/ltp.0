Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0F1C3DA4A
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724145963; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=qNozBqe5Y6ygXYkzr2ZrXVmPo75x7Lj1KiN0bDbpWzc=;
 b=NV5Gg0kIu4Eag7z9TKCD3b8zsu5d/yiz7EnHCo8tHOy5QtPe4bEnye12SRHXWGXj0vGDh
 Z5gy+jsaE+5WQzvmkJpSpK/rFiuWSIubyROr8LDcifye5HeDlHsUBDxDfquN00Tamxj9Qx8
 lzFmvOV59Iqdlv/Vxwjue1tYmcPNLsg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEFB23CC528
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 11:26:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F35B3CABAB
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 11:25:42 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7328560081E
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 11:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1724145941; x=1755681941;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JVoh1iqmujx2ijr4jYIIbZqj2iyjflrCUyPzliwAh4Y=;
 b=MDnD6mps0bKODKnHppDJ5gjfY9elId+4S/M9dj3faYHe6zc37e9VG8os
 y4fWJ9OZU4qcrkahw2PfiHhbdYZH6fimktcHe2yxSDd4HieRInZ52AlUr
 1aPp/ygtcnmS129BiBOAMXfgxFzqQiR/r1XHMFTdziQYWP1S7Rr6wP4bv
 rwdZiUes9ay7/G932nzD6dj65RlkAJkAcUACnHhqeVesBrac8FCr4EbfN
 Yb+79BemMYD3msiDOQO/6IVaefeMOrj6LcNyqMCKPVl3egLYdy/G3UtZn
 Gd6fFSTeq6vJijVF0sBJutQQr4+l1z443no70A2SfouLxdi6zg0+E+aCX Q==;
X-CSE-ConnectionGUID: A9rv85+YQmO0DfaU4HzfqQ==
X-CSE-MsgGUID: 0FfdMsN+RK+cuKojly6hkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="171050824"
X-IronPort-AV: E=Sophos;i="6.10,161,1719846000"; d="scan'208";a="171050824"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2024 18:25:38 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 28148D424D
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 18:25:36 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 64B70D4C39
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 18:25:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E75242007CAA8
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 18:25:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5C5B61A0002;
 Tue, 20 Aug 2024 17:25:34 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 20 Aug 2024 17:27:15 +0800
Message-ID: <20240820092715.2744915-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28606.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28606.006
X-TMASE-Result: 10-0.184900-10.000000
X-TMASE-MatchedRID: 5glXJzDlDkTR6RKL7TRTbhF4zyLyne+ATJDl9FKHbrl4T84aDQ++zKPF
 jJEFr+olq+TyQ7O4buzHHuXTAmChXd0H8LFZNFG76sBnwpOylLMeFK0LCM+rIKlV5bMUEGoPltp
 nRMLcu8Pyyr8VLr7DDrWwzjdcSOuKWB4fXMPdXAydCSNVxR5Qi02Ap/6tHm9lBg899Y3XihQhya
 dlGFXHKsTgfCdKUS4cicSkmYsAV+kLUU1zqiphVX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: documentation: Fix a typo
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

Fixed a spelling mistake("enviroment" to "environment").

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 doc/developers/documentation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
index 606edc014..0cd3173fa 100644
--- a/doc/developers/documentation.rst
+++ b/doc/developers/documentation.rst
@@ -20,7 +20,7 @@ command as following:
 
     cd doc
 
-    # prepare virtual enviroment
+    # prepare virtual environment
     python3 -m virtualenv .venv
     . .venv/bin/activate
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
