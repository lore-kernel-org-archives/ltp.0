Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3D5C4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 13:08:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84D063CC5A1
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 14:08:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB4463C714A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:08:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19383600680
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:08:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 037D01F6E6;
 Tue, 29 Nov 2022 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669727311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlQX8kvcMplyMEOaGhjffZx6fTZp8OTq3CAX3tp6H0s=;
 b=gYE71TA+Ti57UclWTMXCCm5UOMpPz5b1EZNSo73vY6dEtkTWVfChaCFgRsiscBrpIOTD7j
 sbL0AhydI0w1iyYeUFV1kvTvkhydMi9/VeZ5xojVRBoSlix9yim6cmoSBZWMmvoh0D4Xdp
 OmtknEb46QXoSWarplckM9Mw7W6sMIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669727311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlQX8kvcMplyMEOaGhjffZx6fTZp8OTq3CAX3tp6H0s=;
 b=bYhRReAqez+9UlLCnS5KsKRoJIIy84NOTmH90I9Qd9w36vJKPIc127vNrxujwqds1x+kAl
 bQkiFNLO34klP0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E16E713AF6;
 Tue, 29 Nov 2022 13:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YpqhNE4EhmP2JAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 29 Nov 2022 13:08:30 +0000
Date: Tue, 29 Nov 2022 14:09:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y4YEnmDLD7AEMHrr@yuki>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
 <Y4UMUqkLijWXOWu6@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4UMUqkLijWXOWu6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/1] brk: use direct syscalls
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
> void verify_brk(void)
> {
> 	if (tst_variant) {
> 		tst_res(TINFO, "Testing sbrk()");
> 		cur_brk = (uintptr_t)sbrk(0);
> 	} else {
> 		tst_res(TINFO, "Testing __NR_brk");
> 		cur_brk = (void *)tst_syscall(__NR_brk, 0);
> 	}
> 
> }
> 
> struct tst_test test = {
> 	...
> #ifdef __GLIBC__
> 	.test_variants = 2,
> #else
> 	.test_variants = 1,
> #endif
> 	...
> 
> Not sure if it should be testeed also on android, i.e:
> #if defined(__GLIBC__) || defined(__ANDROID__)

Can we rather than ifdefing things out check the actual return values?

Should be as easy as doing:

	if (cur_brk == (void*)-1)
		tst_brk(TCONF, "sbrk() not implemented");

in the libc test variant.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
