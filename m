Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7557C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 13:59:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC81E3C966D
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 15:59:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 363A33C879E
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 15:58:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8782D140044A
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 15:58:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96BB52236F;
 Mon, 15 Aug 2022 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660571926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QzrFS10TcHMtecjPuj7Q0CdAH4y6w7Md/3j7tUyhops=;
 b=Pln91aZ1wg18eB5d2R44fHwsTh70hFvR5Ki/EDEQ0leHcXh7m4JaKXMlNsS5HVCcRJEF2+
 K6dq6Uoi/6KgcBwzgdbaASjBIbcGJXuEXqvDJWbhvvAj17KT6YTJMMzA+++FtKLfeuHUZN
 WutzhWQI8thhYtUhM7sEDFFl0MI97hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660571926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QzrFS10TcHMtecjPuj7Q0CdAH4y6w7Md/3j7tUyhops=;
 b=lwRPTZ51O04u47q9s1ir2hTlVBUnBwmucI6Wfm887JSY1EnjApEnG81X42OyoZMUaWdTNB
 FQWAp60P+yaxhEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74F8E13A93;
 Mon, 15 Aug 2022 13:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T0I/GxZR+mJ4VAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Aug 2022 13:58:46 +0000
Date: Mon, 15 Aug 2022 16:00:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YvpRidqm9QPS6DfR@yuki>
References: <20220808125025.15167-1-andrea.cervesato@suse.com>
 <YvZyAt0QGnRZMirP@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvZyAt0QGnRZMirP@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns16 test using new LTP API
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
> > +static int counter;
> Shouldn't this be volatile? And maybe also sig_atomic_t instead of int (even
> it's the same)?

As long as we only modify the counter from within the signal handler
it's not required.

The probelm that sig_atomic_t fixes is to make sure that the load/store
is single CPU instruction so that we are sure that we don not jump into
the handler in the middle of a sequence of load/store instruction.

And the volatile "turns off" caching of the value, so again anything
that is accessed from both the handler and the rest of the code should
be volatile.

> static volatile sig_atomic_t counter;
> 
> > -char *TCID = "pidns16";
> > -int TST_TOTAL = 3;
> > -
> > -void child_signal_handler(int sig, siginfo_t * si, void *unused)
> > +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
> >  {
> > -	static int c = 1;
> > -	pid_t expected_pid;
> > -
> > -	/* Verifying from which process the signal handler is signalled */
> > +	pid_t exp_pid;
> 
> > -	switch (c) {
> > -	case 1:
> > -		expected_pid = PARENT_PID;
> > +	switch (counter) {
> > +	case 0:
> > +		exp_pid = 0;
> >  		break;
> > -	case 2:
> > -		expected_pid = CHILD_PID;
> > +	case 1:
> > +		exp_pid = 1;
> >  		break;
> >  	default:
> > -		tst_resm(TBROK, "child should NOT be signalled 3+ times");
> > +		tst_brk(TBROK, "Child should NOT be signalled 3+ times");
> >  		return;
> >  	}
> 
> very nit: I'd use if (counter 
> if (counter > 1) {
> 	tst_brk(TBROK, "Child should NOT be signalled 3+ times");
> 	return;
> }
> exp_pid = counter;

The bigger problem though is that we call tst_brk() and tst_res() in the
handler, which is not safe at all. The are couple things that can go
wrong here, mostly glibc locks can get deadlocked for the underlying
FILE* and if the underlying fprintf() calls malloc() the malloc data
structures may end up corrupted. It's quite rare for this to happen, but
there have been a few tests that were failing with small probability due
to these mistakes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
