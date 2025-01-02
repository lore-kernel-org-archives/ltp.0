Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44E5E77188
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 14:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 324483EFECA
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 15:31:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 203C73EFDFB
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 15:31:14 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 193C66111AE
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 15:31:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8822A211F3;
 Thu,  2 Jan 2025 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735828272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcXTzaHQ+oIu6vvu41uasZ8/WuqHOC2eaB+cXc2BoIY=;
 b=NM0+Ibgqxmy1TeiuGyqzFAKGLDFYksbADECPdX9Ein6GAARcUDMBzwee8Zw11C7I1qolo0
 ZFHl8KqZnzaJLHy4R8rczj8RAV0whLD563tVcUA3NuJMxSRyrIYiO2o5jzm7hXGm77OuT7
 7Y9M+4nOc8zUlCt2Cm7fSKDy7GLrGs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735828272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcXTzaHQ+oIu6vvu41uasZ8/WuqHOC2eaB+cXc2BoIY=;
 b=+8sTDf9HXG1K3udm530cpPCSDDVO1HR1ngajcSVPXmtaxPYSnTqNpeOouxJHf5dMHkOn4p
 EZ1ZIltGd1vhLYBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735828272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcXTzaHQ+oIu6vvu41uasZ8/WuqHOC2eaB+cXc2BoIY=;
 b=NM0+Ibgqxmy1TeiuGyqzFAKGLDFYksbADECPdX9Ein6GAARcUDMBzwee8Zw11C7I1qolo0
 ZFHl8KqZnzaJLHy4R8rczj8RAV0whLD563tVcUA3NuJMxSRyrIYiO2o5jzm7hXGm77OuT7
 7Y9M+4nOc8zUlCt2Cm7fSKDy7GLrGs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735828272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZcXTzaHQ+oIu6vvu41uasZ8/WuqHOC2eaB+cXc2BoIY=;
 b=+8sTDf9HXG1K3udm530cpPCSDDVO1HR1ngajcSVPXmtaxPYSnTqNpeOouxJHf5dMHkOn4p
 EZ1ZIltGd1vhLYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5847B13418;
 Thu,  2 Jan 2025 14:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EQP/EjCjdme+FQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Jan 2025 14:31:12 +0000
Date: Thu, 2 Jan 2025 15:31:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
Message-ID: <20250102143106.GA87474@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20241222072251.13150-2-liwang@redhat.com>
 <20250102125653.GB81987@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250102125653.GB81987@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] starvation: skip test on slow kernel
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Li,

> > Systems with slow kernel configurations may not meet
> > the performance requirements necessary for the starvation
> > test to produce valid results.

> > Skipping the test ensures that it runs only on systems
> > where its results are meaningful.
> ...
> > +	if (tst_has_slow_kconfig())
> > +		tst_brk(TCONF, "Skip test due to slow kernel configuration");
> > +

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> I suppose you have strong reason for this (e.g. it's failing on some slow
> machine). I'm testing it on emulated riscv64 to see whether it's needed to be
> skipped. Because due CONFIG_LATENCYTOP it will always be skipped on Tumbleweed.

OK, I was able to reproduce TFAIL on emulated riscv64, which runs ~ 4m 30s, with
timeout increased to 0h 05m 46s:

tst_tmpdir.c:316: TINFO: Using /tmp/LTP_sta3UIB6E as tmpdir (tmpfs filesystem)
tst_test.c:1893: TINFO: LTP version: 20240930
tst_test.c:1897: TINFO: Tested kernel: 6.12.6-1-default #1 SMP PREEMPT_DYNAMIC Thu Dec 19 17:23:25 UTC 2024 (fb072de) riscv64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
tst_test.c:1728: TINFO: Timeout per run is 0h 02m 00s
starvation.c:98: TINFO: Setting affinity to CPU 0
starvation.c:52: TINFO: CPU did 120000000 loops in 226566us
tst_test.c:1736: TINFO: Updating max runtime to 0h 03m 46s
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
tst_test.c:1728: TINFO: Timeout per run is 0h 05m 46s
starvation.c:148: TFAIL: Scheduller starvation reproduced.

But it works on emulated x86_64.

tst_tmpdir.c:316: TINFO: Using /tmp/LTP_staIt0g73 as tmpdir (tmpfs filesystem)
tst_test.c:1893: TINFO: LTP version: 20240930-148-g4539bfbc7
tst_test.c:1897: TINFO: Tested kernel: 6.13.0-rc4-1.g4a5c6a6-default #1 SMP PREEMPT_DYNAMIC Sun Dec 22 22:11:35 UTC 2024 (4a5c6a6) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
tst_test.c:1728: TINFO: Timeout per run is 0h 02m 00s
starvation.c:98: TINFO: Setting affinity to CPU 0
starvation.c:52: TINFO: CPU did 120000000 loops in 34189us
tst_test.c:1736: TINFO: Updating max runtime to 0h 00m 34s
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
tst_test.c:1728: TINFO: Timeout per run is 0h 02m 34s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

I wonder if we can quit with TCONF only on certain runtime increase. We would
also need to take -l (number of loops into an account).

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
