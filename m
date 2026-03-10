Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D50FD4F0C
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 17:21:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D26003E6867
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 18:21:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABE623CD52A
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 18:20:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 283C06006D7
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 18:20:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F9F94D284;
 Tue, 10 Mar 2026 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773163253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5xJc6BtDENvtUeUKJWTBQzzv38gmRsJC8Qr8UBSzk5Y=;
 b=FKf2U+1idgxupRqzdCgmzwXzrr2YDSHUm8QEpoEnYH/BKI5FkqqdbrjRG9rzGmjhgpQ9iE
 g6k5ddxDOFM6+DLec1wHdxSJzkcK8wWkEKToiGLxPGYKJnvhyqcd9NJpJeyEsiPaNdPRSd
 Cg3xSeHf9EMiOeeMtahDY2mHuRw3lF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773163253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5xJc6BtDENvtUeUKJWTBQzzv38gmRsJC8Qr8UBSzk5Y=;
 b=0VL+KNqFL7fJVf704YciRAy3vW7JXL033RYsqHEj5m4pyRfkdotgSZyYShVySVZIbNSrJJ
 9eQBeo3ST7HOkuAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773163253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5xJc6BtDENvtUeUKJWTBQzzv38gmRsJC8Qr8UBSzk5Y=;
 b=FKf2U+1idgxupRqzdCgmzwXzrr2YDSHUm8QEpoEnYH/BKI5FkqqdbrjRG9rzGmjhgpQ9iE
 g6k5ddxDOFM6+DLec1wHdxSJzkcK8wWkEKToiGLxPGYKJnvhyqcd9NJpJeyEsiPaNdPRSd
 Cg3xSeHf9EMiOeeMtahDY2mHuRw3lF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773163253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5xJc6BtDENvtUeUKJWTBQzzv38gmRsJC8Qr8UBSzk5Y=;
 b=0VL+KNqFL7fJVf704YciRAy3vW7JXL033RYsqHEj5m4pyRfkdotgSZyYShVySVZIbNSrJJ
 9eQBeo3ST7HOkuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E94933F581;
 Tue, 10 Mar 2026 17:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NmcxNvFSsGmgTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Mar 2026 17:20:49 +0000
Date: Tue, 10 Mar 2026 18:20:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260310172047.GA65487@pevik>
References: <20260225143205.36806-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260225143205.36806-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] poll: fix LTP check warnings and improve poll01
 validation
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

Hi Jinseok,

> Remove extra blank lines, mark helper functions as static, and fix
> documentation comments starting with '/*\'.

> Add explicit checks for poll() return value and validate that no
> unexpected revents bits are set for POLLIN and POLLOUT cases.

FYI we already do check for unexpected revents bits, see below.

> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  testcases/kernel/syscalls/poll/poll01.c | 24 ++++++++++++++++++------
>  testcases/kernel/syscalls/poll/poll02.c |  4 ++--
>  2 files changed, 20 insertions(+), 8 deletions(-)

> diff --git a/testcases/kernel/syscalls/poll/poll01.c b/testcases/kernel/syscalls/poll/poll01.c
> index b05e809ab..ca68ec9c4 100644
> --- a/testcases/kernel/syscalls/poll/poll01.c
> +++ b/testcases/kernel/syscalls/poll/poll01.c
> @@ -5,7 +5,7 @@
>   * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
>   */

> -/*
> +/*\
>   * Check that poll() works for POLLOUT and POLLIN and that revents is set
While you at it, could you please use form
:manpage:`poll(2)`
because that links in our docs [1] into manpage [2].

[1] https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html
[2] https://man7.org/linux/man-pages/man2/poll.2.html

>   * correctly.
>   */
> @@ -34,11 +34,14 @@ static void verify_pollout(void)
>  		return;
>  	}

> -	if (outfds[0].revents != POLLOUT) {
> -		tst_res(TFAIL | TTERRNO, "poll() failed to set POLLOUT");
> +	if (TST_RET != 1) {
> +		tst_res(TFAIL, "Unexpected poll() return value %ld in POLLOUT", TST_RET);
>  		return;
>  	}

Checking for TST_RET != 1 is probably a wanted improvement.

But how about test both with TST_EXP_VAL()?
	TST_EXP_VAL(poll(outfds, 1, -1), 1);
	if (!TST_PASS)
		return;

> +	TST_EXP_EXPR(outfds[0].revents & POLLOUT);
> +	TST_EXP_EXPR((outfds[0].revents & ~POLLOUT) == 0);

This is equivalent of existing code:

	if (outfds[0].revents != POLLOUT) {
		tst_res(TFAIL | TTERRNO, "poll() failed to set POLLOUT");
	}

Maybe the message could be more precise (it also fails if revents contains
POLLOUT and something else, but that might be obvious). Also it could print the
actual revents value (but TST_EXP_EXPR() don't print it either).

I don't have strong opinion which variant is better.

But if you use TST_EXP_EXPR() ...
> +
>  	tst_res(TPASS, "poll() POLLOUT");
... then this TPASS is redundant and misleading - it would be printed also on
the failure because you don't skip it on failure.

>  }

> @@ -60,11 +63,20 @@ static void verify_pollin(void)
>  		goto end;
>  	}

> -	if (infds[0].revents != POLLIN) {
> -		tst_res(TFAIL, "poll() failed to set POLLIN");
> +	if (TST_RET != 1) {
> +		tst_res(TFAIL, "Unexpected poll() return value %ld in POLLIN", TST_RET);
>  		goto end;
>  	}

> +	if (!(infds[0].revents & POLLIN)) {
> +		tst_res(TFAIL, "infds[0].revents & POLLIN");
> +		goto end;
NOTE: you could use TST_EXP_EXPR():

	SAFE_WRITE(SAFE_WRITE_ALL, fildes[1], write_buf, sizeof(write_buf));

	TST_EXP_VAL(poll(infds, 1, -1), 1);
	if (!TST_PASS)
		goto end;

	TST_EXP_EXPR(infds[0].revents & POLLIN);
	TST_EXP_EXPR((infds[0].revents & ~POLLIN) == 0);

end:
	SAFE_READ(1, fildes[0], read_buf, sizeof(write_buf));

Kind regards,
Petr

> +	}
> +
> +	if (!((infds[0].revents & ~POLLIN) == 0)) {
> +		tst_res(TFAIL, "infds[0].revents & ~POLLIN) == 0");
> +		goto end;
> +	}

>  	tst_res(TPASS, "poll() POLLIN");

> @@ -72,7 +84,7 @@ end:
>  	SAFE_READ(1, fildes[0], read_buf, sizeof(write_buf));
>  }

> -void verify_poll(unsigned int n)
> +static void verify_poll(unsigned int n)
>  {
>  	switch (n) {
>  	case 0:
> diff --git a/testcases/kernel/syscalls/poll/poll02.c b/testcases/kernel/syscalls/poll/poll02.c
> index c0665927b..47e323451 100644
> --- a/testcases/kernel/syscalls/poll/poll02.c
> +++ b/testcases/kernel/syscalls/poll/poll02.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
>   */

> -/*
> +/*\
>   * Check that poll() timeouts correctly.
And here please as well:
:manpage:`poll(2)`

>   */
>  #include <errno.h>
> @@ -15,7 +15,7 @@

>  static int fds[2];

> -int sample_fn(int clk_id, long long usec)
> +static int sample_fn(int clk_id, long long usec)
>  {
>  	unsigned int sleep_ms = usec / 1000;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
