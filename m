Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B303FC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 09:15:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 398F93CB194
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 11:15:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A264C3C9179
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 11:15:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F869600824
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 11:15:39 +0200 (CEST)
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id BFB8922C1E;
 Thu, 20 Oct 2022 09:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666257338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bItJ8neImMECJA1zVnf7YKbcLaam0BW1zsHT1dCp/BM=;
 b=Hp2z+ArAuzAiKmEg26fW3Ger4Iuf5QroxbaCw7XIHsTKR6ClF6mhLRFB3XwHHynmu6Bn2P
 L9FM8qc9tGDIylQgLK81SSbPYAIySGk2vXffC7YBENaVQ99XhwEivG2h5HKI7EKoCkjfxU
 +9M8hRPm2t3CWBnHqoUZWdNiArD9VGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666257338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bItJ8neImMECJA1zVnf7YKbcLaam0BW1zsHT1dCp/BM=;
 b=75EXN1ZSkdQFdwEWvByTtMapsp42Y6x3Y1/bdgYoBKvXj5HGNFjLdF0FVdEQaieNBSr+2c
 6b9ZnXA1LK9HYvCg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay1.suse.de (Postfix) with ESMTPS id 2776925CB0;
 Thu, 20 Oct 2022 09:15:38 +0000 (UTC)
References: <20221010101857.14585-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Thu, 20 Oct 2022 10:10:36 +0100
In-reply-to: <20221010101857.14585-1-andrea.cervesato@suse.com>
Message-ID: <87sfjivoso.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add epoll_wait05 test
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
>  .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait05.c | 74 +++++++++++++++++++
>  2 files changed, 75 insertions(+)
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
> index 000000000..7909a6586
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
> @@ -0,0 +1,74 @@
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
> +	int res;
> +	struct epoll_event evt_req;
> +	struct epoll_event evt_rec;
> +
> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +
> +	epfd = epoll_create1(0);

I added safe epoll functions in an unmerged patch-set; see:
https://patchwork.ozlabs.org/project/ltp/patch/20220927161408.23743-2-rpalethorpe@suse.com/

I will merge that so you can use it here.

> +	if (epfd == -1)
> +		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
> +
> +	tst_res(TINFO, "Polling on socket");
> +
> +	evt_req.events = EPOLLRDHUP;
> +	res = epoll_ctl(epfd, EPOLL_CTL_ADD, sockfd, &evt_req);
> +	if (res == -1)
> +		tst_brk(TBROK | TERRNO, "epoll_ctl failure");
> +
> +	tst_res(TINFO, "Hang reading half-socket");
> +	shutdown(sockfd, SHUT_RD);

We should check the return value. It will help with debugging if the
test fails.

> +
> +	res = epoll_wait(epfd, &evt_rec, 1, 2000);
> +	if (res <= 0) {
> +		tst_res(TFAIL | TERRNO, "epoll_wait() returned %i", res);
> +		return;
> +	}
> +
> +	if (evt_rec.events & EPOLLHUP)
> +		tst_res(TPASS, "Received EPOLLHUP");
> +	else
> +		tst_res(TFAIL, "EPOLLHUP has not been received");
> +
> +	if (evt_rec.events & EPOLLRDHUP)
> +		tst_res(TPASS, "Received EPOLLRDHUP");
> +	else
> +		tst_res(TFAIL, "EPOLLRDHUP has not been received");
> +
> +	SAFE_CLOSE(epfd);
> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.forks_child = 1,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
