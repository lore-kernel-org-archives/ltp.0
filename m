Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D64C30653
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 14:49:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 129133D3CF7
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 16:49:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 141483D0F50
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 16:48:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2B3EB600730
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 16:48:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C1A021AF3;
 Thu,  4 Jul 2024 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720104535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBb857y+sZv7vHj5b5vbjO8RdT3hQhmwHv5roUAWj20=;
 b=RJKiXBzcpyvUM2GrddbC7vBJf3yn2mspuNw0N9mefCEpFzpJfG79+mwK52JaW+S32dFR3M
 mHybLQOulvpcEaMKYeNAfqpSPwcHq/LO9scuLVs7dPWy/2YCyftMh+6WBjEihWIWRtFniz
 hn9utZILHfcjxTw11EWt6wa5MkORtC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720104535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBb857y+sZv7vHj5b5vbjO8RdT3hQhmwHv5roUAWj20=;
 b=TVLNcnp5Ue2M7SbzqX6LjodfdP4ky6edp2FJkpqy+MBjky5/7DG3zDNMxEhx/5Ioebr9J+
 kBZeDScnHWZgRzAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RJKiXBzc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TVLNcnp5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720104535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBb857y+sZv7vHj5b5vbjO8RdT3hQhmwHv5roUAWj20=;
 b=RJKiXBzcpyvUM2GrddbC7vBJf3yn2mspuNw0N9mefCEpFzpJfG79+mwK52JaW+S32dFR3M
 mHybLQOulvpcEaMKYeNAfqpSPwcHq/LO9scuLVs7dPWy/2YCyftMh+6WBjEihWIWRtFniz
 hn9utZILHfcjxTw11EWt6wa5MkORtC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720104535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBb857y+sZv7vHj5b5vbjO8RdT3hQhmwHv5roUAWj20=;
 b=TVLNcnp5Ue2M7SbzqX6LjodfdP4ky6edp2FJkpqy+MBjky5/7DG3zDNMxEhx/5Ioebr9J+
 kBZeDScnHWZgRzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B81813889;
 Thu,  4 Jul 2024 14:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E3wvFVe2hmZHNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Jul 2024 14:48:55 +0000
Date: Thu, 4 Jul 2024 16:48:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <Zoa2TxNlIwdWW39S@yuki>
References: <20240612121106.11127-1-chrubis@suse.cz>
 <20240612121106.11127-2-chrubis@suse.cz>
 <3575698.dWV9SEqChM@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3575698.dWV9SEqChM@localhost>
X-Rspamd-Queue-Id: 6C1A021AF3
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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
> >  /**
> >   * struct tst_test - A test description.
> >   *
> > @@ -377,29 +407,22 @@ struct tst_ulimit_val {
> >   *
> >   * @dev_min_size: A minimal device size in megabytes.
> >   *
> > - * @dev_fs_type: If set overrides the default file system type for the device and
> > - *               sets the tst_device.fs_type.
>  * @format_device: Does all tst_test.needs_device would do and also formats
>  *                 the device with tst_test.dev_fs_type file system as well.
> We should also update 'format_device' documentation according to these changes.

I've removed the tst_test.dev_fs_type and kept it just as "... with file
system as well."

> > - *
> > - * @dev_fs_opts: A NULL terminated array of options passed to mkfs in the case
> > - *               of 'tst_test.format_device'. These options are passed to mkfs
> > - *               before the device path.
> > - *
> ...
> ...
> > @@ -1160,6 +1160,38 @@ static void set_ulimit_(const char *file, const int lineno, const struct tst_uli
> >  	safe_setrlimit(file, lineno, conf->resource, &rlim);
> >  }
> >  
> > +static unsigned int count_fs_descs(void)
> > +{
> > +	unsigned int ret = 0;
> > +
> > +	if (!tst_test->filesystems)
> > +		return 0;
> > +
> > +	/*
> > +	 * First entry is special, if it has zero type is the it's the default
> this sentence seems a bit off.
> 
> with these,
> Reviewed-by: Avinesh Kumar <akumar@suse.de>
> for both patches.

Fixed this one as well and pushed.

Thanks everyone for the reviews!

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
