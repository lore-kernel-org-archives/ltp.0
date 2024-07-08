Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BD9C3271E
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 03:29:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5556D3D3ACD
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 05:29:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE8023D0CD5
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 05:28:44 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 88ECD601572
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 05:28:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CAC441FB58;
 Mon,  8 Jul 2024 03:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720409322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H9vL8YKjmSpdoBHRr6cLdKd+pGU2FSxWApssvdQ1OG4=;
 b=fi0G+XTtR6FzO1AZrFlyxczeCWQABcRCe78gzXI9VRXhtCqujQ4Ga7hbQB+RT2iMUsLt3z
 EMF5bvtuo219tFZZro6jkEpvnwXIDSehlVetnI+Vc28hgMaxgdOK/q8Dtr9lnRT893w/qa
 reAqvoi0giP6hNmwvkBF1IFJm2PhuHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720409322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H9vL8YKjmSpdoBHRr6cLdKd+pGU2FSxWApssvdQ1OG4=;
 b=484Wv1coNl2TMztxXDZZkeTpXNFWMgYxml3n2ffrhWsQGVZpPtiFEsvZ9Y69axAgrG1fsO
 R56ZROK+0R0mi9BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eFhQnE+K;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iUkg6bwG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720409321;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H9vL8YKjmSpdoBHRr6cLdKd+pGU2FSxWApssvdQ1OG4=;
 b=eFhQnE+KXwVJ/q2CKSLZuadz9NkQtDzeJbezFwQC+PSajL4ARdg6o0VGg34mI48v6XJVCX
 9UX+gHyglVFMGjqPHndfvpSt7aSbKWFiKvHF9gqUNSsfBglStFG3jiJknFRGMbJSk/gYcX
 lyhmpneAsY9JqBcY1X5NyvJLmXFa4Io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720409321;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H9vL8YKjmSpdoBHRr6cLdKd+pGU2FSxWApssvdQ1OG4=;
 b=iUkg6bwGEDvKXTYNj/bAxctAWacDSMX1XPXK7rso1RGyfkQtWA1O1TScqTokcsp+t0lQoL
 LTeoCTLOJ7DJWNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5B7812FF6;
 Mon,  8 Jul 2024 03:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S10nJ+lci2aLTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Jul 2024 03:28:41 +0000
Date: Mon, 8 Jul 2024 05:28:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240708032840.GA114537@pevik>
References: <20240627133456.11327-1-chrubis@suse.cz>
 <e2a4ae50-eaa4-49e9-9d5c-5a0d5adc365e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e2a4ae50-eaa4-49e9-9d5c-5a0d5adc365e@suse.cz>
X-Rspamd-Queue-Id: CAC441FB58
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] include/tst_timer: Add TST_NO_LIBLTP
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
Cc: John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>, kernel-team@android.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi,
> this is a lot of unnecessary code to fix a problem that didn't exist in the
> original sched_football patch. I'd prefer one of two other solutions:
> 1) go back to using ts_delta() from the original patch
> 2) fully port the test to new LTP API

Sounds reasonable. FYI back at the time I asked Mel Gorman to investigate which
tests would be relevant and worth to move from LTP into rt-tests. In his reply,
which I put into https://github.com/linux-test-project/ltp/issues/1078, he
considered sched_football as interesting, but requiring to reimplement.
Therefore I would prefer to minimise changes (e.g. using ts_delta) to not
complicate moving test to rt-tests in the future.

Kind regards,
Petr

> On 27. 06. 24 15:34, Cyril Hrubis wrote:
> > Older compilers (gcc-4.8) are not smart enough to eliminate the
> > impossible branch with tst_brk() early enough and the sched_football
> > compilation fails due to the unresolved function.

> > Add TST_NO_LIBLTP macro that adds tst_brk_() inline implementaiont that
> > prints the message and calls abort() and make use of it in sched_football.

> > Cc: kernel-team@android.com
> > Cc: Darren Hart <darren@os.amperecomputing.com>
> > Cc: John Stultz <jstultz@google.com>
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >   include/tst_test.h                            | 23 +++++++++++++++++++
> >   .../func/sched_football/sched_football.c      |  1 +
> >   2 files changed, 24 insertions(+)

> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index 8dc20d110..9bd1b363d 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -648,4 +648,27 @@ int main(int argc, char *argv[])
> >   #define TST_TEST_TCONF(message)                                 \
> >           static struct tst_test test = { .tconf_msg = message  } \
> > +/*
> > + * Fallback for cases where we do not want to link against ltp library.
> > + *
> > + * This allows us for instance to use tst_timer.h without LTP library.
> > + */
> > +#ifdef TST_NO_LIBLTP
> > +__attribute__ ((format (printf, 4, 5)))
> > +inline void tst_brk_(const char *file, const int lineno, int ttype,
> > +                     const char *fmt, ...)
> > +{
> > +	va_list va;
> > +
> > +	(void) ttype;
> > +
> > +	fprintf(stderr, "%s: %i: ", file, lineno);
> > +	va_start(va, fmt);
> > +	vfprintf(stderr, fmt, va);
> > +	va_end(va);
> > +
> > +	abort();
> > +}
> > +#endif
> > +
> >   #endif	/* TST_TEST_H__ */
> > diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
> > index b6ae692af..6846978f4 100644
> > --- a/testcases/realtime/func/sched_football/sched_football.c
> > +++ b/testcases/realtime/func/sched_football/sched_football.c
> > @@ -74,6 +74,7 @@
> >   #include <librttest.h>
> >   #include <tst_atomic.h>
> >   #define TST_NO_DEFAULT_MAIN
> > +#define TST_NO_LIBLTP
> >   #include <tst_timer.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
