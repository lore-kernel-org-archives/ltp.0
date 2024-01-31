Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFDFC47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:14:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46D893CE0B3
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:14:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720873CB75C
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:14:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E5EFA1401638
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:14:25 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 685E4220FD;
 Wed, 31 Jan 2024 10:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706696064;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eplihMCYNhqzC5VkxotfasqgVk6NAoSrgQlh0cQ36vQ=;
 b=Uorj5NctKkmqzBKNbPzMs2gqSf36+yMCxrQYMm5sdrYII80HydWPQM16KggpVFAnj/I0aA
 I9DqtWp7IMqqCHNlQHagBi+YwCkqrLujDhZz6tiq4przDzgA+NfW9tc7lvuXwSJIIFOH6i
 4XBbBndsmbommNtSO+2GQO5gljWVl2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706696064;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eplihMCYNhqzC5VkxotfasqgVk6NAoSrgQlh0cQ36vQ=;
 b=PPllyeX8y23Q1PaL1d/G4IjPXnF9lP68n8rSSQ/BoMT68IlgGSvw4HOEBSlQtRJNUWa9mx
 hBRgSKRB2ZsssEAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706696063;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eplihMCYNhqzC5VkxotfasqgVk6NAoSrgQlh0cQ36vQ=;
 b=IX4rxBlRI2ZQeFExYpf3qVrpuyO2g+5n4zBj8S/K1m9/FlEL9KsaI8TzeiBhdoD6q879j9
 ZCw4zaYMlU0t86iYC0s9ItBBkUvb4z59sx+49LBI07eKDlnE0aIdJF1Tv0Hwp4G6lDXjWe
 2QjS0lQHBVisxSFfI0xiwkYenUp+uWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706696063;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eplihMCYNhqzC5VkxotfasqgVk6NAoSrgQlh0cQ36vQ=;
 b=dSqLoi44u7EakquU+G8DNiIX/+ZnJu4Cr/U1q0tvBgKTdrWQC58XBUp5AefgPk6JUJ6+3H
 6Znp+3hN6NcwF9AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 21367139D9;
 Wed, 31 Jan 2024 10:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 2QdbA38dumUzMQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 10:14:23 +0000
Date: Wed, 31 Jan 2024 11:14:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240131101420.GA890138@pevik>
References: <20240130162813.20278-1-mdoucha@suse.cz>
 <20240130172243.GB824958@pevik>
 <d145b85f-7a31-450b-a1ae-07131f034ad8@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d145b85f-7a31-450b-a1ae-07131f034ad8@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.02 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.68)[83.01%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitpid01: Test all standard deadly signals
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

> On 30. 01. 24 18:22, Petr Vorel wrote:
> > Hi Martin,

> > nice work.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > ...
> > > +++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
> > > @@ -5,25 +5,57 @@
> > >    * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>

> > Very nice cleanup, you deserve copyright, right?
> >   * Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
> > >    */

> It's not that big of a change.

ack.

> > > Extend waitpid01 to test all standard signals that kill the target
> > > process unless caught. Also remove waitpid02 since testing SIGFPE
> > > in waitpid01 makes it redundant.
> > > +static int testcase_list[] = {
> > > +	SIGABRT,
> > > +	SIGALRM,
> > > +	SIGBUS,
> > > +	SIGFPE,
> > > +	SIGHUP,
> > > +	SIGILL,
> > > +	SIGINT,
> > > +	SIGKILL,
> > > +	SIGPIPE,
> > > +	SIGPOLL,
> > > +	SIGPROF,
> > > +	SIGQUIT,
> > > +	SIGSEGV,
> > > +	SIGSYS,
> > > +	SIGTERM,
> > > +	SIGTRAP,
> > > +	SIGVTALRM,
> > > +	SIGXCPU,
> > > +	SIGXFSZ
> > > +};

> > I suppose you ignored from the list of signals in man signal(7) these with
> > action "Core" "Term" unless without standard ("-"), right?
> > So user defined signals (SIGUSR1, SIGUSR2) does not make sense to test?

> I've skipped all non-standard signals (some of which are just aliases for
> standard ones) and I think it's better to avoid SIGUSR* since we use them
> internally. But we could also add signal(sig, SIG_DFL); before raise() and
> add SIGUSR* to the list.

Thanks for info. Feel free to send v2 (or let me know to wait). Otherwise I'll
merge it in the evening or tomorrow.

Kind regards,
Petr

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
