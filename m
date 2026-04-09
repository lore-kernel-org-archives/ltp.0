Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626B9E9DE60
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 08:16:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B52A13E2E53
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:16:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A43C3E1C1C
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:15:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 21C7A1400439
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:15:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 997784EE56;
 Thu,  9 Apr 2026 08:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775722551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Czda1vrFZ+i29nNX47mLVZo0Tiki2rHorQXZpevxw0=;
 b=U/zRgBanDJ+SGAqfIoGC7WutEZ9tar2IgvsSPzaRgSeGuZ3srGblbLiM7L6XPp3bFc4GjA
 oK7Lk5G2n738/sv/eC9FYRMr0OjN6Tv70RqHL2RxKZ/z7dsH8kfkuoaxt1tMOIdGOT932Z
 2TOjooIRHAPskQ3uuYc+hIil7bAORHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775722551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Czda1vrFZ+i29nNX47mLVZo0Tiki2rHorQXZpevxw0=;
 b=D6JJU9e3o0ajh7DSjPh0NnZcDZWvIp1HmPyzvlYfXD0wlCbJydN1mvk8FrRJuRfs+TVgPu
 FSoWmAtwOaA78QBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775722551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Czda1vrFZ+i29nNX47mLVZo0Tiki2rHorQXZpevxw0=;
 b=U/zRgBanDJ+SGAqfIoGC7WutEZ9tar2IgvsSPzaRgSeGuZ3srGblbLiM7L6XPp3bFc4GjA
 oK7Lk5G2n738/sv/eC9FYRMr0OjN6Tv70RqHL2RxKZ/z7dsH8kfkuoaxt1tMOIdGOT932Z
 2TOjooIRHAPskQ3uuYc+hIil7bAORHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775722551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Czda1vrFZ+i29nNX47mLVZo0Tiki2rHorQXZpevxw0=;
 b=D6JJU9e3o0ajh7DSjPh0NnZcDZWvIp1HmPyzvlYfXD0wlCbJydN1mvk8FrRJuRfs+TVgPu
 FSoWmAtwOaA78QBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EB074A0B3;
 Thu,  9 Apr 2026 08:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cvqDHTdg12kVAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Apr 2026 08:15:51 +0000
Date: Thu, 9 Apr 2026 10:15:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260409081546.GB96667@pevik>
References: <20260406133134.17238-1-always.starving0@gmail.com>
 <20260406133134.17238-2-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260406133134.17238-2-always.starving0@gmail.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] close: add test for double close EBADF
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

> Verify that calling close() on an already closed file descriptor fails
> with EBADF.

> The existing close tests cover:
> - close01: successful close on valid file descriptors
> - close02: invalid file descriptor (-1)

> This test adds coverage for a common state transition case where a
> previously valid file descriptor becomes invalid after close().

IMHO it'd make sense to add this errno check to close02.c (using .tcnt).

...
> --- /dev/null
> +++ b/testcases/kernel/syscalls/close/close03.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> + */
> +
> +/*\
> + * Verify that calling close() twice on the same fd returns EBADF on

Please instead of close() use:
:manpage:`close(2)`

That will provide link to man page
https://man7.org/linux/man-pages/man2/close.2.html

in our test catalog:
https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

Kind regards,
Petr

> + * the second call.
> + */
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	int fd = SAFE_OPEN("close03", O_CREAT, 0600);
> +
> +	TST_EXP_PASS(close(fd));
> +	TST_EXP_FAIL(close(fd), EBADF);
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
