Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB18EC5DF7D
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 01:24:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 871233CD2C7
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 03:24:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 146E43CCA83
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 03:24:09 +0200 (CEST)
Received: from mta1.migadu.com (out-250.mta1.migadu.com
 [IPv6:2001:41d0:203:375::fa])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4D4660006D
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 03:24:07 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=zFpIaOuadHq/vmUbhZSdEDikHE1kyoOeS51mGRavW+A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787102647; v=1; x=1787707447;
 b=IafZCme/YmcYKeBtwC3U5pxPoNSKHvEy4lDwjDusTewi+dMscLPHzoQc6ydX1B7ShbfNiyWJ
 cdlOWiI5hpNjBCt5zEStQL77F8teNAX71t9cMYra5HXiDdFFwZU5siQ3f2715OBtnCFq/y0arVf
 59MppL9+ZeSKBXgC1XH/w+Yc=
X-Envelope-To: ltp@lists.linux.it
Received: from localhost (60.247.5.98)
 by smtp.migadu.com with ESMTPS id 4b87c3690d031f4a;
 Wed, 19 Aug 2026 01:24:07 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 09:23:59 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aoUFrxZAKAGWMq7i@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260818141311.1265557-1-chrubis@suse.cz>
 <20260818141311.1265557-31-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260818141311.1265557-31-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 30/31] testcases: sysfs: Add sys_swap01
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> --- a/runtest/sysfs
> +++ b/runtest/sysfs
> @@ -25,3 +25,4 @@ sys_block_size01 sys_block_size01
>  sys_hugepages01 sys_hugepages01
>  sys_hugepages02 sys_hugepages02
>  sys_ksm01 sys_ksm01
> +sys_swap01 sys_swap01

This should be sys_mm_swap01; otherwise, the runtest file cannot
find the correct test to execute.

> --- /dev/null
> +++ b/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * Sanity check for /sys/kernel/mm/swap/vma_ra_enabled.
> + *
> + * Unlike most other boolean sysfs tunables which use 0/1, this one is
> + * formatted as the strings "true" or "false", so it needs its own check
> + * rather than TST_SYSFS_ASSERT_BOOL().
> + *
> + * The test skips with TCONF when the attribute is not present.
> + */
> +
> +#include "tst_test.h"
> +#include "tst_sysfs_assert.h"
> +
> +#define VMA_RA "/sys/kernel/mm/swap/vma_ra_enabled"

I suggest adding all of those path definitions to tst_path_defs.h
and unifying the common macro names.


Also, we need to add the sysfs/ directory to testcases/kernel/Makefile
so they can build successfully by default.

--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -36,6 +36,7 @@ SUBDIRS                       += connectors \
                           sched \
                           security \
                           sound \
+                          sysfs \
                           thermal \
                           tracing \
                           uevents \


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
