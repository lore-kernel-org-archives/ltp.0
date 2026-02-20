Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5195CC55178
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 09:52:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 821593D0842
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 10:52:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 192613D07E9
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 10:51:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B289200994
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 10:51:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A0055BCC7;
 Fri, 20 Feb 2026 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771581098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwWz+x/oh8TRDBmRB0qx3YYU2UqzAQ3oeUtvpeA8LO4=;
 b=KB237mz0kUhOSbWMj+thEQKcw89vdGRRoVszlmriji25z79T9qlOtWAZcZuSMP2cvVdXj0
 j8cFHo5cE4OSWUKX/L/bSzp/u3bX0k/TSb7q5HYUFxMDknaKnlE/ym+hWuuE+TkhBZ99wY
 3AXM+5NpH3leYt+CB1uVc0h5oe19d1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771581098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwWz+x/oh8TRDBmRB0qx3YYU2UqzAQ3oeUtvpeA8LO4=;
 b=ZIrkwujvZzLmm6ermuJFCOfQiMsAIplisCzKQRPKCQgGEnxgRxDuzDqpFsBNQfPSzyBnwJ
 cKYK5otCwl7RCgAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771581098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwWz+x/oh8TRDBmRB0qx3YYU2UqzAQ3oeUtvpeA8LO4=;
 b=KB237mz0kUhOSbWMj+thEQKcw89vdGRRoVszlmriji25z79T9qlOtWAZcZuSMP2cvVdXj0
 j8cFHo5cE4OSWUKX/L/bSzp/u3bX0k/TSb7q5HYUFxMDknaKnlE/ym+hWuuE+TkhBZ99wY
 3AXM+5NpH3leYt+CB1uVc0h5oe19d1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771581098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwWz+x/oh8TRDBmRB0qx3YYU2UqzAQ3oeUtvpeA8LO4=;
 b=ZIrkwujvZzLmm6ermuJFCOfQiMsAIplisCzKQRPKCQgGEnxgRxDuzDqpFsBNQfPSzyBnwJ
 cKYK5otCwl7RCgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 385083EA65;
 Fri, 20 Feb 2026 09:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZgtLDKoumGlRcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Feb 2026 09:51:38 +0000
Date: Fri, 20 Feb 2026 10:51:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <aZguqyEZ_llEF2e6@yuki.lan>
References: <20260219163654.39155-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260219163654.39155-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] poll: add basic POLLHUP semantics test
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
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  testcases/kernel/syscalls/poll/poll03.c | 60 +++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/poll/poll03.c
> 
> diff --git a/testcases/kernel/syscalls/poll/poll03.c b/testcases/kernel/syscalls/poll/poll03.c
> new file mode 100644
> index 000000000..01189eb70
> --- /dev/null
> +++ b/testcases/kernel/syscalls/poll/poll03.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> + */
> +
> +/*

This should be documentation comment which starts with /*\

> + * Check that poll() reports POLLHUP on a pipe read end
> + * after the write end has been closed.
> + */
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/poll.h>
> +
> +#include "tst_test.h"
> +
> +static int fds[2];
> +
> +void verify_pollhup(void)
> +{
> +	struct pollfd pfd = {
> +		.fd = fds[0], .events = POLLIN,
> +	};
> +
> +	SAFE_CLOSE(fds[1]);
> +	fds[1] = -1;

This is not needed, the SAFE_CLOSE() already sets the fd to -1.

> +	TEST(poll(&pfd, 1, -1));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "poll() failed");
> +		return;
> +	}

Here we should also check that we got correct return value. We expect to
get one event so:

	if (TST_RES != 1) {
		tst_res(TFAIL, "Unexpected poll() return value %i", TST_RET);
		return;
	}

> +	if (!(pfd.revents & POLLHUP)) {
> +		tst_res(TFAIL, "poll() did not report POLLHUP");
> +		return;
> +	}

Here as well, if we do not expect other bits set in the revents we
should also check that they are not set, something as:

	TST_EXP_EXPR(pfd.revents & POLLHUP);
	TST_EXP_EXPR((pfd.revents & ~POLLHUP) == 0);

> +	tst_res(TPASS, "poll() reported POLLHUP");
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_PIPE(fds);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fds[0] >= 0)
> +		SAFE_CLOSE(fds[0]);
> +
> +	if (fds[1] >= 0)
> +		SAFE_CLOSE(fds[1]);

These ifs does not work. You either need to initialize the fds to -1 or
check just fds[0] > 0 here. As it is you will close stdin if SAFE_PIPE()
fails.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_pollhup,
> +};
> --
> 2.43.0
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
