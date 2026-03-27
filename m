Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FD810F2862
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:17:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3F2C3DD114
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 19:17:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5CBE3CF76D
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 19:17:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 274351400041
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 19:17:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD1165BCCA;
 Fri, 27 Mar 2026 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774635439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PqoBV5Xm+bek6CYRBxu361EU/gw8LuQpmDJoS/VjAP4=;
 b=dITvxkl40W/4rWr3qHooH8HjX+8BqQk7oEOkWPXdZjEeL9k2SHtLvOFCezZk/c9rVp0h7D
 wcbNLxXkb/ejtyL6Uy/RHV3U1iijQ991oYEyjr8ssC4ke5+XeZTxfhF5lIUb5ucMZvXSOq
 bUpgEVHKkrxC0SKdKEuinrbnPxIk+9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774635439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PqoBV5Xm+bek6CYRBxu361EU/gw8LuQpmDJoS/VjAP4=;
 b=ULrs9MB08ilqGwEu+yYMILuRV7J+t1v1PaPYikHbX+T8cQFC3e1isEZ78C/W9y5kzHnsNE
 1eLl3vdw7VHQ0PAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774635439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PqoBV5Xm+bek6CYRBxu361EU/gw8LuQpmDJoS/VjAP4=;
 b=dITvxkl40W/4rWr3qHooH8HjX+8BqQk7oEOkWPXdZjEeL9k2SHtLvOFCezZk/c9rVp0h7D
 wcbNLxXkb/ejtyL6Uy/RHV3U1iijQ991oYEyjr8ssC4ke5+XeZTxfhF5lIUb5ucMZvXSOq
 bUpgEVHKkrxC0SKdKEuinrbnPxIk+9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774635439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PqoBV5Xm+bek6CYRBxu361EU/gw8LuQpmDJoS/VjAP4=;
 b=ULrs9MB08ilqGwEu+yYMILuRV7J+t1v1PaPYikHbX+T8cQFC3e1isEZ78C/W9y5kzHnsNE
 1eLl3vdw7VHQ0PAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B1E64A0A2;
 Fri, 27 Mar 2026 18:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /l/gJK/JxmmSOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 18:17:19 +0000
Date: Fri, 27 Mar 2026 19:17:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260327181710.GC1097030@pevik>
References: <20260317074340.589-1-wegao@suse.com>
 <20260317114635.944-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260317114635.944-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] io_submit04: Add test case for RWF_NOWAIT flag
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

Hi Wei, all,

> +++ b/configure.ac
> @@ -172,6 +172,7 @@ AC_CHECK_FUNCS_ONCE([ \
>  ])
>  AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))

> +AC_CHECK_MEMBERS([struct iocb.aio_rw_flags],,,[#include <linux/aio_abi.h>])
FYI I double checked this is from 4.13
9830f4be159b2 ("fs: Use RWF_* flags for AIO operations")

So we need it, but it'd be worth to double check how the test run on 4.4 (if it
TCONF).  Also maybe add a comment in the code or at least mention it in the
commit message.  When we drop old SLES we will be able to remove this.

@Andrea: any hint for your agents to check supported versions
https://linux-test-project.readthedocs.io/en/latest/users/supported_systems.html#kernel-version
and whether it needs to have fallback in lapi and configure.ac?
Also we may ask not to add .min_kver which would be too old.

>  AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
>  AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
>  AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
> diff --git a/include/lapi/aio_abi.h b/include/lapi/aio_abi.h
> new file mode 100644
> index 000000000..ac78e5500
> --- /dev/null
> +++ b/include/lapi/aio_abi.h
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + */
> +
> +#ifndef LAPI_AIO_ABI_H__
> +#define LAPI_AIO_ABI_H__
> +
> +#include <endian.h>
> +#include <linux/aio_abi.h>
> +
> +#ifndef RWF_NOWAIT
> +# define RWF_NOWAIT 0x00000008
And this as well.
b745fafaf70c0 ("fs: Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT")

> +#endif
> +
> +struct iocb_fallback {
> +	uint64_t aio_data;
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +	uint32_t   aio_key;
> +	uint32_t aio_rw_flags;
> +#elif __BYTE_ORDER == __BIG_ENDIAN
> +	uint32_t aio_rw_flags;
> +	uint32_t   aio_key;
> +#else
> +#error edit for your odd byteorder.
> +#endif
> +	uint16_t   aio_lio_opcode;
> +	int16_t   aio_reqprio;
> +	uint32_t   aio_fildes;
> +	uint64_t   aio_buf;
> +	uint64_t   aio_nbytes;
> +	int64_t   aio_offset;
> +	uint64_t   aio_reserved2;
> +	uint32_t   aio_flags;
> +	uint32_t   aio_resfd;
> +};
> +
> +#ifndef HAVE_STRUCT_IOCB_AIO_RW_FLAGS
> +typedef struct iocb_fallback iocb;
> +#else
> +typedef struct iocb iocb;
> +#endif
> +
> +#endif /* LAPI_AIO_ABI_H__ */
...

> +++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Test RWF_NOWAIT support in io_submit(), verifying that an
> + * asynchronous read operation on a blocking resource (empty pipe)
> + * will cause -EAGAIN. This is done by checking that io_getevents()
Please :manpage:`io_getevents(2)`
(to have link to https://man7.org/linux/man-pages/man2/io_getevents.2.html in
docs).

@Andrea: ^ to agents?

> + * syscall returns immediately and io_event.res is equal to -EAGAIN.
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/aio_abi.h"
> +
> +#define BUF_SIZE 100
> +
> +static int fd[2] = {-1, -1};
nit: Andrea (I guess you asked for it), because we hardly close STDOUT in the
test 0 is always used. I see it a bit overkill using -1 (using 0 as the default
would almost always work).

> +static aio_context_t ctx;
> +static char *buf;
> +static iocb *cb;
> +static iocb **iocbs;
> +
> +static void setup(void)
> +{
> +	if (tst_syscall(__NR_io_setup, 1, &ctx))
> +		tst_brk(TBROK | TERRNO, "io_setup failed");
> +
> +	SAFE_PIPE(fd);
> +
> +	cb->aio_fildes = fd[0];
> +	cb->aio_lio_opcode = IOCB_CMD_PREAD;
> +	cb->aio_buf = (uint64_t)buf;
> +	cb->aio_offset = 0;
> +	cb->aio_nbytes = BUF_SIZE;
> +	cb->aio_rw_flags = RWF_NOWAIT;
> +
> +	iocbs[0] = cb;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd[0] != -1)
> +		SAFE_CLOSE(fd[0]);
> +
> +	if (fd[1] != -1)
> +		SAFE_CLOSE(fd[1]);
> +
> +	if (ctx)
> +		if (tst_syscall(__NR_io_destroy, ctx))
> +			tst_brk(TBROK | TERRNO, "io_destroy() failed");
Upper if would require { } brackets, but let's simplify:

	if (ctx && tst_syscall(__NR_io_destroy, ctx))
		tst_brk(TBROK | TERRNO, "io_destroy() failed");

> +}
> +
> +static void run(void)
> +{
> +	struct io_event evbuf;
> +	struct timespec timeout = { .tv_sec = 1 };
> +	long nr = 1;
> +
> +	TEST(tst_syscall(__NR_io_submit, ctx, nr, iocbs));
> +
> +	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP) {
> +		tst_brk(TCONF, "RWF_NOWAIT not supported by kernel");
> +	} else if (TST_RET != nr) {
> +		tst_brk(TBROK | TTERRNO, "io_submit() returns %ld, expected %ld",
> +				TST_RET, nr);
> +	}

Maybe move this to setup()?

> +
> +	TEST(tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout));
> +
> +	if (TST_RET != 1) {
> +		tst_res(TFAIL | TTERRNO, "io_getevents() failed to get 1 event");
> +		return;
> +	}
> +
> +	if (evbuf.res == -EAGAIN)
Did you please check this on 32bit?

> +		tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
> +	else
> +		tst_res(TFAIL, "io_getevents() returned with %s instead of EAGAIN",
> +			strerror(-evbuf.res));
> +}

The rest LGTM.

Kind regards,
Petr

> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_AIO=y",
> +		NULL
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&buf, .size = BUF_SIZE},
> +		{&cb, .size = sizeof(iocb)},
> +		{&iocbs, .size = sizeof(iocb *)},
> +		{},
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
