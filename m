Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54936EE4993
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 09:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 282693CC65A
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 11:02:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EA6A3C98FC
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 11:02:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6BC0A1A00617
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 11:02:01 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DD5021F8A6;
 Wed, 23 Aug 2023 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692781320;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZ0k0awrumeiQU6RnyMZTCZAf6CZqZUM1CGJ7ciayEY=;
 b=2LJDx24O95oxcuapnx4jmJWLyIFVgtcBjaAYw9UmrNoN61M3UYJo2EJj8Jkkk8NTc+5O1p
 Ge/1aQ/Rw1nyyLwIrQ64gIcEQ6WkA9T7PWOtpPJerLYNZPCmIYp+ckoPfru5qmyiJrU+TH
 Pwx9TkaB+05Jho91D3u7We8Uu+N0hWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692781320;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZ0k0awrumeiQU6RnyMZTCZAf6CZqZUM1CGJ7ciayEY=;
 b=C9gWZLvdUa37aEmTT9rJDaZaG9L7jsu9zunIcGjukQfNeQu6NNYiL8/5w8IWK9gA9t6OZQ
 hQ23d42Xmqe/7fBA==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 21F102C142;
 Wed, 23 Aug 2023 09:01:59 +0000 (UTC)
References: <20230315150330.2964-1-andrea.cervesato@suse.de>
 <20230721154512.GA1445478@pevik>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Aug 2023 09:40:23 +0100
Organization: Linux Private Site
In-reply-to: <20230721154512.GA1445478@pevik>
Message-ID: <871qfuw2re.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Andrea,
>
>> This test verifies that epoll receives EPOLLRDHUP event when we hang
>> a reading half-socket we are polling on.
>
> Commit message would deserver
>
> Implements: https://github.com/linux-test-project/ltp/issues/860
> (Although the ticket asks to cover more flags than just EPOLLET).
>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>  .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
>>  .../kernel/syscalls/epoll_wait/epoll_wait05.c | 117 ++++++++++++++++++
> Test is missing a record in runtest/syscalls.
>
>>  2 files changed, 118 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
>
>> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
>> index 222955dd2..ab5a9c010 100644
>> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
>> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
>> @@ -2,3 +2,4 @@ epoll_wait01
>>  epoll_wait02
>>  epoll_wait03
>>  epoll_wait04
>> +epoll_wait05
>> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
>> new file mode 100644
>> index 000000000..e43cac933
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that epoll receives EPOLLRDHUP event when we hang a reading
>> + * half-socket we are polling on.
>
> I'd put here the LWN article:
> https://lwn.net/Articles/864947/
>> + */
>> +
>> +#define _GNU_SOURCE
> Why is _GNU_SOURCE needed?
>
>> +#include "tst_test.h"
>> +#include "tst_epoll.h"
>> +
>> +static int epfd;
>> +static in_port_t *sock_port;
>> +
>> +static void create_server(void)
>> +{
>> +	int sockfd;
>> +	socklen_t len;
>> +	struct sockaddr_in serv_addr;
>> +	struct sockaddr_in sin;
>> +
>> +	memset(&serv_addr, 0, sizeof(struct sockaddr_in));
>> +	serv_addr.sin_family = AF_INET;
>> +	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
>> +	serv_addr.sin_port = 0;
> You could use tst_init_sockaddr_inet_bin() (include include "tst_net.h").
>> +
>> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
>> +	SAFE_BIND(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
>> +	SAFE_LISTEN(sockfd, 10);
>> +
>> +	len = sizeof(sin);
>> +	memset(&sin, 0, sizeof(struct sockaddr_in));
>> +	SAFE_GETSOCKNAME(sockfd, (struct sockaddr *)&sin, &len);
>> +
>> +	*sock_port = sin.sin_port;
>> +
>> +	tst_res(TINFO, "Listening on port %d", *sock_port);
>> +
>> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>> +
>> +	SAFE_CLOSE(sockfd);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int sockfd;
>> +	struct sockaddr_in client_addr;
>> +	struct epoll_event evt_req;
>> +	struct epoll_event evt_rec;
>> +
>> +	if (!SAFE_FORK()) {
>> +		create_server();
>> +		return;
>> +	}
>> +
>> +	TST_CHECKPOINT_WAIT(0);
>> +
>> +	tst_res(TINFO, "Connecting to port %d", *sock_port);
>> +
>> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
>> +
>> +	memset(&client_addr, 0, sizeof(struct sockaddr));
>> +	client_addr.sin_family = AF_INET;
>> +	client_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
>> +	client_addr.sin_port = *sock_port;
> And here as well.
>
>> +
>> +	SAFE_CONNECT(sockfd, (struct sockaddr *)&client_addr, sizeof(client_addr));
>> +
>> +	tst_res(TINFO, "Polling on socket");
>> +
>> +	epfd = SAFE_EPOLL_CREATE1(0);
>> +	evt_req.events = EPOLLRDHUP;
>> +	SAFE_EPOLL_CTL(epfd, EPOLL_CTL_ADD, sockfd, &evt_req);
>> +
>> +	tst_res(TINFO, "Hang socket");
>> +
>> +	TST_EXP_PASS_SILENT(shutdown(sockfd, SHUT_RD));
>> +	SAFE_EPOLL_WAIT(epfd, &evt_rec, 1, 2000);
>> +
>> +	if (evt_rec.events & EPOLLRDHUP)
>> +		tst_res(TPASS, "Received EPOLLRDHUP");
>> +	else
>> +		tst_res(TFAIL, "EPOLLRDHUP has not been received");
>> +
>> +	SAFE_CLOSE(epfd);
>> +	SAFE_CLOSE(sockfd);
> In extreme case when SAFE_EPOLL_WAIT() fails sockfd will not get closed, right?
> This could be problem on high number of iterations. But I guess it's just a
> theoretical problem.

Let's just assume it is a problem because it is easy to add the cleanup
code.

Something to think about is that regardless of test iterations, the
kernel may behave differently when cleaning up a socket on process
termination rather than a deliberate close. For e.g. it could do a bulk
cleanup after some delay, so you may get errors happening as the next
test executes.

Of course that can happen with a deliberate close as well, but you are
bringing the close forward at least. Also it makes the behaviour of the
test after an error more similar to if there were not an error. So
comparing the output may be easier.

>
>> +
>> +	TST_CHECKPOINT_WAKE(0);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	sock_port = SAFE_MMAP(NULL, sizeof(in_port_t), PROT_READ | PROT_WRITE,
>> +		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (sock_port)
>> +		SAFE_MUNMAP(sock_port, sizeof(in_port_t));
>> +
>> +	if (epfd > 0)
>> +		SAFE_CLOSE(epfd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +	.forks_child = 1,
>> +	.needs_checkpoints = 1,
> IMHO there should be 3a34b13a88ca commit marked in tags:
>
> .tags = (const struct tst_tag[]) {
>         {"linux-git", "3a34b13a88ca"},
>         {}
>
> The rest LGTM.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> +};

I'll set this to changes requested in patchwork

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
