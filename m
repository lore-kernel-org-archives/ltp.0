Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C83C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739955930; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=jOkh8rP1cBzZ8Ur61gj7qXwyB6OCTxAdYTEZqV/vhrI=;
 b=F92QzdmMWFFPM3wlm1KCsIEQ3SYj++FAj1wdp5DuM7K2hy/BufrT/BFQ+z6djA2kq4Tdp
 RZ84zb4rJP644BX+CUXWBsg+if0IqdEq1YyA5xxzLcHgnnmoFGfmn2khsvm3nBNIy3otZOn
 V1HQ08k4ek4iEzB7hZFL96EEl8yPrac=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE9993C29D8
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:05:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C289E3C249C
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:05:07 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 11F5D141CE99
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739955906; x=1771491906;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WilJMKfLDgM4BqJUaMWjnjBup10hLw77aiOC7XVhk58=;
 b=Lc9npc8coUsRprb9PUO7/5wVjWxa/+9VEIB3Y227f+E/3LWi//SiZQPj
 4vpHnsl52X4CciOxBUod3GIxGPi+j2upw4KELrdRsTv2I8TlgJMi+AoxM
 Plx+SuQ/IcgHFc4MhU44zlCs6/nfmXg8u+N50MzSAmviDc8ct3BGZqphM
 UMBmtQaZ39YEFN/872gYhaAzTF1kf7s/JQq7MGWfWcgPsLUoi29fd5Epp
 dKLXlLJoyg7+zCiifUdZRPj0yrbYUg65N5Oo6SoCAI2M5CC3GGg0ANl5s
 qa8pGWTpKm+WneXHpVmnwu3euZhO3eJmNHDIccgcJr6RWBgSrnfaXhAgG w==;
X-CSE-ConnectionGUID: sENQ8mvVRgaFFZ+pYl9ULA==
X-CSE-MsgGUID: bkGMHCuxSzubwh8yCLPV/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="178480068"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="178480068"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 18:05:04 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id AEBAEDBB97
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:05:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 73AB5BDB75
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:05:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D2A631A000B;
 Wed, 19 Feb 2025 17:05:01 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 17:05:05 +0800
Message-ID: <20250219090505.1039462-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] chmod06: Fix comment indentation to fit RST format
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
 testcases/kernel/syscalls/chmod/chmod06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index 7055f0da0..66b69df54 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -9,7 +9,7 @@
  * Verify that, chmod(2) returns -1 and sets errno to
  *
  * 1. EPERM if the effective user id of process does not match the owner of the
- * file and the process is not super user
+ *    file and the process is not super user
  * 2. EACCES if search permission is denied on a component of the path prefix
  * 3. EFAULT if pathname points outside user's accessible address space
  * 4. ENAMETOOLONG if the pathname component is too long
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
