Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0434C3DA6F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 09:24:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED36A3CC3FD
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 11:24:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B981F3CB8A2
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:24:17 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BB1AA600653
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:24:13 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="117712761"
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; d="scan'208";a="117712761"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 18:24:10 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 00B10D29EA
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 18:24:09 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2ED64D617F
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 18:24:08 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id AA8F26BEEB;
 Fri, 25 Aug 2023 18:24:07 +0900 (JST)
Message-ID: <040088ba-20f1-711f-3fe5-6d1d4782a015@fujitsu.com>
Date: Fri, 25 Aug 2023 17:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <1692875424-22449-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <1692875424-22449-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27834.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27834.006
X-TMASE-Result: 10--19.200500-10.000000
X-TMASE-MatchedRID: T3hsd5K8wICPvrMjLFD6eLxygpRxo469yiKgKtIyB4o1Y73PdzvXZJ2S
 8eF0t50J3eSQrynh0LUknOGoeIQzlrBAQLqGlKivrMZ+BqQt2NoJlr1xKkE5uaShvRjfn4cUjdx
 5FdhImgMi+t+0AiFaYsrbguuTTSDuTBhdFGvbKae3D7EeeyZCM1InAQV408ARnKRrn2xogKjcV/
 v7G+gTwc1zV3T5mcSEkZOl7WKIImrvXOvQVlExsEY41YX/o/8KDZX99HwFDsIqtq5d3cxkNXhoF
 poqi9zvHY11is+VaFoYhZ930uciWgiTZY3sxXfBQTH1CKiVa8I=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/renameat: Remove renameat fallback
 definition
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

1) Please explain why you drop the fallback definition by adding a 
commit message.
2) I think the related code in the following file can also be removed:
configure.ac
include/lapi/syscalls/aarch64.in
include/lapi/syscalls/arc.in
include/lapi/syscalls/arm.in
include/lapi/syscalls/hppa.in
include/lapi/syscalls/i386.in
include/lapi/syscalls/ia64.in
include/lapi/syscalls/loongarch.in
include/lapi/syscalls/mips_n32.in
include/lapi/syscalls/mips_n64.in
include/lapi/syscalls/mips_o32.in
include/lapi/syscalls/powerpc.in
include/lapi/syscalls/powerpc64.in
include/lapi/syscalls/s390.in
include/lapi/syscalls/s390x.in
include/lapi/syscalls/sh.in
include/lapi/syscalls/sparc.in
include/lapi/syscalls/sparc64.in
include/lapi/syscalls/x86_64.in

Other than those, it looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

On 2023/8/24 19:10, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/renameat.h                       | 23 -------------------
>   .../kernel/syscalls/renameat/renameat01.c     |  1 -
>   2 files changed, 24 deletions(-)
>   delete mode 100644 include/lapi/renameat.h
> 
> diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
> deleted file mode 100644
> index abf4c1d6e..000000000
> --- a/include/lapi/renameat.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (c) International Business Machines  Corp., 2007
> - * Copyright (c) 2014 Fujitsu Ltd.
> - */
> -
> -#ifndef LAPI_RENAMEAT_H__
> -#define LAPI_RENAMEAT_H__
> -
> -#include <sys/types.h>
> -#include "config.h"
> -#include "lapi/syscalls.h"
> -
> -#if !defined(HAVE_RENAMEAT)
> -static inline int renameat(int olddirfd, const char *oldpath, int newdirfd,
> -                           const char *newpath)
> -{
> -	return tst_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
> -					newpath);
> -}
> -#endif
> -
> -#endif /* LAPI_RENAMEAT_H__ */
> diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
> index 3de103563..c318a7971 100644
> --- a/testcases/kernel/syscalls/renameat/renameat01.c
> +++ b/testcases/kernel/syscalls/renameat/renameat01.c
> @@ -50,7 +50,6 @@
>   #include "test.h"
>   #include "safe_macros.h"
>   #include "lapi/fcntl.h"
> -#include "lapi/renameat.h"
>   
>   #define MNTPOINT "mntpoint"
>   #define TESTDIR "testdir"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
