Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D07C54E41
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708955756; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gIeEvi2HwuF4Erjxf06qAepdxlKzo2x9xTB64AnuRPo=;
 b=gYkMa4USHvflZ5vuwLBdLgvdNjYlo4hY4Tv3kVzf00Npzt5UZfPCR+pZB6y0RMP7sXDn4
 Bfch+l/YtmRWv3jOKTqxs6+t/uuFRCiW1HV2jOYdeuvpE8hIbCVU/no60Fwz43bnZIsDaVK
 Nu6BwrG7SseCX1FAi598WDGKObjHiMg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BC963CF004
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 14:55:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 142E13CEFF9
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:42 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 95B5560156E
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708955681; x=1740491681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CQ/gqH2/WQGfgWR5xnkmHzNwd9etVFLbZglXhaGPf4M=;
 b=Al8Zdd4HdKwdGgefUVKchHfamOQyFEcF7400v99INc6ttfVFLlqPV3Ns
 vnN/icmTnbZ5UPvylW+a0v9zgNHlD8pswAUFEFMW7R1eXBRxkMCG6TgpN
 mqYEjwgK8sXdLBsJuzrT8ayezd0D1LKR83yE1BG3W1fmRp5L2A7nTQC1P
 M6LVoAeT76C3V7oXYzFENI5izmr4clCMk9I4AljunaIg4695k60DsHIsn
 z/KJQtPc+JgZjvUnZgwbBUFV205Hnhx3Mowp2l9CXxKJlDQFy+GPH30zl
 y6JG0pN9FlK51EnYhDrjePRw7JhG5vaGMG8n2W27hr5Ccmhhr/lRc8AlM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="150722465"
X-IronPort-AV: E=Sophos;i="6.06,185,1705330800"; d="scan'208";a="150722465"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:54:39 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 02E49A31CE
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:38 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 357834B896
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:37 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B29486B81D
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:31 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 564D71A006B;
 Mon, 26 Feb 2024 21:54:31 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 26 Feb 2024 08:53:34 -0500
Message-Id: <20240226135336.19733-5-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28214.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28214.007
X-TMASE-Result: 10--10.747900-10.000000
X-TMASE-MatchedRID: DUlKOBWbo0l+fOZykHM6uwQ6EfMOwvTm205HfQzgPdFUjspoiX02Fz13
 GoPFA1HFIvrftAIhWmLy9zcRSkKatcOJmY4XRXkVQQp1SVSsqYAWUg/hm489yLgbJOZ434Bsi8x
 T7YmZq8v8MuFbVBBITpu74XJZgEpKHxPMjOKY7A+Wlioo2ZbGwdmzcdRxL+xwKrauXd3MZDVtYe
 InNJpWkTqia33fkvvrqPqgX8slUNMKeU6HPw+SKd5TJ+G7pHTx
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/7] swapon/Makefile: Remove useless section for
 MAX_SWAPFILES
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It seems this section doesn't affect anything, btw it is useless,
so remove it.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/Makefile b/testcases/kernel/syscalls/swapon/Makefile
index 53c795090..6954112a8 100644
--- a/testcases/kernel/syscalls/swapon/Makefile
+++ b/testcases/kernel/syscalls/swapon/Makefile
@@ -1,11 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines Corp., 2001
 
-NEEDSPECIAL	:= $(shell echo MAX_SWAPFILES | $(CC) -E -xc -include linux/swap.h 2>/dev/null - | tail -n 1 | grep 32; echo $?)
-ifneq ($(strip $(NEEDSPECIAL)),)
-export CFLAGS	+= -DOLDER_DISTRO_RELEASE
-endif
-
 top_srcdir		?= ../../../..
 
 LTPLIBS = ltpswap
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
