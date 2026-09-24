Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB42C98317
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 11:04:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D6423E6570
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:04:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 635F93E5CA8
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:04:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E1E9A1401244
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:04:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B258E200BF;
 Thu, 24 Sep 2026 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790247839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U52Wo5g90OSznJOqsT3Bbff14KAZR3nOuPfayWMlU9o=;
 b=pdhe0b8Z9q2WQdEKIBFc1REzIqflV1WAvs5xKFIuTCE/9c+Qx4WkON1MnWmktwRu864ZCF
 IybxOLHRVsMnuYrZhqlekB5ShcSNNkR8bKWqd8/Y20e7Rcun7uJjoKKyFHvfEhd5+7CeQx
 Ff6+xZkHieUBCYmF1/4WROxSUYtebd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790247839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U52Wo5g90OSznJOqsT3Bbff14KAZR3nOuPfayWMlU9o=;
 b=UCCjvff7F1mAJ2KnRCHRSFrXyEGhEaUk3/+tN4gFP14PyZIbNshKUieVuSaflGGdbERqQI
 LBkrnozIqXa16FDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790247835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U52Wo5g90OSznJOqsT3Bbff14KAZR3nOuPfayWMlU9o=;
 b=iwNEwnYeLmbvzBlcaiWiwqvZ3hXWHFXlzWrpkS2w3cyIc9pwirh+ka1ndWz4wG2lr75H0s
 TGnRzFbBLZzOry5vcSy4ScZJiU+wTFFX8hi4+P/MmIGrnxTBa6xSIIO5iIcdpKnd0UyLSo
 mAB8HE8GbPt2EkyqJhd/08fxQ+prI68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790247835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U52Wo5g90OSznJOqsT3Bbff14KAZR3nOuPfayWMlU9o=;
 b=7tnePioCpzkqUtoiTbwBzVjs2CP4PqQ71Cyz5imO22YLmd2NbiwCDGlN+jL5yRwPBvQFKp
 PPDgWT/FVCXS/SBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2543D13668;
 Thu, 24 Sep 2026 11:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gy/vM5oDtWo/CQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 24 Sep 2026 11:03:55 +0000
Date: Thu, 24 Sep 2026 13:03:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260924110353.GD2364284@pevik>
References: <20260918125021.1939455-1-pvorel@suse.cz>
 <20260918125021.1939455-3-pvorel@suse.cz>
 <arOz8kIcqqlWEdJ6@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arOz8kIcqqlWEdJ6@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] shmctl03: Fix shmmax clamped to INT_MAX in
 32bit compat mode
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

> Hi!
> > Reported-by: Wei Gao <wegao@suse.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > [ pvorel: separate into its own commit, write the commit message ]
> > Co-developed-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/kernel/syscalls/shmctl/shmctl03.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)

> > diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
> > index 9e1c2f0990..0056f2c4b4 100644
> > --- a/testcases/kernel/syscalls/shmctl/shmctl03.c
> > +++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
> > @@ -30,7 +30,11 @@ static void verify_ipcinfo(void)
> >  	else
> >  		tst_res(TPASS, "shmmin = 1");

> > -	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> > +	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
> > +		tst_res(TPASS, "shmmax clamped to INT_MAX in compat mode");

> This should be turned into PATH_KERN_SHMMAX >= INT_MAX check instead of
> printing TPASS blindly.

Right, I'll send a patch which check:

	if (tst_is_compat_mode() && info.shmmax == INT_MAX) {
		unsigned long long shmmax;
		SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%llu", &shmmax);
		TST_EXP_LE_LU(INT_MAX, shmmax);
	} else {
		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
	}

Kind regards,
Petr

> > +	else
> > +		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> > +
> >  	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
> >  	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
> >  }
> > -- 
> > 2.55.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
