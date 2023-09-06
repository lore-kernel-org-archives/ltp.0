Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4636EB8FAF
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 08:47:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9351E3CB77B
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 10:47:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FB893CAB42
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 10:46:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E0A6C1401655
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 10:46:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B395F2238B;
 Wed,  6 Sep 2023 08:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693990006;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPZABg8Av/HiopgFVX01GiGvf8QzsJHjhrFbcP0JBno=;
 b=pQSZvZzHEJSt0c1ykRrZ8QFiVeQwEO6V0wkJHjZUTK2L7F3HJxX66h5GWbGk8saBft/i15
 PbxHmNu0gwf1jfnFaiD/Rs7cib1bfEriih4eL1px12ojEFTXnYPaBk7QBqrnLEPFCBVxQG
 AAqv0FHpcRZRmJNsdq4VBp7S496VeLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693990006;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPZABg8Av/HiopgFVX01GiGvf8QzsJHjhrFbcP0JBno=;
 b=m6D7JEtQruaNcAcyKuhcZqVlnEWgnFA1ZUqeCQt/3KYBwq/ukA36TqLZhL7ygiGogAoHoI
 lrVi/ZWuPu5fQjCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8BD482C142;
 Wed,  6 Sep 2023 08:46:46 +0000 (UTC)
References: <20230825103056.7819-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 06 Sep 2023 09:46:37 +0100
Organization: Linux Private Site
In-reply-to: <20230825103056.7819-1-andrea.cervesato@suse.de>
Message-ID: <87zg1zeljf.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add epoll_wait07 test
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

Pushed!

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> This test verifies that EPOLLONESHOT is correctly handled by
> epoll_wait.
>
> Implements: https://github.com/linux-test-project/ltp/issues/860
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                              |  1 +
>  .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait07.c | 73 +++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 88e868a74..1cdba11ce 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -175,6 +175,7 @@ epoll_wait01 epoll_wait01
>  epoll_wait02 epoll_wait02
>  epoll_wait03 epoll_wait03
>  epoll_wait04 epoll_wait04
> +epoll_wait07 epoll_wait07
>  epoll_pwait01 epoll_pwait01
>  epoll_pwait02 epoll_pwait02
>  epoll_pwait03 epoll_pwait03
> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
> index 222955dd2..c0be9a88e 100644
> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
> @@ -2,3 +2,4 @@ epoll_wait01
>  epoll_wait02
>  epoll_wait03
>  epoll_wait04
> +epoll_wait07
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
> new file mode 100644
> index 000000000..dfabd0d87
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that EPOLLONESHOT is correctly handled by epoll_wait.
> + * We open a channel, write in it two times and verify that EPOLLIN has been
> + * received only once.
> + */
> +
> +#include <poll.h>
> +#include <sys/epoll.h>
> +#include "tst_test.h"
> +#include "tst_epoll.h"
> +
> +static int fds[2];
> +static int epfd;
> +
> +static void cleanup(void)
> +{
> +	if (epfd > 0)
> +		SAFE_CLOSE(epfd);
> +
> +	if (fds[0] > 0)
> +		SAFE_CLOSE(fds[0]);
> +
> +	if (fds[1] > 0)
> +		SAFE_CLOSE(fds[1]);
> +}
> +
> +static void run(void)
> +{
> +	struct epoll_event evt_receive;
> +	char buff = 'a';
> +
> +	SAFE_PIPE(fds);
> +
> +	tst_res(TINFO, "Polling on channel with EPOLLONESHOT");
> +
> +	epfd = SAFE_EPOLL_CREATE1(0);
> +
> +	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, fds[0], &((struct epoll_event) {
> +		.events = EPOLLIN | EPOLLONESHOT,
> +		.data.fd = fds[0],
> +	}));
> +
> +	tst_res(TINFO, "Write channel for the 1st time. EPOLLIN expected");
> +
> +	SAFE_WRITE(0, fds[1], &buff, 1);
> +	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 1);
> +	TST_EXP_EQ_LI(evt_receive.events & EPOLLIN, EPOLLIN);
> +	TST_EXP_EQ_LI(evt_receive.data.fd, fds[0]);
> +
> +	SAFE_READ(1, fds[0], &buff, 1);
> +	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 0);
> +
> +	tst_res(TINFO, "Write channel for the 2nd time. No events expected");
> +
> +	SAFE_WRITE(0, fds[1], &buff, 1);
> +	TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 10, 0), 0);
> +
> +	SAFE_CLOSE(epfd);
> +	SAFE_CLOSE(fds[0]);
> +	SAFE_CLOSE(fds[1]);
> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.test_all = run,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
