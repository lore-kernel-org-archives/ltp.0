Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA39FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:34:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AAB93C2C93
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 18:34:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B94083C2C93
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 18:34:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4233F1400353
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 18:34:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 631785BD6D;
 Tue, 28 Apr 2026 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777394061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rYEwdkjdGr9A90C0qtIYA+n9JqSJTSqSPRB2njkxgw8=;
 b=G94JzoSqLpFYl9oRac9uw4JfdvlGToOFJlFZpxhuWpUb4E49AsIUQK70/X3VKkTMBdJyGW
 3kowXjK8KUgNE+3bqG05qUHCeCLacwLUAEQOuiHMEBwcGVUB0zMhdUr+C0ZF7BoxKEvmOq
 FYLcd6tI0w12j1rQFuvSmyrBRBsblfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777394061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rYEwdkjdGr9A90C0qtIYA+n9JqSJTSqSPRB2njkxgw8=;
 b=8g/SvvHbx4rIpves5ZzOFsqI7DtTmmXPXw/I9DQ1WdDwYc5nYuC++MKvTpv2cyB7cObnES
 znx8NnkOTSyGxiCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777394061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rYEwdkjdGr9A90C0qtIYA+n9JqSJTSqSPRB2njkxgw8=;
 b=G94JzoSqLpFYl9oRac9uw4JfdvlGToOFJlFZpxhuWpUb4E49AsIUQK70/X3VKkTMBdJyGW
 3kowXjK8KUgNE+3bqG05qUHCeCLacwLUAEQOuiHMEBwcGVUB0zMhdUr+C0ZF7BoxKEvmOq
 FYLcd6tI0w12j1rQFuvSmyrBRBsblfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777394061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rYEwdkjdGr9A90C0qtIYA+n9JqSJTSqSPRB2njkxgw8=;
 b=8g/SvvHbx4rIpves5ZzOFsqI7DtTmmXPXw/I9DQ1WdDwYc5nYuC++MKvTpv2cyB7cObnES
 znx8NnkOTSyGxiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08019593B0;
 Tue, 28 Apr 2026 16:34:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wV95OYzh8GlLKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 16:34:20 +0000
Date: Tue, 28 Apr 2026 18:34:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, Li Wang <liwang@linux.dev>,
	ltp@lists.linux.it
Message-ID: <20260428163415.GB921372@pevik>
References: <20260427115941.31945-1-wegao@suse.com>
 <20260428125804.GA921372@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260428125804.GA921372@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap
 space
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi all,

> > mmapstress06 is designed to stress the mfile_swap kernel primitive, which
Uh, I overlooked "mfile_swap kernel primitive". Then the approach would make
sense, but is it really true? mfile_swap does not exist any more, not even in a
git log. Test was added in January 2003, e.g. even before 2.6.

> > manages shared anonymous memory. On architectures with large pages (like
> > 64KB on ppc64le), the test's hardcoded request for 32769 pages results
> > in a ~2GB mapping. So in suse test system configured with 2GB of RAM and
> > no swap space, the test will fails with following information:

I'm not really sure. if that's caused by missing swap or would it work on
machine with RAM big enough which has swap disabled (I guess you retest with
e.g. 8 GB RAM). Otherwise I'd prefer prefer to deal with errno ENOMEM (12)
instead (as I pointed out previously).

Kind regards,
Petr

> > mmapstress06: errno = 12; large mmap failed
> > for this test to run, it needs a mmap space of
> > 32769 pages

> > The failure occurs because the 2GB request cannot be fulfilled within
> > the 2GB RAM limit without swap backing. Since the test specifically
> > intends to exercise swap-related logic (mfile_swap), it should be skipped
> > with TCONF when the system lacks swap space.

> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  testcases/kernel/mem/mmapstress/mmapstress06.c | 8 ++++++++
...
> > +	if (tst_available_swap() <= 0) {
> > +		tst_resm(TCONF, "Test requires swap space to exercise mfile_swap logic");
> Why to require swap for the test instead of checking for ENOMEM later?

> > +		tst_exit();
> nit: I'd use tst_brkm() although it has ugly "Remaining cases broken" message as
> it will be more obvious when doing rewrite.

> > +	}

> How about this? (with cleanup of ugly printf).

> Kind regards,
> Petr

> +++ testcases/kernel/mem/mmapstress/mmapstress06.c
> @@ -89,10 +89,12 @@ int main(int argc, char *argv[])
>  	    (mmapaddr, (ANON_GRAN_PAGES_MAX * NMFPTEPG + 1) * pagesize,
>  	     PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, 0,
>  	     0) == (caddr_t) - 1) {
> -		ERROR("large mmap failed");
> -		printf("for this test to run, it needs a mmap space of\n");
> -		printf("%d pages\n", (ANON_GRAN_PAGES_MAX * NMFPTEPG + 1));
> -		return 1;
> +		if (errno == ENOMEM) {
> +			tst_brkm(TCONF, NULL, "not enough memory or swap for mmap() %d pages",
> +					 ANON_GRAN_PAGES_MAX * NMFPTEPG + 1);
> +		}
> +
> +		tst_brkm(TBROK | TERRNO, NULL, "mmap() failed");
>  	}
>  	(void)sleep(sleep_time);
>  	(void)time(&t);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
