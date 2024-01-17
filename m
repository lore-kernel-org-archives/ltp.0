Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7162C47DAF
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 14:51:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B21B03CE4B4
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 15:50:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E01B3CC959
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 15:50:44 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B10921A04335
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 15:50:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F066422030;
 Wed, 17 Jan 2024 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705503043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1wYK5hf4jrv+0E4pM71jnzrmmgt1nL13zyEwIW2G4o=;
 b=n6u3ijme0K511MVIFT7yjTLkWQ5DgqHH1sURCnNF27AKE69Zw3akAXoLi9se6yAbw2bgID
 AeqQQql496a9YPY0uO87htIp2MJXGz5WMZVWL1cAyjNp9N48ksTT6wqGSsokkrjI3a+GBj
 aB5gUVTqQvTUnmVMolK5PIsj0IstrJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705503043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1wYK5hf4jrv+0E4pM71jnzrmmgt1nL13zyEwIW2G4o=;
 b=j/qxEALUTB2WAyseffqPIIeFbpkPnK8bam20XB1rfcPeKSgOnLFOMoPsolDwmgUxDg7zvV
 /ZD8phouhn4TIwBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705503042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1wYK5hf4jrv+0E4pM71jnzrmmgt1nL13zyEwIW2G4o=;
 b=wEuTXi3Oq3/xMggKnttg1C6aTZsyQdL6PmUt1gWcdDjeKaHF/02ASgffUhYT3SMJBBm6S1
 0uEOrv3TAuTExJO0ra3oM7VJk0FsJXw0QrByScQmA1RQ4y/exIREf6iv1U4tBOoUGFD8he
 wmGjCsnp9CgRGl9CiBvZoDrMTxMEGvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705503042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1wYK5hf4jrv+0E4pM71jnzrmmgt1nL13zyEwIW2G4o=;
 b=ojf18tzdwn2NHApC8XSpfhvAgSXm3qaN26Rg+9fOn+efkUVcSoXG2Aoh9oIO/xCyrrpDEZ
 3rnCIGwN2cJJlmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4A0C13800;
 Wed, 17 Jan 2024 14:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vm3RN0Lpp2WHDAAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 14:50:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id AC3D7A0803; Wed, 17 Jan 2024 15:50:42 +0100 (CET)
Date: Wed, 17 Jan 2024 15:50:42 +0100
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240117145042.xqs5b2twuhz7fr7o@quack3>
References: <20240115125351.7266-1-chrubis@suse.cz>
 <20240115125351.7266-5-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240115125351.7266-5-chrubis@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_SEVEN(0.00)[11]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,suse.com];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] syscalls: splice07: New splice tst_fd
 iterator test
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 15-01-24 13:53:51, Cyril Hrubis wrote:
> We loop over all possible combinations of file descriptors in the test
> and filter out combinations that actually make sense and either block or
> attempt to copy data.
> 
> The rest of invalid options produce either EINVAL or EBADF.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  runtest/syscalls                            |  1 +
>  testcases/kernel/syscalls/splice/.gitignore |  1 +
>  testcases/kernel/syscalls/splice/splice07.c | 70 +++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/splice/splice07.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 5472c954b..6e2407879 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1516,6 +1516,7 @@ splice03 splice03
>  splice04 splice04
>  splice05 splice05
>  splice06 splice06
> +splice07 splice07
>  
>  tee01 tee01
>  tee02 tee02
> diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
> index 61e979ad6..88a8dff78 100644
> --- a/testcases/kernel/syscalls/splice/.gitignore
> +++ b/testcases/kernel/syscalls/splice/.gitignore
> @@ -4,3 +4,4 @@
>  /splice04
>  /splice05
>  /splice06
> +/splice07
> diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
> new file mode 100644
> index 000000000..135c42e47
> --- /dev/null
> +++ b/testcases/kernel/syscalls/splice/splice07.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2023-2024 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Iterate over all kinds of file descriptors and feed splice() with all possible
> + * combinations where at least one file descriptor is invalid. We do expect the
> + * syscall to fail either with EINVAL or EBADF.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +#include "tst_test.h"
> +
> +static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
> +{
> +	/* These combinations just hang since the pipe is empty */
> +	if (fd_in->type == TST_FD_PIPE_READ) {
> +		switch (fd_out->type) {
> +		case TST_FD_FILE:
> +		case TST_FD_PIPE_WRITE:
> +		case TST_FD_UNIX_SOCK:
> +		case TST_FD_INET_SOCK:
> +		case TST_FD_MEMFD:
> +			return;
> +		default:
> +		break;
> +		}
> +	}
> +
> +	if (fd_out->type == TST_FD_PIPE_WRITE) {
> +		switch (fd_in->type) {
> +		/* While these combinations succeeed */
> +		case TST_FD_FILE:
> +		case TST_FD_MEMFD:
> +			return;
> +		/* And this complains about socket not being connected */
> +		case TST_FD_INET_SOCK:
> +			return;
> +		default:
> +		break;
> +		}
> +	}
> +
> +	const int exp_errnos[] = {EBADF, EINVAL};
> +
> +	TST_EXP_FAIL2_ARR(splice(fd_in->fd, NULL, fd_out->fd, NULL, 1, 0),
> +		exp_errnos, "splice() on %s -> %s",
> +		tst_fd_desc(fd_in), tst_fd_desc(fd_out));
> +}
> +
> +static void verify_splice(void)
> +{
> +	TST_FD_FOREACH(fd_in) {
> +		tst_res(TINFO, "%s -> ...", tst_fd_desc(&fd_in));
> +		TST_FD_FOREACH(fd_out)
> +			check_splice(&fd_in, &fd_out);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_splice,
> +};
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
