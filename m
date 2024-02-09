Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9988C4828F
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 20:53:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C77C63CF4EB
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 21:53:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 362273CDE93
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 21:53:07 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 551086002B1
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 21:53:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A955F1F82F;
 Fri,  9 Feb 2024 20:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707511985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCr0fIAj8THSATPjQsS2oPdlelIRKZ2S1IjNiL9uwWs=;
 b=bcqDULkkiyjLSKNfnR5/Qr3DxBi51Xq2RQb7yC4IauGnGUDk0Yr7CiDL0gPbdwOKpx/0dA
 4BW75J7X7zXwo16LIZYn34eBLn+l5JCDbxflDDQxYMGfwjopBmTYsmyq+rfzWPjr+assbp
 rq4ph61Rz614zNs/MFz8ysrysvHtSOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707511985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCr0fIAj8THSATPjQsS2oPdlelIRKZ2S1IjNiL9uwWs=;
 b=RXHeXRugAf8BiKnEMEDmQqC70xm0d231Nhv9Y0LsdIjIe2eiOXhTax5jyecYUoCEXyE4eR
 e6hZFzYzk648VxCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707511985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCr0fIAj8THSATPjQsS2oPdlelIRKZ2S1IjNiL9uwWs=;
 b=bcqDULkkiyjLSKNfnR5/Qr3DxBi51Xq2RQb7yC4IauGnGUDk0Yr7CiDL0gPbdwOKpx/0dA
 4BW75J7X7zXwo16LIZYn34eBLn+l5JCDbxflDDQxYMGfwjopBmTYsmyq+rfzWPjr+assbp
 rq4ph61Rz614zNs/MFz8ysrysvHtSOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707511985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCr0fIAj8THSATPjQsS2oPdlelIRKZ2S1IjNiL9uwWs=;
 b=RXHeXRugAf8BiKnEMEDmQqC70xm0d231Nhv9Y0LsdIjIe2eiOXhTax5jyecYUoCEXyE4eR
 e6hZFzYzk648VxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B1BF13353;
 Fri,  9 Feb 2024 20:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s+ojELGQxmXcXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 20:53:05 +0000
Date: Fri, 9 Feb 2024 21:52:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240209205259.GA303148@pevik>
References: <20231110115830.19664-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231110115830.19664-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] io_submit05.c: Add test case for RWF_APPEND
 flag
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

Hi Wei,

> +++ b/runtest/syscalls
> @@ -656,6 +656,7 @@ io_setup02 io_setup02
>  io_submit01 io_submit01
>  io_submit02 io_submit02
>  io_submit03 io_submit03
> +io_submit05 io_submit05
nit: you have io_submit04 patchset, that's why 04 is skipped. You send them
separately, this can lead to unapplicable patch. As we also discussed 04, could
you send them both in one patchset (even they are separate), because they
influence each other as they touch bouth runtest/syscalls and .gitignore on the
same place?

...
>  keyctl01 keyctl0> +++ b/testcases/kernel/syscalls/io_submit/io_submit05.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This is a basic test for io_submit RWF_APPEND flag.
                                       ^ nit: io_submit()
> + *
> + */
> +
> +#include <linux/aio_abi.h>
> +
> +#include "config.h"
We don't need config.h, right?

> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
And we don't need this header either.

> +#include "lapi/syscalls.h"
...

> +static char *init_buf;
> +static char *update_buf;
> +static char *tmp_buf;

> +static inline void io_prep_option(struct iocb *cb, int fd, void *buf,
> +			size_t count, long long offset, unsigned int opcode)
> +{
> +	memset(cb, 0, sizeof(*cb));
You don't need to do this, cb is static struct iocb iocb, which is {} because static.

> +	cb->aio_fildes = fd;
> +	cb->aio_lio_opcode = opcode;
> +	cb->aio_buf = (uint64_t)buf;
> +	cb->aio_offset = offset;
> +	cb->aio_nbytes = count;
> +	cb->aio_rw_flags = RWF_APPEND;
> +}
Also, I don't see much point of having this as a separate function, I would just
put this in the end of setup().

> +static unsigned int io_submit(void)
As Andrea mentioned, this should be void. But I also does not like the name...
> +{
> +	struct io_event evbuf;
Although we use only one array thus it works, man says: struct iocb **iocbpp),
thus it should have been:
struct io_event evbuf[1] = {};

Newer mind, but I would probably initialize (although it should not be needed as
we pass it to kernel thus other tests does not do it, it's a good habit):
struct io_event evbuf = {};

> +	struct timespec timeout = { .tv_sec = 1 };
> +
> +	TST_EXP_VAL_SILENT(tst_syscall(__NR_io_submit, ctx, 1, iocbs), 1);
We probably want to quit testing if __NR_io_submit fails (probably
tst_brk(TBROK)).

> +	TST_EXP_VAL_SILENT(tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf,
> +			&timeout), 1);

Although we don't use libaio wrapper it's a bit confusing we have io_submit()
function which is not just __NR_io_submit wrapper, but call also
__NR_io_getevents. Maybe use a different name? Or, maybe, add these 4 lines into
the main test function?

Maybe also verify evbuf.res == BUF_LEN ? E.g.:

TST_EXP_VAL_SILENT(evbuf.res, BUF_LEN);

> +}

> +
> +static void setup(void)
> +{
> +
> +	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, MODE);
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +
> +	memset(init_buf, 0x62, BUF_LEN);

> +	memset(update_buf, 0x61, BUF_LEN);
I would also use 'a' and 'b' values (slightly more readable).
And 'a' is what is going to be tested, maybe #define it at the top
(readability, as you define other constants)?

We don't need this memset() either (static variable).
But we want to memset() update_buf each run (for -iN), right?
Then in should be in the test function (again setup() is run only once,
regardless of N in -iN).

> +	memset(tmp_buf, 0, BUF_LEN);
The same about memset() aplies to tmp_buf.

> +
> +	io_prep_option(&iocb, fd, update_buf, BUF_LEN, 1, IOCB_CMD_PWRITE);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +
> +	if (tst_syscall(__NR_io_destroy, ctx))
> +		tst_brk(TBROK | TERRNO, "io_destroy() failed");
> +}
> +
> +
> +static void run(void)
> +{
> +	int i;
> +
> +	SAFE_WRITE(0, fd, init_buf, BUF_LEN);
> +	io_submit();
> +	SAFE_LSEEK(fd, BUF_LEN, SEEK_SET);
> +	SAFE_READ(1, fd, tmp_buf, BUF_LEN);
very nit: space before for helps readability.
> +	for (i = 0; i < BUF_LEN; i++) {
> +		if (tmp_buf[i] != 0x61)
Why not here print tst_res(TFAIL) and return, instead of break?
> +			break;
> +	}
> +
> +	if (i != BUF_LEN) {
> +		tst_res(TFAIL, "buffer wrong at %i have %c expected 'a'",
Here you hardwire 'a', which elsewhere you reference on other places as 0x61.
Again use single definition would be better.

Kind regards,
Petr

> +				i, tmp_buf[i]);
> +		return;
> +	}
> +
> +	tst_res(TPASS, "io_submit wrote %zi bytes successfully "
> +			"with content 'a' expectedly ", BUF_LEN);
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_AIO=y",
> +		NULL
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.max_runtime = 60,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&init_buf, .size = BUF_LEN},
> +		{&update_buf, .size = BUF_LEN},
> +		{&tmp_buf, .size = BUF_LEN},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
