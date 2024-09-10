Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F53AECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725962395; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=KevVFG1HIxCfOdTcsfGvgndx4VJ7dohRfiVqmdXzkM4=;
 b=ecSvi6zN2+gS9QXKWlxF0xPUcU/x/6SG/Eg6ni3cQTjC9utg1HXsYUtYemramlcy5MNJc
 Pw/cIFexBmY6ocV2hLP6EUygMbNlnMjduhhYKF/UM9x5YViIt97yfku6M2zUh74OtXjF01T
 vkwIlZGnL/3oC8Vkbf+K3ybyiPeHbQU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 613A23C1AC4
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 11:59:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C88143C020C
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 11:59:34 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E7B661A00445
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 11:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1725962374; x=1757498374;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nZr6IcmoXDbAi3Bgeg9MkX2JX9icHPDayapotPEjWUQ=;
 b=JMPfrCSyT1onpqvEYdJ/dzyq7WvixRiKJALc1Z3WCCpFzqlOeanyX1w2
 IHuK3XmA3BjhV0Hs1y48OMZNeQNUSgsXpHuRK2rQ6wwXxwxmiIaFDHrXZ
 XEYjdY1wVSdsU2VAK7VD14L6r18P3DLhheglbtisSLwkfDZYQBltGEB+R
 Ykj+hQX0ngKj0bK/wJuxhJiouSpW8Q1TpV6ZXztj3aj9gawKObcaDNX4A
 irKJNjUBbdwU1YZY6LHzTxiqlzXeeaMBkkJsDeHRU+DeEgcsUjIGT9EC7
 94871fI40GbrzzPNtWWwKeXHbGq74DHFHQYyU0ikCrlAicHkKdIUgdpvu Q==;
X-CSE-ConnectionGUID: LhHgRRiLQJqm3i3VQwUeEQ==
X-CSE-MsgGUID: kdT3N080T4K63D1xnIugaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="160632055"
X-IronPort-AV: E=Sophos;i="6.10,216,1719846000"; d="scan'208";a="160632055"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 18:59:31 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 43FE5E4458
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 18:59:29 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 961271034D
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 18:59:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2CF58200894AA
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 18:59:28 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 9AFFF1A000B;
 Tue, 10 Sep 2024 17:59:27 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 10 Sep 2024 18:01:30 +0800
Message-ID: <20240910100130.58203-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28654.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28654.006
X-TMASE-Result: 10--8.025900-10.000000
X-TMASE-MatchedRID: FMY5IFaWNFChhjsqgSuNbxF4zyLyne+ATJDl9FKHbrmOEENgsUAuYuCY
 OCAduFDo//37E7X3yIKAMuqetGVetiVvu9chHp+mavP8b9lJtWr6C0ePs7A07fyjtizU0rhjLxN
 AYitCzIiG5APT5aJhQEzp5zO+QE50kmc3FbMeGPE=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lremovexattr01: Convert docs to docparse
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
 testcases/kernel/syscalls/lremovexattr/lremovexattr01.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
index 590f5a6f3..ec27bbbc7 100644
--- a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
+++ b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
@@ -4,10 +4,9 @@
  * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
  */
 
-/*
- * Test Name: lremovexattr01
+/*\
+ * [Description]
  *
- * Description:
  * lremovexattr(2) removes the extended attribute identified by a name and
  * associated with a given path in the filesystem. Unlike removexattr(2),
  * lremovexattr(2) removes the attribute from the symbolic link only, and not
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
