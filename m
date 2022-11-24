Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCD8C433FE
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 12:11:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65F9C3CC950
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 13:11:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1E213CC907
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 13:11:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09FF1600791
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 13:10:59 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 10B3B218F2;
 Thu, 24 Nov 2022 12:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669291859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jjam6vXQMMItioG/1XSv1KpE0oO1FPgKuv6gQMDdeUs=;
 b=JsQTbhEAddaJOVPG08NI2Q+56O9yexe+8m201AHEeEWB8WK7sOP+ys6gIFWzfQTuNVWrx7
 wbmS6XgVXklDZbDJ3MngCvrdjivDoCqXHz2w7P61C3dTrlQckcQPeTHUhq/y/4SiXFCHUa
 ZWf+gx5dRdVvkOMEYt/2moh6E5x0wF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669291859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jjam6vXQMMItioG/1XSv1KpE0oO1FPgKuv6gQMDdeUs=;
 b=f0va5cRts7NIWMWaQ4fADvKG330JbtQp1om4sKbs4oNIv6qtkbiELJX/7uvHVyaSjkeFvY
 KT1Wc2IzSNDZXbCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DB7A52C141;
 Thu, 24 Nov 2022 12:10:58 +0000 (UTC)
References: <20221028090053.1662-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Thu, 24 Nov 2022 11:43:47 +0000
Organization: Linux Private Site
In-reply-to: <20221028090053.1662-1-andrea.cervesato@suse.com>
Message-ID: <87k03keenh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add epoll_wait07 test
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

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> This test verifies EPOLLONESHOT functionality.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Make use of SAFE_EPOLL_* macros
> Listen to EPOLLIN event instead of EPOLLOUT
>
>  .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait07.c | 78 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
>
> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
> index 8c5ed7c5c..66ac18ae2 100644
> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
> @@ -4,3 +4,4 @@ epoll_wait03
>  epoll_wait04
>  epoll_wait05
>  epoll_wait06
> +epoll_wait07
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
> new file mode 100644
> index 000000000..9a492c148
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
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
> +#define WRITE_SIZE 2048
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
> +	char buff[WRITE_SIZE];
> +	struct epoll_event evt_receive;
> +	struct epoll_event evt_request;
> +
> +	SAFE_PIPE(fds);
> +
> +	evt_request.events = EPOLLIN | EPOLLONESHOT;
> +	evt_request.data.fd = fds[1];

I'm not sure why you set the data?

> +
> +	epfd = SAFE_EPOLL_CREATE1(0);
> +
> +	tst_res(TINFO, "Polling channel with EPOLLONESHOT");
> +
> +	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, fds[0], &evt_request);
> +
> +	tst_res(TINFO, "Write on channel multiple times");
> +
> +	memset(buff, 'a', WRITE_SIZE);
> +	SAFE_WRITE(0, fds[1], buff, WRITE_SIZE);
> +	SAFE_WRITE(0, fds[1], buff, WRITE_SIZE);

Why call write twice?

You don't read the data between waits and it is level triggered not edge
triggered.

> +
> +	SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 2000);
> +
> +	if ((evt_receive.events & EPOLLIN) == 0) {
> +		tst_res(TFAIL, "No data received");

The chances of this failing are very close to zero, but if it does then
debugging will be difficult.

> +		goto close;
> +	}
> +
> +	tst_res(TINFO, "Received first EPOLLIN event");
> +
> +	TST_EXP_EQ_LI(epoll_wait(epfd, &evt_receive, 1, 0), 0);
> +

The test is valid AFAICT, but there is stuff which confuses it.

> +close:
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
