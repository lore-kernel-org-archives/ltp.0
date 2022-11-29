Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECE0C4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 13:36:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0A4F3CC5CA
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 14:36:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7433C85AE
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:36:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F388E1A00706
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:36:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E02D521BE6;
 Tue, 29 Nov 2022 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669729003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yF4/XlHExdUNiogUn61U8nXo8UMobX+lsmPkjBmpbxU=;
 b=iUxijNFAAqsxp+ZnKLTKwECNySFtFuRh1GDUuFiBJfXaaOI8zUMjMhNNA+6IEOG+89KKNP
 Myvqtig/nzzHkZtaLRKZ2wEpOC78cO6CRENiWo00cgkTKbCbTJN1eXfThZHoGrx+BwZyTX
 TEhymQBd9hxoHZu5K2iPgWoRhZ/c8i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669729003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yF4/XlHExdUNiogUn61U8nXo8UMobX+lsmPkjBmpbxU=;
 b=gSHUdQrmRzxUiyY4xseJvtBiDBh5ijte28kO6Vk5Q9y3+9B5c4p2cB/tmJiFf6aDL/rgF1
 UhCTuoVKqGdCSqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B336813AF6;
 Tue, 29 Nov 2022 13:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IuSkKesKhmOWNAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 29 Nov 2022 13:36:43 +0000
Date: Tue, 29 Nov 2022 14:36:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y4YK6uhK94C0vrVR@pevik>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
 <Y4UMUqkLijWXOWu6@pevik> <Y4YEnmDLD7AEMHrr@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4YEnmDLD7AEMHrr@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > void verify_brk(void)
> > {
> > 	if (tst_variant) {
> > 		tst_res(TINFO, "Testing sbrk()");
> > 		cur_brk = (uintptr_t)sbrk(0);
> > 	} else {
> > 		tst_res(TINFO, "Testing __NR_brk");
> > 		cur_brk = (void *)tst_syscall(__NR_brk, 0);
> > 	}

> > }

> > struct tst_test test = {
> > 	...
> > #ifdef __GLIBC__
> > 	.test_variants = 2,
> > #else
> > 	.test_variants = 1,
> > #endif
> > 	...

> > Not sure if it should be testeed also on android, i.e:
> > #if defined(__GLIBC__) || defined(__ANDROID__)

> Can we rather than ifdefing things out check the actual return values?

> Should be as easy as doing:

> 	if (cur_brk == (void*)-1)
> 		tst_brk(TCONF, "sbrk() not implemented");

> in the libc test variant.

+1.

WDYT about .test_variants? In that case it'd be tested also on musl
or any platform where it's implemented.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
