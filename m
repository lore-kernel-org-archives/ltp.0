Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDB5C433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:11:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 948803CB175
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:11:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 437943CB13E
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:11:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8E51E10009E2
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:11:19 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BA8FE1F8D9;
 Thu, 20 Oct 2022 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666260678;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=he3S/xWa8TTkoTB7VYMqrmdGifv2MkqcOE6gW17ofkM=;
 b=GKITWxzPv2bOmmnza3xe2rCItGcjHhG1lop/K7HwWo6shZ7hJiMQ929+09lOIr/Igtgrqn
 AUV1gckymwN3H9hgqsnjzwaCGlIh/O9XCDX6t/oHaRdqC8otv7je2F8Kl3VbMe38t/0A0I
 4myVvkpIClPNlsT6WnUtnm7w3OglGGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666260678;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=he3S/xWa8TTkoTB7VYMqrmdGifv2MkqcOE6gW17ofkM=;
 b=we0/EM/tHKlyOazDaPHOCFeUdGvswsBggizPhhImnVYMRfdUF3ZplEc+y5V+j2RaOd+gOx
 /BJblcb8NJ3UmODw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1EEEF2C141;
 Thu, 20 Oct 2022 10:11:17 +0000 (UTC)
References: <20221010145243.3133-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Thu, 20 Oct 2022 10:27:02 +0100
In-reply-to: <20221010145243.3133-1-andrea.cervesato@suse.com>
Message-ID: <87h6zyvm7w.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add epoll_wait07 test
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
>  .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait07.c | 86 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
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
> index 000000000..760ab6c10
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that EPOLLONESHOT is correctly handled by epoll_wait.
> + * We open a channel, write on it multiple times and we verify that EPOLLOUT
> + * has been received only once.

Without EPOLLONESHOT or EPOLLET, EPOLLOUT will fire constantly on a pipe
who's buffer is not full. Writing to it will have no effect unless you
listen on the other end for EPOLLIN.

So in this test you don't need to write to the pipe unless I am
mistaken.

> + */
> +
> +#include <poll.h>
> +#include <sys/epoll.h>
> +#include "tst_test.h"
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
> +	int res;
> +	char buff[WRITE_SIZE];
> +	struct epoll_event evt_receive;
> +	struct epoll_event evt_request;
> +
> +	SAFE_PIPE(fds);
> +
> +	evt_request.events = EPOLLOUT | EPOLLONESHOT;
> +	evt_request.data.fd = fds[1];
> +
> +	epfd = epoll_create(2);
> +	if (epfd == -1)
> +		tst_brk(TBROK | TERRNO, "fail to create epoll
> instance");

Same as other test, please use the SAFE_EPOLL_* functions I just merged.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
