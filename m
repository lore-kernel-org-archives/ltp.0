Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF35C4332F
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 13:48:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ABEC3C6322
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 14:48:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E26273C06B2
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 14:47:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 80D231A01146
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 14:47:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CCC461F383;
 Wed,  9 Feb 2022 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644414473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=notfj9WTeXhtDIp5cJAKjbTGw8iF3KJOUqa3b1ZCLe0=;
 b=20znwH3NnQDb/xBCpKlwDdMp/FgheuIcHS3Vnx7/J3vj2a9+LlDc5gGnw5RdGKohloNqnu
 8CW0pJjxtNGJkwAKw7HUhL7BhuHdj5yV5cnDWDygpQ0yLA1owgWdaKeAkTd5ahoRv/81tE
 VyBMnDvDQdz2nwbx/Gl32Ew3SGJYThM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644414473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=notfj9WTeXhtDIp5cJAKjbTGw8iF3KJOUqa3b1ZCLe0=;
 b=YkMQpuXFRXJ8NgQcNEGNMOyAbr2ihcCEPsYE8sIpiTj4xjsywsOOBHZnAUe8S9LENRYC9o
 OtMo26I6TiwIoXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B576213D45;
 Wed,  9 Feb 2022 13:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4V3YKgnGA2IOUwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Feb 2022 13:47:53 +0000
Date: Wed, 9 Feb 2022 14:47:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YgPGA4oTD65hw69t@rei>
References: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1644399738-2155-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1644399738-2155-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/pidfd_open04: Add new test with
 PIDFD_NONBLOCK flag
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
> new file mode 100644
> index 000000000..436351f23
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that the PIDFD_NONBLOCK flag works with pidfd_open() and
> + * that waitid() with a non-blocking pidfd returns EAGAIN.
> + */
> +
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +#include "lapi/pidfd_open.h"
> +
> +#ifndef PIDFD_NONBLOCK
> +#define PIDFD_NONBLOCK O_NONBLOCK
> +#endif
> +
> +#ifndef P_PIDFD
> +#define P_PIDFD  3
> +#endif
> +
> +static void run(void)
> +{
> +	int flag, pid, pidfd;
> +	siginfo_t info;
> +
> +	pid = SAFE_FORK();
> +	if (!pid)
> +		pause();
> +
> +	TST_EXP_PID_SILENT(pidfd_open(pid, PIDFD_NONBLOCK),
> +				"pidfd_open(%d,  PIDFD_NONBLOCK)", pid);

Here as well FD_SILENT();

> +	pidfd = TST_RET;
> +	flag = fcntl(pidfd, F_GETFL);
> +	if (flag == -1)
> +		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFL) failed");
> +
> +	if (!(flag & O_NONBLOCK))
> +		tst_brk(TFAIL, "pidfd_open(%d, O_NONBLOCK) didn't set O_NONBLOCK flag", pid);
> +
> +	tst_res(TPASS, "pidfd_open(%d, O_NONBLOCK) sets O_NONBLOCK flag", pid);
> +
> +	TST_EXP_FAIL(waitid(P_PIDFD, pidfd, &info, WEXITED), EAGAIN,
> +			"waitid(P_PIDFD,...,WEXITED)");
> +
> +	SAFE_KILL(pid, SIGTERM);
> +	SAFE_WAIT(NULL);
> +	SAFE_CLOSE(pidfd);

I guess that we can also test that the waitid() succeds now, right?

> +}
> +
> +static void setup(void)
> +{
> +	pidfd_open_supported();
> +
> +	TEST(pidfd_open(getpid(), PIDFD_NONBLOCK));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EINVAL) {
> +			tst_brk(TCONF, "PIDFD_NONBLOCK was supported since linux 5.10");
> +			return;
> +		}
> +		tst_brk(TFAIL | TTERRNO,
> +			"pidfd_open(getpid(),PIDFD_NONBLOCK) failed unexpectedly");
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.test_all = run,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
