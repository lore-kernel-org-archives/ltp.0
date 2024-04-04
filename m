Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B274BCD1292
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 12:56:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CD8A3CE3F3
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 14:56:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9E9B3CE386
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:56:22 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13B4C200C79
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:56:21 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 805625D976;
 Thu,  4 Apr 2024 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712235380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXKXERHAbmSU6SneIzS5/ZBSu4FU8LrgK2P5YlJxnpw=;
 b=Jn08qyBnde154Fl9AqmOEJW5DL4WzfVp2axAi/4K0giCjz3pQ5up2+Sggiquzt8ETPHRp4
 /tGmCzejV1372NvP6smfWdbU8xq0n5Q2mhRgRczoG34SFX8gG5AO6ywHwqTvliYdhgLN98
 Muy3pIfEyb7axnsMT9+cMzjF6j4ZE4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712235380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXKXERHAbmSU6SneIzS5/ZBSu4FU8LrgK2P5YlJxnpw=;
 b=Q3Ay3kCt0LQrNMGlJuTW/iWWRJUu84yBCa5+RW45qbOcsqzJrs20hwJ239iOijjx1ZXCwe
 bCHrfXP8u5EwcgCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712235379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXKXERHAbmSU6SneIzS5/ZBSu4FU8LrgK2P5YlJxnpw=;
 b=LKb60lra0yeB26ov0Prlacraf5sFT7syYAva25err/aDgd5I5orM9TeHQRzCUjR1oSZ4Gd
 shHQEVQ4hUL7fJKnnoSNArImjub9SB0Q6WtZVOmZ6UgowGFSRQ11anc2BcqMzZhuPGkBos
 aW93DCZOI59Ro2oIbKQLr5p+lAcTm5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712235379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXKXERHAbmSU6SneIzS5/ZBSu4FU8LrgK2P5YlJxnpw=;
 b=i21mOHbGpN1XD0u4+V8TToOsc8txgrCmnIHz8XnTXIImgWxhg1hN+fMD2YztVb4yT4dXgC
 L4YocmPIP5WWLVDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6392D139E8;
 Thu,  4 Apr 2024 12:56:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id TlEiFnOjDmZeaQAAn2gu4w
 (envelope-from <chrubis@suse.cz>); Thu, 04 Apr 2024 12:56:19 +0000
Date: Thu, 4 Apr 2024 14:55:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zg6jOZjxGGHKkS-0@yuki>
References: <20240403082618.5829-1-chrubis@suse.cz>
 <20240403082618.5829-3-chrubis@suse.cz>
 <20240404125124.GC503552@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240404125124.GC503552@pevik>
X-Spamd-Result: default: False [-4.80 / 50.00]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 BAYES_HAM(-0.00)[30.78%]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,
 imap2.dmz-prg2.suse.org:rdns, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] include: doc: Convert comments into
 linuxdoc
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
> Very nit: I would prefer if the formatting would not force the indent, e.g.:
> 
>  * @tcnt: A number of tests. If set the test() callback is called tcnt times
>  * and each time passed an increasing counter value.
> 
> Because variables with long name will require more lines, but feel free to
> ignore it.

I do not have a strong opinion here, but I guess that we should add at
least a single space before the subsequent lines so that it's clear that
it's a continuation.

Does anyone else have an opinion on this?

> > + * @options: An NULL optstr terminated array of struct tst_option.
> > + *
> > + * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
> > + *
> > + * @supported_archs: A NULL terminated array of architectures the test runs on
> > + *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arch() to
> > + *                   check if current CPU architecture is supported and exits
> > + *                   the test with TCONF if it's not.
> > + *
> 
> ...
> >  	void (*setup)(void);
> >  	void (*cleanup)(void);
> > -
> >  	void (*test)(unsigned int test_nr);
> >  	void (*test_all)(void);
> 
> > -	/* Syscall name used by the timer measurement library */
> We decided to drop this comment. Isn't it useful?
> >  	const char *scall;
> > -
> > -	/* Sampling function for timer measurement testcases */
> >  	int (*sample)(int clk_id, long long usec);
> And this one as well.

The sampling is a kind of hack, I would like to rethink it a bit if it
can't be done in a cleaner way before documenting it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
