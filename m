Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0741AC433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 10:19:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 256763C9504
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 12:19:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0DE63C217F
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 12:19:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D35E11400759
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 12:19:05 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id EE63F1F460;
 Tue, 14 Jun 2022 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655201944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYeyLCpesYaEry5Qu54liaplVniDQPV1DVLPDaCNvIs=;
 b=WED7Je3Bn+SqLSaDETbVTFG5yjCovnpG9lRjWJEgwZLOejT4dsIzmL/78lgDV4m2XrZkrd
 iQt24YoQ8wC07RB7fZr8adTibJlH7WhoE/1cRJ47XVQMq/bLXfsdm577dxfojHh5fhqXiC
 VKK3LuPnh+ojPuV6riBhmSIpu5m40GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655201944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYeyLCpesYaEry5Qu54liaplVniDQPV1DVLPDaCNvIs=;
 b=tPtijHjdEX7+RanyHC81R4OkL7kw9N5W3+EFXjBTlNChgo5Us3Alv0/Kb9O1zwfDnYJjP4
 swBb3CJvhehYsJDw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D4DD72C141;
 Tue, 14 Jun 2022 10:19:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 92D1AA062E; Tue, 14 Jun 2022 12:19:04 +0200 (CEST)
Date: Tue, 14 Jun 2022 12:19:04 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220614101904.tgvigmckvvaxtcpa@quack3.lan>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613143826.1328830-2-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] syscalls/inotify12: Introduce test for
 inotify mask flags
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 13-06-22 17:38:22, Amir Goldstein wrote:
> Test behavior of IN_ONESHOT and IN_EXCL_UNLINK.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me after fixing those small bugs you've found. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
>  testcases/kernel/syscalls/inotify/inotify12.c | 168 ++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/inotify/inotify12.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3b26d19e6..1259e41f1 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -588,6 +588,7 @@ inotify08 inotify08
>  inotify09 inotify09
>  inotify10 inotify10
>  inotify11 inotify11
> +inotify12 inotify12
>  
>  fanotify01 fanotify01
>  fanotify02 fanotify02
> diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
> index 593cf6c04..f6e5c546a 100644
> --- a/testcases/kernel/syscalls/inotify/.gitignore
> +++ b/testcases/kernel/syscalls/inotify/.gitignore
> @@ -9,3 +9,4 @@
>  /inotify09
>  /inotify10
>  /inotify11
> +/inotify12
> diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
> new file mode 100644
> index 000000000..fe72771c5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify12.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 CTERA Networks. All Rights Reserved.
> + *
> + * Author: Amir Goldstein <amir73il@gmail.com>
> + */
> +
> +/*\
> + * [Description]
> + * Test special inotify mask flags.
> + *
> + * Regression test for kernel commit a32e697cda27:
> + *
> + *     inotify: show inotify mask flags in proc fdinfo
> + */
> +
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <sys/wait.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "inotify.h"
> +
> +#if defined(HAVE_SYS_INOTIFY_H)
> +#include <sys/inotify.h>
> +
> +#define EVENT_MAX 32
> +/* Size of the event structure, not including the name */
> +#define EVENT_SIZE	(sizeof(struct inotify_event))
> +#define EVENT_BUF_LEN	(EVENT_MAX * (EVENT_SIZE + 16))
> +
> +#define	TEST_FILE	"test_file"
> +
> +static char event_buf[EVENT_BUF_LEN];
> +
> +static struct tcase {
> +	const char *tname;
> +	unsigned int mask;
> +	int expect_events;
> +} tcases[] = {
> +	{
> +		"Watch for multi events",
> +		IN_MODIFY,
> +		2,
> +	},
> +	{
> +		"Watch for single event",
> +		IN_MODIFY | IN_ONESHOT,
> +		1,
> +	},
> +	{
> +		"Watch for events on linked file",
> +		IN_MODIFY | IN_EXCL_UNLINK,
> +		1,
> +	},
> +};
> +
> +int fd_notify;
> +
> +static void verify_inotify(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int fd, len;
> +	unsigned int tmpmask;
> +	char procfdinfo[100];
> +	struct inotify_event *event = (struct inotify_event *)event_buf;
> +
> +	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> +
> +	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
> +
> +	SAFE_FILE_PRINTF(TEST_FILE, "1");
> +
> +	SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", tc->mask);
> +
> +	sprintf(procfdinfo, "/proc/%d/fdinfo/%d", (int)getpid(), fd_notify);
> +	if (FILE_LINES_SCANF(procfdinfo, "inotify wd:%*d ino:%*x sdev:%*x mask:%x",
> +			     &tmpmask)) {
> +		tst_res(TFAIL, "Could not parse inotify fdinfo");
> +	} else if (tmpmask != tc->mask) {
> +		tst_res(TFAIL, "Incorrect mask %x in inotify fdinfo (expected %x)",
> +			tmpmask, tc->mask);
> +	} else {
> +		tst_res(TPASS, "Correct mask in inotify fdinfo");
> +	}
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR);
> +	SAFE_WRITE(1, fd, "2", 1);
> +
> +	/*
> +	 * Read the 1st IN_MODIFY event
> +	 */
> +	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
> +
> +	if (len < (int)sizeof(*event)) {
> +		tst_res(TFAIL, "Got no events");
> +	} else if (event->mask == IN_MODIFY) {
> +		tst_res(TPASS, "Got 1st event as expected");
> +	} else {
> +		tst_res(TFAIL, "Got event 0x%x (expected 0x%x)",
> +				event->mask, IN_MODIFY);
> +	}
> +
> +	/*
> +	 * Unlink file so IN_EXCL_UNLINK won't get IN_ACCESS event.
> +	 * IN_ONESHOT won't get IN_ACCESS event because IN_MODIFY
> +	 * was already generated.
> +	 */
> +	SAFE_UNLINK(TEST_FILE);
> +	SAFE_WRITE(1, fd, "3", 1);
> +	SAFE_CLOSE(fd);
> +
> +	/*
> +	 * Possibly read the 2nd IN_MODIFY event
> +	 */
> +	errno = 0;
> +	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
> +	SAFE_CLOSE(fd_notify);
> +	if (len < 0 && errno == EAGAIN) {
> +		/* Treat no event same as we treat IN_IGNORED */
> +		event->mask = IN_IGNORED;
> +	} else if (len < (int)sizeof(*event)) {
> +		tst_res(TFAIL | TERRNO, "Failed to read events");
> +		return;
> +	}
> +
> +	if (event->mask == IN_MODIFY) {
> +		if (tc->expect_events > 1)
> +			tst_res(TPASS, "Got 2nd event as expected");
> +		else
> +			tst_res(TFAIL, "Got unexpected 2nd event");
> +	} else if (event->mask == IN_IGNORED) {
> +		if (tc->expect_events == 1)
> +			tst_res(TPASS, "Got no more events as expected");
> +		else
> +			tst_res(TFAIL, "Got only one event (expected %d)",
> +					tc->expect_events);
> +	} else {
> +		tst_res(TFAIL, "Got unexpected event 0x%x",
> +				event->mask);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_notify > 0)
> +		SAFE_CLOSE(fd_notify);
> +}
> +
> +static struct tst_test test = {
> +	.timeout = 10,
> +	.needs_tmpdir = 1,
> +	.cleanup = cleanup,
> +	.test = verify_inotify,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "a32e697cda27"},
> +		{}
> +};
> +
> +#else
> +	TST_TEST_TCONF("system doesn't have required inotify support");
> +#endif
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
