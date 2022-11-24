Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E89C4321E
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 11:19:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16DFA3CC92A
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 12:19:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8088E3C0162
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 12:19:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C00971400993
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 12:19:24 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A57A91FD8B;
 Thu, 24 Nov 2022 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669288762;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PIvJv/LtqWdrXwMzj2VyAwlRXWPkoPmK/4wx5LuL3AI=;
 b=CSBUj2vhy9pG2TwkRlrBpp9Uv1ztYzvqLrOhvPXUmcjzFiXSPZHfytuejNOXcewPmmqqSD
 yYD4K0o8m1FOZLAUtU/oZW1mhn+MlXPSYylPrSkiPNY9hK5tFFLBWdmenD3pEO7hJ//xVd
 J/JpBpjrGUsaiTxFFL92CIR7Sm/U+Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669288762;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PIvJv/LtqWdrXwMzj2VyAwlRXWPkoPmK/4wx5LuL3AI=;
 b=MXLHZ90SL02jN3um7uPIt07AKn2b572gzhMWD+bKUtvvOpAhB6asOBkRbKvFHdqija06vY
 0PemJzpjNjbtICBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 820212C141;
 Thu, 24 Nov 2022 11:19:22 +0000 (UTC)
References: <20221028085913.983-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Thu, 24 Nov 2022 10:48:20 +0000
Organization: Linux Private Site
In-reply-to: <20221028085913.983-1-andrea.cervesato@suse.com>
Message-ID: <87o7sweh1i.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add epoll_wait06 test
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

> This test verifies EPOLLET functionality.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Make use of SAFE_EPOLL_* macros.
> Wait for EPOLLOUT event instead of EPOLLIN
>
>  .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait06.c | 90 +++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
>
> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
> index ab5a9c010..8c5ed7c5c 100644
> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
> @@ -3,3 +3,4 @@ epoll_wait02
>  epoll_wait03
>  epoll_wait04
>  epoll_wait05
> +epoll_wait06
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
> new file mode 100644
> index 000000000..f263f9041
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that EPOLLET is correctly handled by epoll_wait.
> + *
> + * [Algorithm]
> + *
> + * 1. The file descriptor that represents the read side of a pipe (rfd) is
> + *    registered on the epoll instance.
> + * 2. A pipe writer writes 2 kB of data on the write side of the pipe.
> + * 3. A call to epoll_wait(2) is done that will return rfd as a ready file
> + *    descriptor.
> + * 4. The pipe reader reads 1 kB of data from rfd.
> + * 5. A call to epoll_wait(2) should hang (return 0) because there's data left
> + *    to read.
> + */

Do you get the purpose of EPOLLET? It's for when you fill the write
buffer and want to sleep until you can write again.

However you dont' want to receive EPOLLOUT the whole time because
epoll_wait never waits for reads. It will constantly return even when
there are no writes to do and no reads.

> +
> +#include <poll.h>
> +#include <sys/epoll.h>
> +#include "tst_test.h"
> +#include "tst_epoll.h"
> +
> +#define WRITE_SIZE 2048
> +#define READ_SIZE (WRITE_SIZE / 2)
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
> +	evt_request.events = EPOLLOUT | EPOLLET;
> +	evt_request.data.fd = fds[0];
> +
> +	epfd = SAFE_EPOLL_CREATE1(0);
> +
> +	tst_res(TINFO, "Polling channel with EPOLLET");
> +
> +	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, fds[1], &evt_request);
> +
> +	tst_res(TINFO, "Write bytes on channel");
> +
> +	memset(buff, 'a', WRITE_SIZE);
> +	SAFE_WRITE(0, fds[1], buff, WRITE_SIZE);
> +
> +	SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 2000);
> +
> +	if ((evt_receive.events & EPOLLOUT) == 0) {
> +		tst_res(TFAIL, "No EPOLLOUT received");
> +		goto close;
> +	}
> +
> +	tst_res(TINFO, "Received EPOLLOUT event. Read half bytes from channel");
> +
> +	memset(buff, 0, READ_SIZE);
> +	SAFE_READ(1, evt_receive.data.fd, buff, READ_SIZE);

This really only tests that you receive one event and that EPOLLET is
not trivially broken.

I'm not sure what the reads and writes are for.

If you want to make a really trivial test, then don't confuse it with
random operations that don't have an obvious impact.

> +
> +	TST_EXP_EQ_LI(epoll_wait(epfd, &evt_receive, 1, 10), 0);
> +
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
