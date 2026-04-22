Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD3BF5A8DE
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 11:41:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 817983E53B8
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 13:41:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8C3C3E1A28
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 13:41:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD9FF1000481
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 13:41:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E02D5BD4B;
 Wed, 22 Apr 2026 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776858088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OhYtNu5qATxtRCUwMSFKs9HDSAOIx/580weSkUJYsU=;
 b=xfgO0JscM10ZqRs+dVsFiwgPPJcbUOrzMzkrtnuILFvzo/DFrKduZ/r55dJUtE6dhygEm+
 nXR0mEFhtNRVPtPhGllhuOoiinlKjJTkot9yH5TRLilODrMq6gnWyGV6IpKWgJiQ5a+Kno
 T/DgKC79gb3EP1fP517z1OlB5pQ49e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776858088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OhYtNu5qATxtRCUwMSFKs9HDSAOIx/580weSkUJYsU=;
 b=ukhr8jEocIxrpqmGasi5iDq87Vd5qvIInp/isqorTWOuma/ndGbWh75KO/Ab54fkVxHKYB
 p6XQDs7HIAnYhuCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776858088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OhYtNu5qATxtRCUwMSFKs9HDSAOIx/580weSkUJYsU=;
 b=xfgO0JscM10ZqRs+dVsFiwgPPJcbUOrzMzkrtnuILFvzo/DFrKduZ/r55dJUtE6dhygEm+
 nXR0mEFhtNRVPtPhGllhuOoiinlKjJTkot9yH5TRLilODrMq6gnWyGV6IpKWgJiQ5a+Kno
 T/DgKC79gb3EP1fP517z1OlB5pQ49e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776858088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OhYtNu5qATxtRCUwMSFKs9HDSAOIx/580weSkUJYsU=;
 b=ukhr8jEocIxrpqmGasi5iDq87Vd5qvIInp/isqorTWOuma/ndGbWh75KO/Ab54fkVxHKYB
 p6XQDs7HIAnYhuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7C55593AF;
 Wed, 22 Apr 2026 11:41:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZsHGL+ez6GnxOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Apr 2026 11:41:27 +0000
Date: Wed, 22 Apr 2026 13:41:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260422114126.GD402660@pevik>
References: <20260417115648.GC409289@pevik>
 <20260421144246.2046-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260421144246.2046-1-always.starving0@gmail.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] close02: add test for double close EBADF
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

> Verify that calling close() on an already closed file descriptor fails
> with EBADF.

> This test adds coverage for a common state transition case where a
> previously valid file descriptor becomes invalid after close().

> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
> Changes in v5:
> - Change file descriptor as static
Well, I asked for static pointer.

> - Link to v4 : https://lore.kernel.org/ltp/20260416125554.2920-1-always.starving0@gmail.com

> Changes in v4:
> - Remove enum, add fd/expected errno in tcases, and move preparation
>   to setup().
> - Link to v3: https://lore.kernel.org/ltp/20260413165457.1349-1-always.starving0@gmail.com

> Changes in v3:
> - Add O_RDWR flag to SAFE_OPEN
> - Link to v2: https://lore.kernel.org/ltp/20260411110405.7330-1-always.starving0@gmail.com

> Changes in v2:
> - Add additional test coverage to close02 instead of creating a separate
>   close03 test.
> - Link to v1: https://lore.kernel.org/ltp/20260406133134.17238-2-always.starving0@gmail.com
> ---
>  testcases/kernel/syscalls/close/close02.c | 37 ++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
> index 617c48237..a48570d12 100644
> --- a/testcases/kernel/syscalls/close/close02.c
> +++ b/testcases/kernel/syscalls/close/close02.c
> @@ -5,17 +5,46 @@
>   */

>  /*\
> - * Call close(-1) and expects it to return EBADF.
> + * Verify :manpage:`close(2)` failure cases:
> + *
> + * 1) close(-1) returns EBADF.
> + * 2) closing the same fd twice returns EBADF on the second call.
>   */

>  #include <errno.h>
> +#include <fcntl.h>
> +
>  #include "tst_test.h"

> -static void run(void)
> +static int fd_closed = -1;
> +
> +static struct tcase {
> +	const char *desc;
> +	int fd;

ie instead of "int fd" define:
	int *fd;

> +	int exp_errno;
> +} tcases[] = {
> +	{ "close(-1)", -1, EBADF },
> +	{ "close same fd twice", -1, EBADF },
> +};
> +
> +static void verify_close(unsigned int i)
>  {
> -	TST_EXP_FAIL(close(-1), EBADF);
> +	struct tcase *tc = &tcases[i];
> +
> +	TST_EXP_FAIL(close(tc->fd), tc->exp_errno, "%s", tc->desc);
> +}
> +
> +static void setup(void)
> +{
> +	fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
> +
> +	SAFE_CLOSE(fd_closed);
> +	tcases[1].fd = fd_closed;

We're getting there but not yet :).  My point was not to assign file descriptor
here in the setup function, but above in tcases[] array. For that you need to
define in struct tcases "int *fd" (i.e. pointer) instead of "int fd".

I pointed in v4 testcases/kernel/syscalls/bind/bind01.c, which uses
int *socket_fd, could you do it that way (use pointer)?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
