Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14086E77180
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 13:00:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93DB03EBDF5
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 14:00:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 732D93EBB90
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 14:00:23 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9F4F71425086
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 14:00:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D9DFF21114;
 Mon, 16 Dec 2024 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734354021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m46g/dj5/dlUsKcfSayq42szLkJtbvyVFelaQA3gpVw=;
 b=jCdRJl2c+V8H4b4JbUO5UCLiSR/u03nRlBm0W9kyRonEw2ZRMgZXaRry3lb11ZMaXjIQ1x
 NgXxBRUkjuLrOrU4Kocaant+Uvooftdj3I/Fn7yoaRfcEPow3/PpXmFmfsAIjR4HT0LPcV
 6i1mKJx25QD56OBeSkREYdo5IuVPPvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734354021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m46g/dj5/dlUsKcfSayq42szLkJtbvyVFelaQA3gpVw=;
 b=XHVS5xOHe7mZ2ndmKIcYx25r+W5wour/aZqEIkv/WfvTG4MSTv2E61JsOmvJVPZilsx7Sg
 1k+qJHCrPBvBOHDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734354021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m46g/dj5/dlUsKcfSayq42szLkJtbvyVFelaQA3gpVw=;
 b=jCdRJl2c+V8H4b4JbUO5UCLiSR/u03nRlBm0W9kyRonEw2ZRMgZXaRry3lb11ZMaXjIQ1x
 NgXxBRUkjuLrOrU4Kocaant+Uvooftdj3I/Fn7yoaRfcEPow3/PpXmFmfsAIjR4HT0LPcV
 6i1mKJx25QD56OBeSkREYdo5IuVPPvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734354021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m46g/dj5/dlUsKcfSayq42szLkJtbvyVFelaQA3gpVw=;
 b=XHVS5xOHe7mZ2ndmKIcYx25r+W5wour/aZqEIkv/WfvTG4MSTv2E61JsOmvJVPZilsx7Sg
 1k+qJHCrPBvBOHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7333137CF;
 Mon, 16 Dec 2024 13:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Opa9LmUkYGcDVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 16 Dec 2024 13:00:21 +0000
Date: Mon, 16 Dec 2024 14:00:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z2AkZabEU12gomtZ@yuki.lan>
References: <20241212060448.204158-1-liwang@redhat.com>
 <20241213224041.GB1577592@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241213224041.GB1577592@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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
> > +	TST_KCONFIG_INIT("CONFIG_KASAN"),
> > +	TST_KCONFIG_INIT("CONFIG_SLUB_RCU_DEBUG"),
> > +	TST_KCONFIG_INIT("CONFIG_TRACE_IRQFLAGS"),
> > +	TST_KCONFIG_INIT("CONFIG_LATENCYTOP"),
> > +	TST_KCONFIG_INIT("CONFIG_DEBUG_NET"),
> > +	TST_KCONFIG_INIT("CONFIG_EXT4_DEBUG"),
> > +	TST_KCONFIG_INIT("CONFIG_QUOTA_DEBUG"),
> > +	TST_KCONFIG_INIT("CONFIG_FAULT_INJECTION"),
> > +	TST_KCONFIG_INIT("CONFIG_DEBUG_OBJECTS")
> > +};
> > +
> > +int tst_has_slow_kconfig(void)
> > +{
> > +	unsigned int i;
> > +
> > +	tst_kconfig_read(slow_kconfigs, ARRAY_SIZE(slow_kconfigs));
> > +
> Maybe here TINFO message "checking for options which slow the execution?
> Or print it (once) only if option detected? Because it's not obvious why we are
> detecting it. Or after searching print what we did (4x prolonged runtime).
>
> > +	for (i = 0; i < ARRAY_SIZE(slow_kconfigs); i++) {
> > +		if (slow_kconfigs[i].choice == 'y') {
> > +			tst_res(TINFO,
> > +				"%s kernel option detected",
> > +				slow_kconfigs[i].id);
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 8db554dea..f4e667240 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -555,6 +555,9 @@ static int multiply_runtime(int max_runtime)
> 
> >  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
> 
> > +	if (tst_has_slow_kconfig())
> > +		max_runtime *= 4;
> Maybe note here what we do? (TINFO)

That really depends on how verbose we want to be, we already print the
overall test timeout which is timeout + runtime. So it's somehow visible
in the test runtime has been increased. Maybe we should make the info
message in set_timeout() better by printing the runtime separately there
if non-zero.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
