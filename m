Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC1E82CDE
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 09:38:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C5033CDA76
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 11:38:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0DBF3CB5BA
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 11:38:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8389F208E1E
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 11:38:33 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 690701F8C4;
 Thu,  5 Oct 2023 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696498712;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7UKbDpa6XkI0cO6yqRrlDxI6OUe/pJ/fqMQ5hjXaFrY=;
 b=TsslkqBtxHVbaQE6YiLQkeurzTkckWz0iFPFyXW1vfCiPW/9poQuMS2DVaAXJgbad8ggGm
 d8TSBITJAFrPLimtRvniMSd0Wklrlm4Bq5oNxN+W7/C5zfs1xX/2gX11zuDdk76tLIrG31
 vbY9GtpXqw/ZzoGJnOdvDpgSHi3ngbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696498712;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7UKbDpa6XkI0cO6yqRrlDxI6OUe/pJ/fqMQ5hjXaFrY=;
 b=rWlIj6jIDiXV4Ggjdc4zOS/67UYF1/5N0i1fMwspa3Da4/GLmfPekWCZ53i73jOUZHd+mw
 XvAF1KaGORpN46DQ==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 241302C142;
 Thu,  5 Oct 2023 09:38:32 +0000 (UTC)
References: <20230905114157.4190-1-andrea.cervesato@suse.de>
 <20230905114157.4190-3-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 05 Oct 2023 10:18:03 +0100
Organization: Linux Private Site
In-reply-to: <20230905114157.4190-3-andrea.cervesato@suse.de>
Message-ID: <87il7l1ka2.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] Add gettid02 test
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

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> This new test is checking if gettid() is properly handling a
> multi-threaded application, by assigning a different TID for each thread
> which differs from the parent ID.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                            |  1 +
>  testcases/kernel/syscalls/gettid/.gitignore |  1 +
>  testcases/kernel/syscalls/gettid/Makefile   |  4 +-
>  testcases/kernel/syscalls/gettid/gettid02.c | 68 +++++++++++++++++++++
>  4 files changed, 73 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/kernel/syscalls/gettid/gettid02.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 4fb76584f..d50f5a3e9 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -537,6 +537,7 @@ getsockopt01 getsockopt01
>  getsockopt02 getsockopt02
>  
>  gettid01 gettid01
> +gettid02 gettid02
>  
>  gettimeofday01 gettimeofday01
>  gettimeofday02 gettimeofday02
> diff --git a/testcases/kernel/syscalls/gettid/.gitignore b/testcases/kernel/syscalls/gettid/.gitignore
> index 78dce3499..9014f7c3a 100644
> --- a/testcases/kernel/syscalls/gettid/.gitignore
> +++ b/testcases/kernel/syscalls/gettid/.gitignore
> @@ -1 +1,2 @@
>  /gettid01
> +/gettid02
> diff --git a/testcases/kernel/syscalls/gettid/Makefile b/testcases/kernel/syscalls/gettid/Makefile
> index 4e9982f76..5345eb0f5 100644
> --- a/testcases/kernel/syscalls/gettid/Makefile
> +++ b/testcases/kernel/syscalls/gettid/Makefile
> @@ -10,7 +10,9 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/testcases.mk
>  
>  ifeq ($(ANDROID), 1)
> -FILTER_OUT_MAKE_TARGETS	+= gettid01
> +FILTER_OUT_MAKE_TARGETS	+= gettid01 gettid02
>  endif
>  
> +gettid02: LDLIBS += -lpthread
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/gettid/gettid02.c b/testcases/kernel/syscalls/gettid/gettid02.c
> new file mode 100644
> index 000000000..c981d2b79
> --- /dev/null
> +++ b/testcases/kernel/syscalls/gettid/gettid02.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +/*\
> + * [Description]
> + *
> + * This test spawns multiple threads, then check for each one of them if the
> + * parent ID is different AND if the thread ID is different from all the other
> + * spwaned threads.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "tst_safe_pthread.h"
> +
> +#define THREADS_NUM 10
> +
> +static pid_t tids[THREADS_NUM];
> +
> +static void *threaded(void *arg)
> +{
> +	int i = *(int *)arg;
> +	pid_t pid, tid;
> +
> +	pid = getpid();

Maybe we could call __NR_getpid directly as well and compare it?

Same reason as with other test; libc's like to be clever and cache this
value. So maybe we are not testing the kernel here.

Otherwise LGTM.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
