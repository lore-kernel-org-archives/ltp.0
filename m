Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3076AC4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707386825; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gIeEvi2HwuF4Erjxf06qAepdxlKzo2x9xTB64AnuRPo=;
 b=f8ochzGsnlleDI7ozqxEH26ACawxGVg/kiEEq8wTru04zaFvfEgzeytw/4xfEQguOx5QR
 b2O5/uGffcwnnDim/DyxMF7im0hlkVYeSncbpjISXtzPMuF3zMpRBUz94ATVfItVXrYXsxm
 sY2xU0SKfLG37RKBCqtuggoYDGIE770=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 737B43CC5F8
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 11:07:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 573C43CDEA3
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:46 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A47B66126EF
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707386745; x=1738922745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CQ/gqH2/WQGfgWR5xnkmHzNwd9etVFLbZglXhaGPf4M=;
 b=k/AHUSYhrHYrk3dEBMDhCk9hxC6aQTbv1DRJ0mMav4Z6exBLaJo8+wap
 4AehiV4I7/uV3/LfXOeRKcBdlzXAmRD0FKCLum6bRncGcN1IUHqoelrAy
 atENcM0S7AlRinSyVZxWXBNscD4zNdmfkwziQaOEs4SaAT5vJlO42+uez
 WUz+02pAjoIJ2TxkYzEnzGWKAERUjElGwHN3A/JAhB8oxqV/g7VE6z6z8
 ICD/lqYp4uWyP6KJfewGiz7YjFn/A4I+iSVD/W1Y3CO/BCF+Rh23lmcTL
 Bm4pKB14uVLwV4mDnZ4QQu0mIFwoLlAkZNyUdQdIb5KvfEs6VE5jsDlvL A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="149090809"
X-IronPort-AV: E=Sophos;i="6.05,253,1701097200"; d="scan'208";a="149090809"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 19:05:43 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B721E2328EB
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:41 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E667919B97B
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E33A82D4E
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:40 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 206151A009A;
 Thu,  8 Feb 2024 18:05:40 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 05:05:15 -0500
Message-Id: <20240208100517.1974-5-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28178.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28178.003
X-TMASE-Result: 10--10.747900-10.000000
X-TMASE-MatchedRID: DUlKOBWbo0l+fOZykHM6uwQ6EfMOwvTm205HfQzgPdFUjspoiX02Fz13
 GoPFA1HFIvrftAIhWmLy9zcRSkKatcOJmY4XRXkVQQp1SVSsqYAWUg/hm489yLgbJOZ434Bsi8x
 T7YmZq8v8MuFbVBBITpu74XJZgEpKHxPMjOKY7A+Wlioo2ZbGwdmzcdRxL+xwKrauXd3MZDVtYe
 InNJpWkTqia33fkvvrqPqgX8slUNMKeU6HPw+SKd5TJ+G7pHTx
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/7] swapon/Makefile: Remove useless section for
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
