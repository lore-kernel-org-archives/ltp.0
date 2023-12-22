Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83752C41535
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 06:56:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11AE03C9AC2
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 07:56:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05F413C9A28
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:56:21 +0100 (CET)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0F1D96024A8
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:56:19 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="144539463"
X-IronPort-AV: E=Sophos;i="6.04,294,1695654000"; d="scan'208";a="144539463"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 15:56:18 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4071ED9DA5
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:56:16 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B9F5C5CC9
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:56:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 23EC3202C9741
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:56:15 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id CD7841A006F;
 Fri, 22 Dec 2023 14:56:14 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 22 Dec 2023 00:00:04 -0500
Message-Id: <20231222050006.148845-5-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28072.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28072.005
X-TMASE-Result: 10--10.747900-10.000000
X-TMASE-MatchedRID: DUlKOBWbo0l+fOZykHM6uwQ6EfMOwvTm205HfQzgPdFUjspoiX02Fz13
 GoPFA1HFIvrftAIhWmLy9zcRSkKatcOJmY4XRXkVQQp1SVSsqYAWUg/hm489yLgbJOZ434Bsi8x
 T7YmZq8v8MuFbVBBITpu74XJZgEpKHxPMjOKY7A+Wlioo2ZbGwdmzcdRxL+xwKrauXd3MZDWhNy
 aOMoiE/Gvjg1227U0ihNE+a+cTXuxdxTrc3AI/8gKboGwVsD9E
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/7] swapon/Makefile: Remove useless section for
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It seems this section doesn't affect anything, btw it is useless,
so remove it.

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
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
