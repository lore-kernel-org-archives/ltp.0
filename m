Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9054C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 15:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8997A3C9EE0
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:02:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D6CC3C9E0D
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:02:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7315D600F74
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:02:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB4E41F399;
 Thu, 10 Feb 2022 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644505321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2i5+eVU4h7Q7ttcNhbaEYvp+k3/Zwy0ly2uqx3RXKE4=;
 b=I9ZGHmm2i3FJCswXgjvpG+psfXtVJbxc5jSTh6t3WzEZxkvNYLwTJoQgiYdo+0tlYGKCYq
 Vv6mfNKCgBCsoAye3frejyFJeyeTY/J71PiThtvfy6/afz0xItSzIbcrLTQWo5bAZCYUhp
 NpsyYvgcvq0/E6j38OgN1vleu48FnL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644505321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2i5+eVU4h7Q7ttcNhbaEYvp+k3/Zwy0ly2uqx3RXKE4=;
 b=LlEWS8AGWKdUg2daUq6Bop36ZEghgT9hoiKTotGgPb/aPodS0N7NoAWZV5Y4U12uCE6imY
 HpFZbrcoi4dJ9nBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8201E13B8D;
 Thu, 10 Feb 2022 15:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fWuQGukoBWL+BAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Feb 2022 15:02:01 +0000
Date: Thu, 10 Feb 2022 16:04:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YgUpZ6lvI3WzL4cM@yuki>
References: <YgPNWHc+xwKCRcvv@pevik>
 <1644464477-16644-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1644464477-16644-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1644464477-16644-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/pidfd_open04: Add new test with
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
> +#include <stdlib.h>
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
> +	int flag, pid, pidfd, ret;
> +	siginfo_t info;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		TST_CHECKPOINT_WAIT(0);
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	TST_EXP_FD_SILENT(pidfd_open(pid, PIDFD_NONBLOCK),
> +				"pidfd_open(%d,  PIDFD_NONBLOCK)", pid);
> +
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
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	ret = TST_RETRY_FUNC(waitid(P_PIDFD, pidfd, &info, WEXITED), TST_RETVAL_EQ0);
> +	if (ret == 0) {
> +		tst_res(TPASS, "waitid(P_PIDFD) succeeded after child process terminated");
> +	} else {
> +		tst_res(TFAIL, "waitid(P_PIDFD) failed after child process terminated");
> +		SAFE_WAIT(NULL);
> +	}
> +
> +	SAFE_CLOSE(pidfd);
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

I guess that we should do SAFE_CLOSE(TST_RET); here. Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.setup = setup,
> +	.test_all = run,
> +};
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
