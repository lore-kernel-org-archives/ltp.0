Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92141C48BC4
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708415102; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=SjdKedGpyPO+HZ6lYdv7bDj8IPzZd6iTKf+vC0fbscs=;
 b=TA9oktOhAd+48He1iQJp+300fK/QYx/nwRzAEonlA2TZsavECoiE61zPvj1O21ZdJeIGv
 Ow8KhMSZTVBtkpOwj8N6S4K9xiO2Q/l4h4lQAXCSpvPOFvJ/qz/nfsJAObt4NkFz0UKxZND
 ghl+yZ6By9HV9OtX8VI4TlqbVrt541w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 168DE3CEFAD
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 08:45:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 453FB3CDB93
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:43:59 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BAFE0200931
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:43:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708415040; x=1739951040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y08G2ipMnajOjGvdXQU2JrMQqxW0nak+wl4qhGQYnec=;
 b=VW5gfhT4tNE2G5NwwrcwXwCrtWSSj+sN6EJhzyPFepG2dEYudZ16jLVC
 9kPK+V5RGDtFYa2KZhUin3aycVyaHkD56iP0AuaDjlQng4dmfRMl4f+xC
 wce7Q0ozItmIXt+t2nTthHAVIXgelAnvInjor5gAfA/T9ySEcVOIB4ZvL
 6GbRYQCqbIYJynuwGY9Y/QK8MVu88ZGv3YmDyTmjurE3VV9wWtjlvPEZP
 gI6F3mrCe8RLoSSYinMOcD+TUBRBoWR+VktjiujEJl4S+S0nuAldPKiRA
 /d/RggS08iGPqE/wktiGllvyOMn/7/fqqgvSzTJlKFDvH/9gyB8bUo94n w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="149865686"
X-IronPort-AV: E=Sophos;i="6.06,172,1705330800"; d="scan'208";a="149865686"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 16:43:57 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5FDE42ADE15
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:54 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A6A53CF7D3
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4868820097CE1
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:53 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C032D1A006B;
 Tue, 20 Feb 2024 15:43:52 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 02:42:16 -0500
Message-Id: <20240220074218.13487-5-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28202.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28202.005
X-TMASE-Result: 10--10.747900-10.000000
X-TMASE-MatchedRID: DUlKOBWbo0l+fOZykHM6uwQ6EfMOwvTm205HfQzgPdFUjspoiX02Fz13
 GoPFA1HFIvrftAIhWmLy9zcRSkKatcOJmY4XRXkVQQp1SVSsqYAWUg/hm489yLgbJOZ434Bsi8x
 T7YmZq8v8MuFbVBBITpu74XJZgEpKHxPMjOKY7A+Wlioo2ZbGwdmzcdRxL+xwKrauXd3MZDVtYe
 InNJpWkTqia33fkvvrqPqgX8slUNMKeU6HPw+SKd5TJ+G7pHTx
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/7] swapon/Makefile: Remove useless section for
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
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
