Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C77C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 14:04:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 116AF3CCB18
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 15:04:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE2023C06C8
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 15:04:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C7906600F04
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 15:04:21 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 318781F85D;
 Tue, 22 Nov 2022 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669125861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aEqV5AK0ItFraNnVf4Qewq/XxHCWMvP6aqjivymzixo=;
 b=X+2Q6YlKl6BR8USCBnBq2zu9Sre6A1hgb5/aNGxGk0t4evCQ9XZPlQPrv1Q1RbNndnEjTO
 BbFLVI09YILCWeayt/t5q7IW53bcqTVq5ShExIKr92PqzYAsdGqsEqPz54HtHkzwBDspmn
 FHkJxQWnCwoFAIOdoPuBnhXwF5eUL0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669125861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aEqV5AK0ItFraNnVf4Qewq/XxHCWMvP6aqjivymzixo=;
 b=x/O108WAeQN9CQB4i5ujtzM/5uIDPi1pTAuuonw+hgBQVQ/ilOZ3tfoXK6kW+bkVyh9DU6
 UG4lQG6V7OGP00BA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0A34B2C142;
 Tue, 22 Nov 2022 14:04:20 +0000 (UTC)
References: <20221028085735.32615-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 22 Nov 2022 13:26:12 +0000
Organization: Linux Private Site
In-reply-to: <20221028085735.32615-1-andrea.cervesato@suse.com>
Message-ID: <87wn7ndr1c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add epoll_wait05 test
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

> This test verifies that epoll receives EPOLLHUP/EPOLLRDHUP event
> when we hang a reading half-socket we are polling on.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Make use of SAFE_EPOLL_* macros
>
>  .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait05.c | 72 +++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
>
> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
> index 222955dd2..ab5a9c010 100644
> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
> @@ -2,3 +2,4 @@ epoll_wait01
>  epoll_wait02
>  epoll_wait03
>  epoll_wait04
> +epoll_wait05
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
> new file mode 100644
> index 000000000..2ed0b2ab1
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that epoll receives EPOLLHUP/EPOLLRDHUP event when we hang a reading
> + * half-socket we are polling on.
> + */
> +
> +#include <poll.h>
> +#include <sys/epoll.h>
> +#include "tst_test.h"
> +#include "tst_epoll.h"
> +
> +static int sockfd;
> +static int epfd;
> +
> +static void cleanup(void)
> +{
> +	if (epfd > 0)
> +		SAFE_CLOSE(epfd);
> +
> +	if (sockfd > 0)
> +		SAFE_CLOSE(sockfd);
> +}
> +
> +static void run(void)
> +{
> +	int ret;
> +	struct epoll_event evt_req;
> +	struct epoll_event evt_rec;
> +
> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +	epfd = SAFE_EPOLL_CREATE1(0);
> +
> +	tst_res(TINFO, "Polling on socket");
> +
> +	evt_req.events = EPOLLRDHUP;
> +	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, sockfd, &evt_req);
> +
> +	tst_res(TINFO, "Hang reading half-socket");

So far a TCP socket has been created, but nothing else. No connect,
bind, listen or accept calls.

> +
> +	ret = shutdown(sockfd, SHUT_RD);
> +	if (ret == -1 && errno != ENOTCONN) {
> +		tst_brk(TBROK | TERRNO, "shutdown error");
> +		goto close;

tst_brk won't return in this case.

> +	}
> +
> +	SAFE_EPOLL_WAIT(epfd, &evt_rec, 1, 2000);
> +
> +	if (evt_rec.events & EPOLLHUP)
> +		tst_res(TPASS, "Received EPOLLHUP");
> +	else
> +		tst_res(TFAIL, "EPOLLHUP has not been received");

Why is this a fail?

The socket is not connected and shutdown returns ENOTCONN. Whether
shutdown has any effect in this case appears to be undefined.

Possibly you could use UDP instead (SOCK_DGRAM). In this case the socket
does not need to be connected to send or receive packets and you
shouldn't get ENOTCONN.

> +
> +	if (evt_rec.events & EPOLLRDHUP)
> +		tst_res(TPASS, "Received EPOLLRDHUP");
> +	else
> +		tst_res(TFAIL, "EPOLLRDHUP has not been received");

Same

> +
> +close:
> +	SAFE_CLOSE(epfd);
> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.forks_child = 1,

No it doesn't



> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
