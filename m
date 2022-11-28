Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E70C433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 13:32:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D3EE3CC66A
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 14:32:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ACC73C714A
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 14:32:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC0FA200067
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 14:32:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1A09E1F381;
 Mon, 28 Nov 2022 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669642353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OHpJTb2CXDBxDrxXMUraxxOlhTRDzTiJ0T1kRnuv4Yk=;
 b=rHZgDoy7c6P0YWDTWC4ELi8/WRHK2ce7nrPc50DMErcRw985duAnt1iVtBRr3FBF6h8pkN
 GrcpMf8z0LoMgv2ztibMiz/BhfWJwzv74MK0kkFCakLxhK/Bc0PsxmsMc3hM5Tf9m0aJdo
 YZWB3Ca6BDLcIZSxas/o4GuTwn33H/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669642353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OHpJTb2CXDBxDrxXMUraxxOlhTRDzTiJ0T1kRnuv4Yk=;
 b=blfA8M+al4KuIT/uqOM0LTMwgpPSSMMPjVZ6IcO8fMy5+bqD/KPBJFcJIY9rtyxspCtaF1
 A7jVZ5VyEFMrvKBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A3F8A2C141;
 Mon, 28 Nov 2022 13:32:32 +0000 (UTC)
References: <20221116021651.21104-1-zhaogongyi@huawei.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 28 Nov 2022 12:38:52 +0000
Organization: Linux Private Site
In-reply-to: <20221116021651.21104-1-zhaogongyi@huawei.com>
Message-ID: <87pmd7urv9.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/sched_setscheduler04: new test for
 sched_setscheduler()
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Zhao Gongyi via ltp <ltp@lists.linux.it> writes:

> Verify that the scheduling policy and parameters are in fact per-thread
> attributes on Linux:
> 1. Specifying pid as 0 will operate on the attributes of the calling thread
> 2. The value returned from a call to gettid(2) can be passed in the argument
>    pid.
> 3. Passing the value returned from a call to getpid(2) will operate on the
>    attributes of the main thread of the  thread  group
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  runtest/syscalls                              |   1 +
>  .../syscalls/sched_setscheduler/.gitignore    |   1 +
>  .../syscalls/sched_setscheduler/Makefile      |   2 +
>  .../sched_setscheduler/sched_setscheduler04.c | 101 ++++++++++++++++++
>  4 files changed, 105 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3dc6fa397..ff516af3d 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1204,6 +1204,7 @@ sched_getscheduler02 sched_getscheduler02
>  sched_setscheduler01 sched_setscheduler01
>  sched_setscheduler02 sched_setscheduler02
>  sched_setscheduler03 sched_setscheduler03
> +sched_setscheduler04 sched_setscheduler04
>
>  sched_yield01 sched_yield01
>
> diff --git a/testcases/kernel/syscalls/sched_setscheduler/.gitignore b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
> index aa8ad9695..1b8860d2c 100644
> --- a/testcases/kernel/syscalls/sched_setscheduler/.gitignore
> +++ b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
> @@ -1,3 +1,4 @@
>  /sched_setscheduler01
>  /sched_setscheduler02
>  /sched_setscheduler03
> +/sched_setscheduler04
> diff --git a/testcases/kernel/syscalls/sched_setscheduler/Makefile b/testcases/kernel/syscalls/sched_setscheduler/Makefile
> index 044619fb8..e3d54e33e 100644
> --- a/testcases/kernel/syscalls/sched_setscheduler/Makefile
> +++ b/testcases/kernel/syscalls/sched_setscheduler/Makefile
> @@ -3,6 +3,8 @@
>
>  top_srcdir		?= ../../../..
>
> +sched_setscheduler04: CFLAGS += -pthread
> +
>  include $(top_srcdir)/include/mk/testcases.mk
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> new file mode 100644
> index 000000000..38f5750ba
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright(c) 2022 Huawei Technologies Co., Ltd
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that the scheduling policy and parameters are in fact per-thread
> + * attributes on Linux:

No it doesn't. This test would still pass if calling sched_setscheduler
changed the priority of every thread on the system.

NACK.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
