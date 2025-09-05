Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490E4CA1013
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 14:59:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1DDA3CD51B
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 16:59:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87D5C3CD4F0
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 16:58:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 320C3200905
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 16:58:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C32434ECAD;
 Fri,  5 Sep 2025 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757084326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukag1teg3RZVae5nZnCZ3rAVejxfDEFqE8rpY+jOVuE=;
 b=Gxa4c3tCyVjYWvY0Vjv/HQPUf3dcgEj1PcEXHXOn8CfHd8uJKvmrRfCI+UuJ0po0gsHkaG
 uMzdYzI39I3mj4Q/FaIDF9YdluAkUnUk7+PBgG/z0lGs4L0qtpZSZ1/YEEMhBM4qcKIKNb
 fZpY7iozcjraCtt4O9Bz/eed9gQkD5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757084326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukag1teg3RZVae5nZnCZ3rAVejxfDEFqE8rpY+jOVuE=;
 b=wSR0oLPWYcFV7KAf8wphna9cnxhbd/RppAPtIPVikupJuAqfbrtctQqNLVeFCmFPFIQriy
 cjYYqgjXZBLEUvCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1757084326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukag1teg3RZVae5nZnCZ3rAVejxfDEFqE8rpY+jOVuE=;
 b=Gxa4c3tCyVjYWvY0Vjv/HQPUf3dcgEj1PcEXHXOn8CfHd8uJKvmrRfCI+UuJ0po0gsHkaG
 uMzdYzI39I3mj4Q/FaIDF9YdluAkUnUk7+PBgG/z0lGs4L0qtpZSZ1/YEEMhBM4qcKIKNb
 fZpY7iozcjraCtt4O9Bz/eed9gQkD5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1757084326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukag1teg3RZVae5nZnCZ3rAVejxfDEFqE8rpY+jOVuE=;
 b=wSR0oLPWYcFV7KAf8wphna9cnxhbd/RppAPtIPVikupJuAqfbrtctQqNLVeFCmFPFIQriy
 cjYYqgjXZBLEUvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2A2913306;
 Fri,  5 Sep 2025 14:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OGAfK6b6umhQEQAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 05 Sep 2025 14:58:46 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 05 Sep 2025 16:58:46 +0200
Message-ID: <6198941.lOV4Wx5bFT@thinkpad>
In-Reply-To: <aLrFpxYykjYbDUAO@yuki.lan>
References: <20250905084608.11958-1-akumar@suse.de> <aLrFpxYykjYbDUAO@yuki.lan>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; CTE_CASE(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add tst_get_max_clocks() routine based on
 tst_kconfig_check()
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

On Friday, September 5, 2025 1:12:39 PM CEST Cyril Hrubis wrote:
> Hi!
> > +int tst_get_max_clocks(void)
> > +{
> > +	static const char * const kconf_aux[] = {"CONFIG_POSIX_AUX_CLOCKS=y", NULL};
> > +
> > +	if (!tst_kconfig_check(kconf_aux))
> > +		return MAX_CLOCKS + MAX_AUX_CLOCKS;
> > +	else
> > +		return MAX_CLOCKS;
> > +}
> > diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
> > index 0c5e6ac21..ba62bf716 100644
> > --- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
> > +++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
> > @@ -76,11 +76,11 @@ struct test_case {
> >  
> >  struct test_case tc[] = {
> >  	{
> > -	 .clktype = TST_MAX_CLOCKS,
> > +	 .clktype = 0,
> >  	 .exp_err = EINVAL,
> >  	},
> >  	{
> > -	 .clktype = TST_MAX_CLOCKS + 1,
> > +	 .clktype = 0,
> >  	 .exp_err = EINVAL,
> >  	},
> >  	{
> > @@ -223,6 +223,9 @@ static void setup(void)
> >  			tc[i].lowlimit /= hz;
> >  		}
> >  	}
> > +
> > +	tc[0].clktype = tst_get_max_clocks();
> > +	tc[1].clktype = tst_get_max_clocks() + 1;
> 
> We usually frown upon hardcoded array indexes. There are couple of ways
> how to avoid that. The easiest is probably to store a pointers to clock
> types instead of the values in the test_case structure. Have a look at
> how we pass the fd in accept01.c for an example.
> 
> 
Hi Cyril,

Thank you for suggesting the right approach. I have sent v2.

Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
