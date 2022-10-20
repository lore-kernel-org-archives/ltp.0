Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D47AC4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:54:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E75E13CB167
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:53:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10EF83C9179
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:53:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4DC9520021D
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:53:46 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 628D71FB21;
 Thu, 20 Oct 2022 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666263226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aPKlBXZA5OjyVuyJlvCPl45ZnN+RNVU4Neal3UO/3S4=;
 b=PpAnfHTcCwVGtUbi8p+4avazDSWmqhYBjU1nXrm+ZbWQsj9YCnky3qm4dPAFHvuMKGTJX/
 N9GuSxSsijZ91E0y/qI3y7vGDjIHn/SILPeCMc2F4dLS7nzyHn75hGUSKxajmVZ2ND9A8i
 ALO0T+BS1s/oar5di2Wa6zBAvFDXxYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666263226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aPKlBXZA5OjyVuyJlvCPl45ZnN+RNVU4Neal3UO/3S4=;
 b=gJR/OxdraK0J8KMu7ny+FnyyXkNJadOsol7JbOvebF/SP4KTc1jpzg+rpS5tJYDVoV+Rro
 LL/xhyPUQMA91uCQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 590542C141;
 Thu, 20 Oct 2022 10:53:45 +0000 (UTC)
References: <20221010145534.4857-1-andrea.cervesato@suse.com>
 <Y0bwCz3wCdo9dY2g@yuki>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Oct 2022 11:44:06 +0100
In-reply-to: <Y0bwCz3wCdo9dY2g@yuki>
Message-ID: <878rlavk94.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add epoll_wait06 test
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> This test verifies EPOLLET functionality.
>> 
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>  .../kernel/syscalls/epoll_wait/.gitignore     |  1 +
>>  .../kernel/syscalls/epoll_wait/epoll_wait06.c | 97 +++++++++++++++++++
>>  2 files changed, 98 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
>> 
>> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
>> index ab5a9c010..8c5ed7c5c 100644
>> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
>> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
>> @@ -3,3 +3,4 @@ epoll_wait02
>>  epoll_wait03
>>  epoll_wait04
>>  epoll_wait05
>> +epoll_wait06
>> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
>> new file mode 100644
>> index 000000000..20f6233c9
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that edge triggered behavior is correctly handled by epoll.
>> + *
>> + * [Algorithm]
>> + *
>> + * 1. The file descriptor that represents the read side of a pipe (rfd) is
>> + *    registered on the epoll instance.
>> + * 2. A pipe writer writes 2 kB of data on the write side of the pipe.
>> + * 3. A call to epoll_wait(2) is done that will return rfd as a ready file
>> + *    descriptor.
>> + * 4. The pipe reader reads 1 kB of data from rfd.
>> + * 5. A call to epoll_wait(2) should fail because there's data left to read.
>> + */
>
> I do not like this description that much. First of all the the flag we
> are testing is not mentioned there at all, the EPOLLET should be
> mentioned in the [Description].
>
> The second call to epoll_wait() does not fail, failure for syscall means
> that -1 is returned and errno is set. It does not report any data ready
> on the file descriptor, that is not failure at all, that is how the
> EPOLLET flag is supposed to work.

I'll add to this that testing EPOLLET makes most sense with EPOLLOUT
first. Usually it is used to detect when writing becomes possible again
after a transport becomes full. Without it then epoll_wait would
instantly return whenever writing is possible which is most of the
time.

>
>> +#include <poll.h>
>> +#include <sys/epoll.h>
>> +#include "tst_test.h"
>> +
>> +#define WRITE_SIZE 2048
>> +#define READ_SIZE (WRITE_SIZE / 2)
>> +
>> +static int fds[2];
>> +static int epfd;
>> +
>> +static void cleanup(void)
>> +{
>> +	if (epfd > 0)
>> +		SAFE_CLOSE(epfd);
>> +
>> +	if (fds[0] > 0)
>> +		SAFE_CLOSE(fds[0]);
>> +
>> +	if (fds[1] > 0)
>> +		SAFE_CLOSE(fds[1]);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int res;
>> +	char buff[WRITE_SIZE];
>> +	struct epoll_event evt_receive;
>> +	struct epoll_event evt_request;
>> +
>> +	SAFE_PIPE(fds);
>> +
>> +	evt_request.events = EPOLLIN | EPOLLET;
>> +	evt_request.data.fd = fds[0];
>> +
>> +	epfd = epoll_create(2);

Also again, please use the SAFE_* macros I just merged.

>> +	if (epfd == -1)
>> +		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
>> +
>> +	tst_res(TINFO, "Polling channel with EPOLLET");
>> +
>> +	res = epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &evt_request);
>> +	if (res == -1)
>> +		tst_brk(TBROK | TERRNO, "epoll_ctl failure");
>> +
>> +	tst_res(TINFO, "Write bytes on channel");
>> +
>> +	memset(buff, 'a', WRITE_SIZE);
>> +	SAFE_WRITE(0, fds[1], buff, WRITE_SIZE);
>> +
>> +	res = epoll_wait(epfd, &evt_receive, 1, 2000);
>> +	if (res <= 0) {
>> +		tst_res(TFAIL | TERRNO, "epoll_wait() returned %i", res);
>> +		goto close;
>> +	}
>> +
>> +	if ((evt_receive.events & EPOLLIN) == 0) {
>> +		tst_res(TFAIL, "No data received");
>> +		goto close;
>> +	}
>> +
>> +	tst_res(TINFO, "Received EPOLLIN event. Read half bytes from channel");
>> +
>> +	memset(buff, 0, READ_SIZE);
>> +	SAFE_READ(1, evt_receive.data.fd, buff, READ_SIZE);
>> +
>> +	TST_EXP_EQ_LI(epoll_wait(epfd, &evt_receive, 1, 10), 0);
>> +
>> +close:
>
> 	SAFE_CLOSE(epfd) ?
>
>> +	SAFE_CLOSE(fds[0]);
>> +	SAFE_CLOSE(fds[1]);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +};
>> -- 
>> 2.35.3
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
