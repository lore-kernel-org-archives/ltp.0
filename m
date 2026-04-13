Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D101F531CF
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 20:45:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D3C93E4D55
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 22:45:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B77733E216F
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 22:45:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D75511A006B6
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 22:45:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E47F86A8C2;
 Mon, 13 Apr 2026 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776113129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0QmNXoBh+p+8wF3SbsHzodxTMZ6vU5XGjsJtn+58I0=;
 b=ViBX10EVC1RLbmvTpAfew0v25t1Rb1CyZFnesYtIHqmclbSSikfjgKfb44y6xI/8dYew60
 M1usO2pwzo4n8KALk+DOU0c7rfn2N8+6EtlXTEHYjtCCp4c9CcHKTcpnTbCNhQMnKGhIfG
 o/DN0Wv+8WB84FrWbpVc0H1sKMsn5rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776113129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0QmNXoBh+p+8wF3SbsHzodxTMZ6vU5XGjsJtn+58I0=;
 b=lgVcRIdCxIU0Sg/2yjr32t37pob+U1F7XuljkqTpLdHr9o3h2s0uI+/m236jCXkoeKmJWM
 p6E1QJFI5HrzrXCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776113127;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0QmNXoBh+p+8wF3SbsHzodxTMZ6vU5XGjsJtn+58I0=;
 b=SbF0FRSH+LvE5qatzX0SwtVDEx6wKY2G64J0p+mAv85lKwh/VAhjmmv8gwwWmeHAuWHA0s
 Or9Km6GgoVN6qwKxwOHNqEiEtGsjHmz92syBTzldETkuJsCcdc0H0lMGfiNxT6uqFdWSAB
 qETEPKABSYA5BuXZ2zkrzP3+oCTtT3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776113127;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0QmNXoBh+p+8wF3SbsHzodxTMZ6vU5XGjsJtn+58I0=;
 b=8tjrjF2ZQfusdMxu1ZOE1zu2lwKwoUE6TfrO0SPJBSv/sHQLj4K3Rv1LSOmDCmXfea84q2
 O8aLhIzvSoVwrNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 955BB4B09A;
 Mon, 13 Apr 2026 20:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YBTwH+ZV3Wl9awAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Apr 2026 20:45:26 +0000
Date: Mon, 13 Apr 2026 22:45:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260413204519.GB153189@pevik>
References: <CAE1O6mgFhsT0XP33=8Ji5dJPS5d27Oz8A74wWckcDX0c4LVHxQ@mail.gmail.com>
 <20260413165457.1349-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260413165457.1349-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] close: add test for double close EBADF
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
> Changes in v3:
> - Add O_RDWR flag to SAFE_OPEN
> - Link to v2: https://lore.kernel.org/ltp/20260411110405.7330-1-always.starving0@gmail.com
> Changes in v2:
> - Add additional test coverage to close02 instead of creating a separate
>   close03 test.
> - Link to v1: https://lore.kernel.org/ltp/20260406133134.17238-2-always.starving0@gmail.com
> ---
>  testcases/kernel/syscalls/close/close02.c | 42 ++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
> index 617c48237..3b3c61b1e 100644
> --- a/testcases/kernel/syscalls/close/close02.c
> +++ b/testcases/kernel/syscalls/close/close02.c
> @@ -5,17 +5,51 @@
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
> +enum case_type {
> +	INVALID_FD,
> +	DOUBLE_CLOSE,
> +};
> +
> +static struct tcase {
> +	const char *desc;
> +	enum case_type type;
> +} tcases[] = {
> +	{ "close(-1)", INVALID_FD },
> +	{ "close same fd twice", DOUBLE_CLOSE },
I'd slightly prefer to have fd and errnos here in the struct:
	int fd;
	int exp_errno;

Specially with other changes below. This way will follow more LTP errno test
approach and enum case_type will not be needed.

> +};
> +
> +static void verify_close(unsigned int i)
>  {
> -	TST_EXP_FAIL(close(-1), EBADF);
> +	int fd;
> +	struct tcase *tc = &tcases[i];
> +
> +	switch (tc->type) {
> +	case INVALID_FD:
> +		TST_EXP_FAIL(close(-1), EBADF, "%s", tc->desc);
> +		break;
> +
> +	case DOUBLE_CLOSE:
> +		fd = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
> +
> +		TST_EXP_PASS(close(fd), "%s: first close()", tc->desc);
Thinking about it twice, I would move SAFE_OPEN() together with this line
converted to SAFE_CLOSE() to setup(). Why? We test errnos, therefore this is
really just a preparation.

Then, the runtime would really be
	TST_EXP_PASS(close(tc->fd), "%s", tc->desc);

Kind regards,
Petr

> +		TST_EXP_FAIL(close(fd), EBADF, "%s: second close()", tc->desc);
> +		break;
> +	}
>  }

>  static struct tst_test test = {
> -	.test_all = run,
> +	.needs_tmpdir = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_close,
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
