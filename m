Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24D9CD4F24
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 10:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FB813E220A
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 12:54:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9CC13D0536
 for <ltp@lists.linux.it>; Wed, 13 May 2026 12:54:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4B29B6009E3
 for <ltp@lists.linux.it>; Wed, 13 May 2026 12:54:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9CB8E75E14;
 Wed, 13 May 2026 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778669662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kGckKT+NCuPfU3BF1fGYS4/LoP5kICzLC6KByjoMuts=;
 b=sClq+UP7M6wR5chr8BYKhQkRpFKQ/a02281D8VMy3ZfRy9Bc2LLd216iuUoHdYRUAMX3SK
 Mn3b1q++/ztnHimKP2wGTqC22xvOALrwMz8cd+43NqUbtbTL6WihZAg6c14Y0Wdn/SyPdv
 QJ4g/RHZgPm2qV+fcfPvu+3pLkvV6Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778669662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kGckKT+NCuPfU3BF1fGYS4/LoP5kICzLC6KByjoMuts=;
 b=+22x4mYHLJf/mtzS/e4jmEyyuQr6UvJijTCuvW2b+JidVhx+f1wPofCzFk+PlJGvfLrAp5
 e8Ft+6jjTXd5z0Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sClq+UP7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+22x4mYH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778669662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kGckKT+NCuPfU3BF1fGYS4/LoP5kICzLC6KByjoMuts=;
 b=sClq+UP7M6wR5chr8BYKhQkRpFKQ/a02281D8VMy3ZfRy9Bc2LLd216iuUoHdYRUAMX3SK
 Mn3b1q++/ztnHimKP2wGTqC22xvOALrwMz8cd+43NqUbtbTL6WihZAg6c14Y0Wdn/SyPdv
 QJ4g/RHZgPm2qV+fcfPvu+3pLkvV6Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778669662;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kGckKT+NCuPfU3BF1fGYS4/LoP5kICzLC6KByjoMuts=;
 b=+22x4mYHLJf/mtzS/e4jmEyyuQr6UvJijTCuvW2b+JidVhx+f1wPofCzFk+PlJGvfLrAp5
 e8Ft+6jjTXd5z0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FA89593A9;
 Wed, 13 May 2026 10:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GIFaFl5YBGoJQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 May 2026 10:54:22 +0000
Date: Wed, 13 May 2026 12:54:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260513105417.GC318856@pevik>
References: <20260506112420.67516-2-piotr.kubaj@intel.com>
 <agL5X898iY6MXK75@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <agL5X898iY6MXK75@yuki.lan>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9CB8E75E14
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v19] thermal: add new test group
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > +static void setup(void)
> > +{
> > +	char line[8192];
> > +
> > +	nproc = tst_ncpus();
> > +	tst_set_runtime(nproc * TEST_RUNTIME);

> The last thing that I do not think is correct is this part. We are
> setting the runtime here based on the number of CPUs and not based on
> the number of actuall test iterations.

> I guess that we need to:

>   Turn the x86_pkg_temp_tz_found into a counter and collect the number
>   of thermal zones found and set the runtime at the end of the setup
>   with the counter instead.

> And at the same time the TEST_RUNTIME appears to be significantly
> smaller than the actual runtime.

>   The upper bound for the runtime is a sum of all possible iterations,
>   if we simplify it a bit it would be roughly ((RUNTIME+SLEEPTIME) *
>   (SLEEPTIME/2))

>   As we are doing SLEEPTIME iterations with SLEEPTIME and RUNTIME
>   getting smaller in each of them so it will average out to SLEEPTIME/2
>   iterations with full (RUNTIME+SLEEPTIME)

>   So I guess that we need:

>   #define TEST_RUNTIME ((RUNTIME+SLEEPTIME) * (SLEEPTIME/2))

And other thing which is on my machine broken is to run with more iterations, it
randomly fails or get stuck after first iteration:

./thermal_interrupt_events -i3
thermal_interrupt_events.c:207: TINFO: CPU 23 interrupt counter: 23 (previous: 21)
thermal_interrupt_events.c:217: TPASS: x86 package thermal interrupt triggered
thermal_interrupt_events.c:142: TINFO: Testing /sys/class/thermal/thermal_zone9/temp
thermal_interrupt_events.c:213: TFAIL: No thermal interrupt increase detected

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
