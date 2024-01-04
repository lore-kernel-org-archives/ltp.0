Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C09C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 23:11:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EDDA3CE6E4
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 00:11:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B3F53CD1AB
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 00:11:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E8B3600958
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 00:11:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 939A71F83C;
 Thu,  4 Jan 2024 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704409870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/j7CRB+Ktnqa0ZviY1seTtrTLtEWjREUKwTyg4hLD0=;
 b=tDZeDFsrw1EHyuAM55X6vrPIRZ0Z2muXtCzXN5ZfImL476agkdEtrhjbXRF9MlLoPZit8C
 7yA5/2hj6VGu86DVrAAWsJr1OQVgeW53DOS/kFNBEPbTyqcrjxOeXkS1jPaPzEMufUzjrz
 psVJqYAmwSW0MEkRDPIn6PKnf5i/A4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704409870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/j7CRB+Ktnqa0ZviY1seTtrTLtEWjREUKwTyg4hLD0=;
 b=2UD+lNiAfjnqyNHl8Vkbk0oQxMSjpOYi2q3GdskOaAG/zWvKYrI6c7irEbH5N0eTcP0HEq
 /CHgxaBJQG5uGYBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704409870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/j7CRB+Ktnqa0ZviY1seTtrTLtEWjREUKwTyg4hLD0=;
 b=tDZeDFsrw1EHyuAM55X6vrPIRZ0Z2muXtCzXN5ZfImL476agkdEtrhjbXRF9MlLoPZit8C
 7yA5/2hj6VGu86DVrAAWsJr1OQVgeW53DOS/kFNBEPbTyqcrjxOeXkS1jPaPzEMufUzjrz
 psVJqYAmwSW0MEkRDPIn6PKnf5i/A4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704409870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/j7CRB+Ktnqa0ZviY1seTtrTLtEWjREUKwTyg4hLD0=;
 b=2UD+lNiAfjnqyNHl8Vkbk0oQxMSjpOYi2q3GdskOaAG/zWvKYrI6c7irEbH5N0eTcP0HEq
 /CHgxaBJQG5uGYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 635EB13722;
 Thu,  4 Jan 2024 23:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A+ggFw47l2X4PAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 23:11:10 +0000
Date: Fri, 5 Jan 2024 00:11:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240104231109.GB1447350@pevik>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-5-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231016123320.9865-5-chrubis@suse.cz>
X-Rspamd-Queue-Id: 939A71F83C
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tDZeDFsr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2UD+lNiA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.28 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.01)[45.62%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] syscalls: splice07: New splice tst_fd
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> +++ b/testcases/kernel/syscalls/splice/splice07.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * [Description]
> + *
nit: missing a description.
> + */
> +#define _GNU_SOURCE
> +
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +#include "tst_test.h"
> +
> +void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
nit: missing static

> +	/* These produce EBADF instead of EINVAL */
> +	switch (fd_out->type) {
> +	case TST_FD_DIR:
> +	case TST_FD_DEV_ZERO:
> +	case TST_FD_PROC_MAPS:
> +	case TST_FD_INOTIFY:
> +	case TST_FD_PIPE_READ:
> +		exp_errno = EBADF;
I tested it just on kernel 6.6. I wonder if this behaves the same on older
kernels.

> +	default:
> +	break;
> +	}
> +
> +	if (fd_in->type == TST_FD_PIPE_WRITE)
> +		exp_errno = EBADF;
> +
> +	if (fd_in->type == TST_FD_OPEN_TREE || fd_out->type == TST_FD_OPEN_TREE ||
> +	    fd_in->type == TST_FD_PATH || fd_out->type == TST_FD_PATH)
> +		exp_errno = EBADF;
I suppose you'll send another version, which will make use of TST_EXP_FAIL.
https://lore.kernel.org/ltp/20240103115700.14585-1-chrubis@suse.cz/

BTW I also wonder if TST_EXP_FAIL() could simplify some of fanotify tests
(some of them got quite complex over time).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
