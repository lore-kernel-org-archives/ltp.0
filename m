Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E55CA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 11:50:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 488EE3E57E8
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 13:50:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 450F03C5A16
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:49:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9BDE7200AE5
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:49:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B41CB21BDE;
 Tue, 29 Sep 2026 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790682591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QaIFQWBbSKp/PRNBitqY/ZDtj6knAdfMC09Y+TKe+c=;
 b=jmY3MlwT/M4fmyO4datLPb0IEKeJjWKB5SvR0oVMV2aSBJ+AjHKX0dnTnmgY3p9sgBcpYy
 oBjV/8f/FJ6ce9N0Xj++WCjicyw0fqvfh0vgn83HvrAIIjkxAGTwiMGj7bri3+hYhv2YPE
 VwfQIm4HT10o0e0AIeOPWOinhNe7tTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790682591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QaIFQWBbSKp/PRNBitqY/ZDtj6knAdfMC09Y+TKe+c=;
 b=qzXq9LgqlE7ls6GMrWa0QoSvDyMrHPykd0MSZ9OYMYvG+SFwyo3+c0j821HOT0Hg2bniXM
 RTpxDkX74QjlniCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790682587;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QaIFQWBbSKp/PRNBitqY/ZDtj6knAdfMC09Y+TKe+c=;
 b=K40lzASoT2EzBE3oZ5aumQw193LkPu9TgCbn9/IbOR/MKkpCLKWPJ7jJH6nbz+dzrAkR4R
 l9JD1kwZaWqACZfYDdwq4CuShjKoNWEVMSO8w6lzhZe0pLINSL6j2k+5Vu5esinMDZv+1r
 woeU5NMXazVz/stpRtcT2T7UDHkaxgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790682587;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QaIFQWBbSKp/PRNBitqY/ZDtj6knAdfMC09Y+TKe+c=;
 b=6j7NdjB1RtSSnOEr4o8YbICjUEDdbHfJC9ptppaIISNmNVmAGpX6Ln1QnfmcPTqqMW5A02
 BRYxnmzjxJgOxcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5637A13722;
 Tue, 29 Sep 2026 11:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4NUgDtulu2qJLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 11:49:47 +0000
Date: Tue, 29 Sep 2026 13:49:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260929114945.GA2456273@pevik>
References: <20260808150331.127440-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260808150331.127440-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] openposix: timer_*/speculative: Handle SIGSEGV
 on invalid timer ID
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

Hi Avines,

> timer_delete/speculative/5-1, timer_getoverrun/speculative/6-1,
> timer_gettime/speculative/6-1 and timer_settime/speculative/12-1
> all pass a bogus value as an invalid timer_t timerid.
> On i586, glibc dereferences timer_t as a pointer into
> internal state, and the bogus pointer causes a SIGSEGV
> instead of the tests' expected EINVAL:

>   timer_delete_sp[22499]: segfault at 7f4982f0 ip b7e07824 sp bfa4c140 error 4 in libc.so.6[a4824,b7d87000+191000]

Good catch, thanks!

> POSIX defines no required behavior for an invalid timer ID (EINVAL is
> only a recommendation), so a SIGSEGV is just as valid an outcome.

> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  .../interfaces/timer_delete/speculative/5-1.c | 19 ++++++++++++++++++
>  .../timer_getoverrun/speculative/6-1.c        | 19 ++++++++++++++++++
>  .../timer_gettime/speculative/6-1.c           | 20 +++++++++++++++++++
>  .../timer_settime/speculative/12-1.c          | 20 +++++++++++++++++++
>  4 files changed, 78 insertions(+)

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> index 912cf5800e6f..af01f72a59d1 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> @@ -13,16 +13,35 @@
>  #include <time.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <signal.h>
> +#include <unistd.h>
>  #include "posixtest.h"

>  #define BOGUSTIMERID 99999

> +/*
> + * when timerid argument does not correspond to a timer ID returned by
> + * timer_create(), POSIX recommends EINVAL, but SIGSEGV is also
> + * valid outcome.
> + */
> +static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
> +{
> +	PTS_WRITE_MSG("Got SIGSEGV when calling timer_delete() with an invalid timer ID\n");
> +	PTS_WRITE_MSG("Test PASSED\n");
> +	_exit(PTS_PASS);
> +}

I'm not sure if the approach of creating bogus timer_t is a good idea anyway.
Shouldn't be just some timer_t tid set to invalid value? That would IMHO be
less awkward solution.

That would help not having to fallback due SIGSEGV which 1) can happen on any
arch (covered because fix is not i686 specific) 2) test is simple but any
potential SIGSEGV.

And, if we want to use kind of bad pointer, shouldn't we backport
tst_get_bad_addr() from lib/tst_get_bad_addr.c?

void *tst_get_bad_addr(void (*cleanup_fn) (void))
{
	void *bad_addr;

	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
	if (bad_addr == MAP_FAILED)
		tst_brkm(TBROK, cleanup_fn, "mmap() failed to get bad address");

	return bad_addr;
}

Tests which are using this it does not SIGSEGV.

nit: if the current approach is ok, even the function is small, it's in 4 files.
We have general helpers in testcases/open_posix_testsuite/include/,
sigsegv_handler() could be in one of them (I'd omit function name, which is test
specific).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
