Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA481D3B997
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 14:36:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A3173DB1CB
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 15:36:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB8AD3DB1C1
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 15:35:51 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3567E11E4FAE
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 15:35:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DE5C1F74C;
 Tue, 26 Nov 2024 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732631750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1H8ShDuBFK/we88mY9HMC5k5ZiT607CDkxLqJcTYocY=;
 b=AW/b/5bS1PrcRQnQy2AzFc99U14U11QDci41wJrISXmD2vq9Us0BLqXY0jYE9CgRQ9rao1
 VeNx8ZU9GTOaLf2Kt73xYO3nNCcNtAXtY6VWLyrQIQLOWMpLKCo2kS0GlfKCwex1qZaJNZ
 gFgFOOrjM4KCEAlS5PNTZuhATHsByVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732631750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1H8ShDuBFK/we88mY9HMC5k5ZiT607CDkxLqJcTYocY=;
 b=RGuHvOoL7ttXlrs3Xc56ptVtpVb2n0b0FWl72P88+/U2uUtYU1qH8G5q7DrexQ7LztbYcV
 WpAiu+e01VfeufAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732631749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1H8ShDuBFK/we88mY9HMC5k5ZiT607CDkxLqJcTYocY=;
 b=plsQfLAXF6fgvysAs90T4KxqjjHpE0rU98wv9OTtBrdHc6M3+LQ+ASJq9mNbPP/kmVe9H9
 grX/gpV5QG+bk8OSgtzXSnxyt5SlQvQZ8LiYnyN1FBzHyitBBvghDTVaz9dZEFeLMvBLHQ
 sQkKuAK1ZuoQWlChwzX7UqMrQAb1/7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732631749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1H8ShDuBFK/we88mY9HMC5k5ZiT607CDkxLqJcTYocY=;
 b=OCrITxOfxXEDxoJV73xrX94msuRNTkUY12r+cI/j0h1B3tvEHiLbcvmb/oQPxoUQ/G/sU7
 QD8OQohYmOuCgVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 111C8139AA;
 Tue, 26 Nov 2024 14:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FJiCAsXcRWeqegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 Nov 2024 14:35:49 +0000
Date: Tue, 26 Nov 2024 15:35:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241126143542.GA77885@pevik>
References: <20240521105348.126316-1-pvorel@suse.cz>
 <20240521105348.126316-6-pvorel@suse.cz> <Zky53rMVsqvgTCxG@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zky53rMVsqvgTCxG@yuki>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] setsockopt0[38]: Use tst_is_compat_mode()
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

Hi Cyril,

> Hi!
> >  testcases/kernel/syscalls/setsockopt/setsockopt03.c | 5 ++---
> >  testcases/kernel/syscalls/setsockopt/setsockopt08.c | 6 ++----
> >  2 files changed, 4 insertions(+), 7 deletions(-)

> > diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> > index 7a1458277..d910280c8 100644
> > --- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> > +++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> > @@ -48,9 +48,8 @@ struct payload {

> >  static void setup(void)
> >  {
> > -	if (tst_kernel_bits() == 32 || sizeof(long) > 4)
> > -		tst_res(TCONF,
> > -			"The vulnerability was only present in 32-bit compat mode");
> > +	if (!tst_is_compat_mode())
> > +		tst_res(TCONF, "The vulnerability was only present in 32-bit compat mode");
> >  }

> >  static void run(void)
> > diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> > index 7f8243de1..3b7bd8482 100644
> > --- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> > +++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> > @@ -95,10 +95,8 @@ static void *buffer;

> >  void setup(void)
> >  {
> > -	if (tst_kernel_bits() == 32 || sizeof(long) > 4) {
> > -		tst_res(TINFO,
> > -			"The vulnerability was only present in 32-bit compat mode");
> > -	}
> > +	if (!tst_is_compat_mode())
> > +		tst_res(TINFO, "The vulnerability was only present in 32-bit compat mode");

> >  	tst_setup_netns();
> >  }

> I guess this is something that should be looked into after the release,
> either we will need .needs_compat flag or relax the condtions...

Looking into this old patch, do we relax the conditions or use .needs_abi_bits = 32?
setsockopt08.c prints only TINFO, thus !tst_is_compat_mode() would have to be
used for the check.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
