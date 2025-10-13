Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1EFCCD183
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 15:01:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCAD13CEC59
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 17:01:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6F693C840D
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 17:00:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2910260093C
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 17:00:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AD6D2128E;
 Mon, 13 Oct 2025 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760367654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHeqvnlCxiBgoFgGNDl1ygEgO2oYi/A5+83N8ySw/sw=;
 b=rrCiR6+7w4KHA6E3gfRVsw7nOSi/FNmfuIBE1G4ooRXkR9R1RoD99ErQQG7Ic1bCE3fybf
 +XQm7Ng7uCq9aDSnWJpDrga2Fi34l5F08b/p+yXD6kUCHjlhNGvfS9NJvPBTlqjUbdW7aq
 qhst36sCW6v+FY88g8aZhWBUQ99IGig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760367654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHeqvnlCxiBgoFgGNDl1ygEgO2oYi/A5+83N8ySw/sw=;
 b=RS/KN882mywGNjRztYqRusB6/Npfd0Pc7am8sjPQj65nmvnyXYLmmR3XiVoZU0eErGDIXG
 6TqTzMCfXqdW+lDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760367654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHeqvnlCxiBgoFgGNDl1ygEgO2oYi/A5+83N8ySw/sw=;
 b=rrCiR6+7w4KHA6E3gfRVsw7nOSi/FNmfuIBE1G4ooRXkR9R1RoD99ErQQG7Ic1bCE3fybf
 +XQm7Ng7uCq9aDSnWJpDrga2Fi34l5F08b/p+yXD6kUCHjlhNGvfS9NJvPBTlqjUbdW7aq
 qhst36sCW6v+FY88g8aZhWBUQ99IGig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760367654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHeqvnlCxiBgoFgGNDl1ygEgO2oYi/A5+83N8ySw/sw=;
 b=RS/KN882mywGNjRztYqRusB6/Npfd0Pc7am8sjPQj65nmvnyXYLmmR3XiVoZU0eErGDIXG
 6TqTzMCfXqdW+lDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3EA81374A;
 Mon, 13 Oct 2025 15:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e29lNSUU7WhKOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Oct 2025 15:00:53 +0000
Date: Mon, 13 Oct 2025 17:00:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20251013150052.GB97127@pevik>
References: <20251010090426.2243464-1-ben.copeland@linaro.org>
 <081171be-d613-473a-9e72-6ff603d96dc4@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <081171be-d613-473a-9e72-6ff603d96dc4@app.fastmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo]; 
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,arndb.de:email,linaro.org:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] overcommit_memory: Fix integer overflow and
 32-bit limits
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
Cc: lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Fri, Oct 10, 2025, at 11:04, Ben Copeland wrote:
> > The overcommit test uses sum_total, the sum (memory and swap) to test
> > the overcommit settings.

> > This fixes two problems on 32-bit systems. The first is seen with a
> > integer overflow can occur when calculating sum_total * 2, if the
> > sum_total is larger than 2GB. The second is limited virtual address
> > space (2-3GB) means the test can fail from address space exhaustion
> > before overcommit has been tested.

> > Now the test runs correctly on low-memory 32-bit systems while avoiding
> > both the overflow bug and virtual address space issues.

Thanks for looking into the issue.

> > Signed-off-by: Ben Copeland <ben.copeland@linaro.org>

> The logic makes sense to me.

> Acked-by: Arnd Bergmann <arnd@arndb.de>

> >  	update_mem();
> >  	alloc_and_check(free_total / 2, EXPECT_PASS);
> > -	alloc_and_check(sum_total * 2, EXPECT_FAIL);
> > +	/* Skip if sum_total * 2 would exceed address space.
> > +	 * On 32-bit, skip when sum_total > ULONG_MAX/4 (~1GB).
> > +	 * Most 32-bit systems with <=1GB RAM can map 2x that in 3GB vaddr space.
> > +	 * Systems with 2GB+ RAM likely cannot fit allocations in vaddr space. */
> > +	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= ONE_GB) {

Why not use TST_GB instead of creating new constant ONE_GB?

> >  #define ONE_GB                 (1024 * 1024 * TST_KB)

Maybe even use static variable holding the condition and set it in setup()?

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > +		alloc_and_check(sum_total * 2, EXPECT_FAIL);
> > +	} else {
> > +		tst_res(TCONF, "Skipping large allocation test due to address space limits");
> > +	}

> It would be nice if it was possible to express this in terms of
> the kernel's TASK_SIZE constant and not have to check for
> 64-bit kernels.

> Unfortunately I have not been able find TASK_SIZE from userspace
> directly other than maybe probing MAP_FIXED mmap() calls which
> would be overly complicated. Your approach is probably as 
> good as it gets.

Thanks for your time!

BTW in our case (openSUSE Tumbleweed 32 bit) it fails on commit_left,
which is slightly smaller:
commit_left: 2221904
sum_total: 2884328

tst_kernel.c:90: TINFO: uname.machine=i686 kernel is 32bit
tst_test.c:2021: TINFO: LTP version: 20251010.79b7f212
tst_test.c:2024: TINFO: Tested kernel: 6.17.1-1-default #1 SMP PREEMPT_DYNAMIC Tue Oct  7 04:26:30 UTC 2025 (1bf5c2e) i686
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1842: TINFO: Overall timeout per run is 0h 02m 00s
overcommit_memory.c:103: TINFO: MemTotal is 2050380 kB
overcommit_memory.c:105: TINFO: SwapTotal is 2098152 kB
overcommit_memory.c:109: TINFO: CommitLimit is 3121292 kB
overcommit_memory.c:122: TINFO: Setting /proc/sys/vm/overcommit_ratio to 50
overcommit_memory.c:125: TINFO: TotalBatchSize is 8008 kB
overcommit_memory.c:131: TINFO: Setting /proc/sys/vm/overcommit_memory to 2
overcommit_memory.c:161: TINFO: malloc 5738112 kB successfully
overcommit_memory.c:188: TFAIL: alloc passed, expected to fail
overcommit_memory.c:165: TINFO: malloc 3129300 kB failed
overcommit_memory.c:186: TPASS: alloc failed as expected
overcommit_memory.c:161: TINFO: malloc 1434528 kB successfully
overcommit_memory.c:180: TPASS: alloc passed as expected
overcommit_memory.c:140: TINFO: Setting /proc/sys/vm/overcommit_memory to 0
overcommit_memory.c:161: TINFO: malloc 1804260 kB successfully
overcommit_memory.c:180: TPASS: alloc passed as expected
overcommit_memory.c:165: TINFO: malloc 8297064 kB failed
overcommit_memory.c:186: TPASS: alloc failed as expected
overcommit_memory.c:147: TINFO: Setting /proc/sys/vm/overcommit_memory to 1
overcommit_memory.c:161: TINFO: malloc 2074266 kB successfully
overcommit_memory.c:180: TPASS: alloc passed as expected
overcommit_memory.c:165: TINFO: malloc 4148532 kB failed
overcommit_memory.c:182: TFAIL: alloc failed, expected to pass
overcommit_memory.c:165: TINFO: malloc 8297064 kB failed
overcommit_memory.c:182: TFAIL: alloc failed, expected to pass

Kind regards,
Petr

>       Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
