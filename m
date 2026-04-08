Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5401E10F994F
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 15:11:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936993E4D4F
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 17:11:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D86F73E2A06
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 17:11:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 483301A007F4
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 17:11:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C50275BCF5;
 Wed,  8 Apr 2026 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775661056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qdMbYR7Ao7GG5K28HcOsFwuenW3kXnXNtqZGfyTZEps=;
 b=RM85BbzQuDYszcpvnNcxStNalSrhcYx8IB5CgajITwyHWiVNXDfRt/qmbViDIcqebslVNb
 4L9RKY1spwcuNjCCAjQBamdrTaWA973+Hck5NxeKoHYDx7J0HiTFlk+xW1HXtpnM5Y4aZq
 sUwbfLu/hV8bze7mKDfyTHpqL27TRVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775661056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qdMbYR7Ao7GG5K28HcOsFwuenW3kXnXNtqZGfyTZEps=;
 b=gJITlk3ry6k4Pgh892tmWuS7/p1xEe1Q3zxKKOnJEMGdyYuQKyFVZrrQ/gvoehJbxBbSYg
 CTBUiZTHa9g+RSCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RM85BbzQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gJITlk3r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775661056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qdMbYR7Ao7GG5K28HcOsFwuenW3kXnXNtqZGfyTZEps=;
 b=RM85BbzQuDYszcpvnNcxStNalSrhcYx8IB5CgajITwyHWiVNXDfRt/qmbViDIcqebslVNb
 4L9RKY1spwcuNjCCAjQBamdrTaWA973+Hck5NxeKoHYDx7J0HiTFlk+xW1HXtpnM5Y4aZq
 sUwbfLu/hV8bze7mKDfyTHpqL27TRVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775661056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qdMbYR7Ao7GG5K28HcOsFwuenW3kXnXNtqZGfyTZEps=;
 b=gJITlk3ry6k4Pgh892tmWuS7/p1xEe1Q3zxKKOnJEMGdyYuQKyFVZrrQ/gvoehJbxBbSYg
 CTBUiZTHa9g+RSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5FC44A0B3;
 Wed,  8 Apr 2026 15:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UkZmKwBw1mk8EwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Apr 2026 15:10:56 +0000
Date: Wed, 8 Apr 2026 17:11:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <adZot378W4Rg-g4V@yuki.lan>
References: <20260317114635.944-1-wegao@suse.com>
 <20260404011340.13288-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260404011340.13288-1-wegao@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: C50275BCF5
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] io_submit04: Add test case for RWF_NOWAIT flag
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
> --- /dev/null
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
> + * :manpage:`io_getevents(2)` syscall returns immediately and
> + * io_event.res is equal to -EAGAIN.
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
> +static aio_context_t ctx;
> +static char *buf;
> +static iocb *cb;
> +static iocb **iocbs;
> +
> +static void setup(void)
> +{
> +	if (tst_syscall(__NR_io_setup, 1, &ctx))
> +		tst_brk(TBROK | TERRNO, "io_setup failed");

Sorry if that was asked in previous reviews. Why are we using
tst_syscall() instead of the libaio functions like we do in the rest of
the tests?

> +	SAFE_PIPE(fd);
> +
> +	cb->aio_fildes = fd[0];
> +	cb->aio_lio_opcode = IOCB_CMD_PREAD;
> +	cb->aio_buf = TST_PTR_TO_UINT(buf);
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
> +	if (ctx && tst_syscall(__NR_io_destroy, ctx))
> +		tst_brk(TBROK | TERRNO, "io_destroy() failed");
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
> +
> +	TEST(tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout));
> +
> +	if (TST_RET != 1) {
> +		tst_res(TFAIL | TTERRNO, "io_getevents() failed to get 1 event");
> +		return;
> +	}
> +
> +	if (evbuf.res == -EAGAIN)
> +		tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
> +	else
> +		tst_res(TFAIL, "io_getevents() returned with %s instead of EAGAIN",
> +			strerror(-evbuf.res));
                            ^
			    tst_strerrno()

Other than these two minor issues I do not see any problems in the code,
the rest looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
