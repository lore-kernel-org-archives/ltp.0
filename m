Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA75EB64DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 15:45:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B9A63CDC83
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 17:45:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDD793C916D
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 17:45:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7B816011F0
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 17:45:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0E81F38C;
 Fri, 21 Jul 2023 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689954314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1B7UE+4fQbzrl/bAcSB7i47ij49T1QekB+v5L/T1MY=;
 b=m6Px+eEvzgkfoIT2ioq909TzWwqpwnJkOW5Yuz3P0BCXWkXYjETK5pPwKS7TxfZVKtZlkY
 aRBT5TJictMQaXTnhQ3L+joMhuRF4lTC6gAu3Ymzm6jT4IFOJ+lZxl6ObQd9mnT3SgJKDd
 ylLh5SBf0y73USZywDj8te7BjUvzW8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689954314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1B7UE+4fQbzrl/bAcSB7i47ij49T1QekB+v5L/T1MY=;
 b=ZUVEAaLW7ojcpuiwEnVA9u7LWUsGmpdahBNevkdvgafvlJhIokpvq20BsDBGBRNfeHxdDK
 MhlSNa0IEnNnc6BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0696134B0;
 Fri, 21 Jul 2023 15:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7LY9MQmoumSGMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 15:45:13 +0000
Date: Fri, 21 Jul 2023 17:45:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230721154512.GA1445478@pevik>
References: <20230315150330.2964-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230315150330.2964-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add epoll_wait05 test
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> This test verifies that epoll receives EPOLLRDHUP event when we hang
> a reading half-socket we are polling on.

Commit message would deserver

Implements: https://github.com/linux-test-project/ltp/issues/860
(Although the ticket asks to cover more flags than just EPOLLET).

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait05.c | 117 ++++++++++++++++++
Test is missing a record in runtest/syscalls.

>  2 files changed, 118 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait05.c

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
> index 000000000..e43cac933
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that epoll receives EPOLLRDHUP event when we hang a reading
> + * half-socket we are polling on.

I'd put here the LWN article:
https://lwn.net/Articles/864947/
> + */
> +
> +#define _GNU_SOURCE
Why is _GNU_SOURCE needed?

> +#include "tst_test.h"
> +#include "tst_epoll.h"
> +
> +static int epfd;
> +static in_port_t *sock_port;
> +
> +static void create_server(void)
> +{
> +	int sockfd;
> +	socklen_t len;
> +	struct sockaddr_in serv_addr;
> +	struct sockaddr_in sin;
> +
> +	memset(&serv_addr, 0, sizeof(struct sockaddr_in));
> +	serv_addr.sin_family = AF_INET;
> +	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
> +	serv_addr.sin_port = 0;
You could use tst_init_sockaddr_inet_bin() (include include "tst_net.h").
> +
> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +	SAFE_BIND(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
> +	SAFE_LISTEN(sockfd, 10);
> +
> +	len = sizeof(sin);
> +	memset(&sin, 0, sizeof(struct sockaddr_in));
> +	SAFE_GETSOCKNAME(sockfd, (struct sockaddr *)&sin, &len);
> +
> +	*sock_port = sin.sin_port;
> +
> +	tst_res(TINFO, "Listening on port %d", *sock_port);
> +
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	SAFE_CLOSE(sockfd);
> +}
> +
> +static void run(void)
> +{
> +	int sockfd;
> +	struct sockaddr_in client_addr;
> +	struct epoll_event evt_req;
> +	struct epoll_event evt_rec;
> +
> +	if (!SAFE_FORK()) {
> +		create_server();
> +		return;
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	tst_res(TINFO, "Connecting to port %d", *sock_port);
> +
> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +
> +	memset(&client_addr, 0, sizeof(struct sockaddr));
> +	client_addr.sin_family = AF_INET;
> +	client_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
> +	client_addr.sin_port = *sock_port;
And here as well.

> +
> +	SAFE_CONNECT(sockfd, (struct sockaddr *)&client_addr, sizeof(client_addr));
> +
> +	tst_res(TINFO, "Polling on socket");
> +
> +	epfd = SAFE_EPOLL_CREATE1(0);
> +	evt_req.events = EPOLLRDHUP;
> +	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, sockfd, &evt_req);
> +
> +	tst_res(TINFO, "Hang socket");
> +
> +	TST_EXP_PASS_SILENT(shutdown(sockfd, SHUT_RD));
> +	SAFE_EPOLL_WAIT(epfd, &evt_rec, 1, 2000);
> +
> +	if (evt_rec.events & EPOLLRDHUP)
> +		tst_res(TPASS, "Received EPOLLRDHUP");
> +	else
> +		tst_res(TFAIL, "EPOLLRDHUP has not been received");
> +
> +	SAFE_CLOSE(epfd);
> +	SAFE_CLOSE(sockfd);
In extreme case when SAFE_EPOLL_WAIT() fails sockfd will not get closed, right?
This could be problem on high number of iterations. But I guess it's just a
theoretical problem.

> +
> +	TST_CHECKPOINT_WAKE(0);
> +}
> +
> +static void setup(void)
> +{
> +	sock_port = SAFE_MMAP(NULL, sizeof(in_port_t), PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (sock_port)
> +		SAFE_MUNMAP(sock_port, sizeof(in_port_t));
> +
> +	if (epfd > 0)
> +		SAFE_CLOSE(epfd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
IMHO there should be 3a34b13a88ca commit marked in tags:

.tags = (const struct tst_tag[]) {
        {"linux-git", "3a34b13a88ca"},
        {}

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
