Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE82C4332F
	for <ltp@archiver.kernel.org>; Wed, 13 Dec 2023 23:41:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AE143CF559
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 00:40:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B10873CE5B8
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 00:40:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6848200965
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 00:40:46 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C24B61F792;
 Wed, 13 Dec 2023 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702510845;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSePSHXoX+Pxy6pL4y8IGrvFAsYxr5NZrUvvCoQpTnk=;
 b=f+HKQQDhOdbVU5mOItn+vSv6A2ObE4pPE9whIvJSztw4z4hLCbOXI88ez3W9HP5BmwaILV
 VP6Eqr563uPxdBiE/bt42tlPGWLfNJ84BUocTB4Hpf234gvOo7z5Z3wSCjSzC22uQf6Qsg
 glAqaMtaGtBt7OG2317SGDyku5M7iYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702510845;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSePSHXoX+Pxy6pL4y8IGrvFAsYxr5NZrUvvCoQpTnk=;
 b=oWATqILbYWSRe1WAunADk+pxWx0E8fB5xWY4z8YNHUuoif7EJ7MHlYoHlRGdDcWiiM2eVP
 vbIspwyetYvcqfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702510845;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSePSHXoX+Pxy6pL4y8IGrvFAsYxr5NZrUvvCoQpTnk=;
 b=f+HKQQDhOdbVU5mOItn+vSv6A2ObE4pPE9whIvJSztw4z4hLCbOXI88ez3W9HP5BmwaILV
 VP6Eqr563uPxdBiE/bt42tlPGWLfNJ84BUocTB4Hpf234gvOo7z5Z3wSCjSzC22uQf6Qsg
 glAqaMtaGtBt7OG2317SGDyku5M7iYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702510845;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSePSHXoX+Pxy6pL4y8IGrvFAsYxr5NZrUvvCoQpTnk=;
 b=oWATqILbYWSRe1WAunADk+pxWx0E8fB5xWY4z8YNHUuoif7EJ7MHlYoHlRGdDcWiiM2eVP
 vbIspwyetYvcqfCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7244513240;
 Wed, 13 Dec 2023 23:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id F4thGv1AemX6QQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 13 Dec 2023 23:40:45 +0000
Date: Thu, 14 Dec 2023 00:40:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231213234044.GA774490@pevik>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-2-pvorel@suse.cz> <ZXoAKxPxfXxU8bxw@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXoAKxPxfXxU8bxw@rei>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[32.08%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib/tests: Add test for testing tst_res()
 flags
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > +#define FLAG(x) .flag = x, .str = #x
> > +static struct tcase {
> > +	int flag;
> > +	const char *str;
> > +} tcases[] = {
> > +	{FLAG(TPASS)},
> > +	{FLAG(TFAIL)},
> > +	{FLAG(TBROK)},
> > +	{FLAG(TCONF)},
> > +	{FLAG(TWARN)},
> > +	{FLAG(TINFO)},
> > +};
> > +
> > +static void do_cleanup(void)
> > +{
> > +	tst_brk(TBROK, "TBROK message should be TWARN in cleanup");
> > +}
> > +
> > +static void do_test(unsigned int n)
> > +{
> > +	int flag = tcases[n].flag;
> > +	const char *str = tcases[n].str;
> > +
> > +	tst_res(flag, "%s message", str);
> > +
> > +	if (flag == TWARN || flag == TINFO)
> > +		tst_res(TPASS, "%s message is not a result", str);

> Maybe it would make sense the loop over the flags here instead, so that
> we don't have to produce second TPASS message.

I'm not sure if I follow you. I wanted to use the flag in tst_res(),
but for these two there would be tst_brk(TBROK) due missing result.

Kind regards,
Petr

> > +}
> > +
> > +static struct tst_test test = {
> > +	.test = do_test,
> > +	.tcnt = ARRAY_SIZE(tcases),
> > +	.cleanup = do_cleanup,
> > +};
> > -- 
> > 2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
