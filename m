Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6464FC5518E
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 10:05:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A54853D07F8
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 11:05:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D0ED3C634E
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 11:05:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76DB2600A5B
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 11:05:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E89833E6D1;
 Fri, 20 Feb 2026 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771581901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ppHxrIev43ElRDRC+qM7aB/zEIBhLbexSTks14S9LwA=;
 b=ofm+eTGl5EnmCnWUyt8KEgaXbOCiurjv/UsZ0Q6oCldudxlWN+8uv0ZkcZETJ7kpotYMbD
 Rp1aJVhzDy9MpjmVmmuFPyTjwnmRwBX8IpEBFr9dJRbwZRaY86LpFnDcOlagkhI9aGGKbD
 B74P2nt+CpgdOwbY6TAfI1rKptdqt9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771581901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ppHxrIev43ElRDRC+qM7aB/zEIBhLbexSTks14S9LwA=;
 b=N3VllFtUTWk8TLErrN1rYRS37GyMHr713fTVWaQgPlbV13MMNmEeQqJiJ8H8E6N3jFP7I9
 uqCtTrJZYJKGUwDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771581900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ppHxrIev43ElRDRC+qM7aB/zEIBhLbexSTks14S9LwA=;
 b=zE/5XOt/NuFHEqKZ+8/e7UtXryreHuUTKk37hIJT0RUvpznN9kMpuPk5gKMdV8569uKYdq
 NcRpUfuubRVjLLtMP7BWu8FR5H5t30EuQY8+FJL3cpkYPo10H7A41M5Q+FQHHDoyNpFonH
 jqHz5Q4Ty58rO7nQG9dCWsvNma1fD8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771581900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ppHxrIev43ElRDRC+qM7aB/zEIBhLbexSTks14S9LwA=;
 b=AahOZ+5lUzAMrSQd6XZBdtDLMcK6fnx3pzTkV9O6Hkq6YqK0jQUeK9jCklHLhGgtmAeei/
 mns1z/Wz2nqoH/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE7DF3EA67;
 Fri, 20 Feb 2026 10:05:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FR18McwxmGlofwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Feb 2026 10:05:00 +0000
Date: Fri, 20 Feb 2026 11:05:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <aZgx0rp0MRHn4mMT@yuki.lan>
References: <20260219163654.39155-1-always.starving0@gmail.com>
 <20260219163654.39155-2-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260219163654.39155-2-always.starving0@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] poll: add test for POLLNVAL on invalid fd
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
> Add a poll() test to verify that POLLNVAL is reported for invalid file
> descriptors.
> 
> The test closes one end of a pipe and passes the closed descriptor to
> poll(). poll() is expected to return successfully and set POLLNVAL in
> revents.
> 
> This verifies poll() handling of invalid file descriptors without
> triggering an error return.
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  testcases/kernel/syscalls/poll/poll04.c | 60 +++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/poll/poll04.c
> 
> diff --git a/testcases/kernel/syscalls/poll/poll04.c b/testcases/kernel/syscalls/poll/poll04.c
> new file mode 100644
> index 000000000..2013de642
> --- /dev/null
> +++ b/testcases/kernel/syscalls/poll/poll04.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> + */
> +
> +/*

Here as well /*\

> + * Check that poll() reports POLLNVAL for invalid file descriptors.
> + */
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/poll.h>
> +
> +#include "tst_test.h"
> +
> +static int fds[2];
> +
> +void verify_pollnval(void)
> +{
> +	int invalid_fd = fds[0];
> +	struct pollfd pfd = {
> +		.fd = invalid_fd, .events = POLLIN,
> +	};
> +
> +	SAFE_CLOSE(fds[0]);
> +	fds[0] = -1;

Here as well, fds[0] is already set in the SAFE_CLOSE() macro.

Ah, and also this code will fail the test if we run it with -i 2 command
line parameter.

I guess that we need to do in test setup()

- copy the value of fds[0] to different variable
- close the fds[0]


Moreover it may make sense to write the test so that the fd is closed
while one thread is sleeping in the poll().

For that we would need to start a second thread that would wait for the
verify_pollnval() to sleep in the kernel and then close the fd. We do
have functions for that in the test library:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#macro-tst-thread-state-wait


> +	TEST(poll(&pfd, 1, 0));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "poll() failed");
> +		return;
> +	}

Here as well, we should check that the return value was correct.

> +	if (!(pfd.revents & POLLNVAL)) {
> +		tst_res(TFAIL, "poll() did not report POLLNVAL");
> +		return;
> +	}

Here as well, we should check that only the flag we expected was set.

> +	tst_res(TPASS, "poll() reported POLLNVAL");
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

Here as well, either initialize fds or change the checks to >.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_pollnval,
> +};
> \ No newline at end of file
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
