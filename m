Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852B5CA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 10:22:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FE7A3CCB2F
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:22:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CE913CBBA7
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 12:22:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 958C71A04325
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 12:22:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E8441F45E;
 Fri,  1 Sep 2023 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693563743;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNwLYdsvKPUqIMGe4J2XppFl95Touqv/55BhpOIKDzE=;
 b=dzMYynwJMeOAYtV1bD7guemHcf9659xWvdo483G+xZVea6e3yleSW2Re82yCm0b2mvmhxe
 6650W4Yfxuvg7GBa0ySicxpgtRoS7z4pAkWIKtC3gNFu/kKk2tVFEZGH6QXk80xG60QX53
 klz57IIfZQ3dcwBWpcrF8V1Udc4LBAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693563743;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNwLYdsvKPUqIMGe4J2XppFl95Touqv/55BhpOIKDzE=;
 b=79X3bBdLatsW3z0PjaW1pTt/D7KHSCd5U2olnG8QJfb+d6KyyDL8J4R3eSkgpJohB1MCDS
 MDUpqqJlA4VSpTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C8DF1358B;
 Fri,  1 Sep 2023 10:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FhgNFV+78WQ7XgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Sep 2023 10:22:23 +0000
Date: Fri, 1 Sep 2023 12:22:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>, ltp@lists.linux.it
Message-ID: <20230901102221.GB323151@pevik>
References: <20230829231845.25866-1-wegao@suse.com>
 <20230831064727.5790-1-wegao@suse.com> <87wmxbh8kh.fsf@suse.de>
 <20230901101954.GA323151@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230901101954.GA323151@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] clone3: Add clone3's clone_args cgroup
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

> Hi Wei, Richie,

> > Hello,

> > Wei Gao via ltp <ltp@lists.linux.it> writes:

> > > +
> > > +static struct tst_test test = {
> > > +	.test_all = run,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.forks_child = 1,
> > > +	.max_runtime = 20,

> > I removed this and merged!

> This change, merged as 45f6916ba ("clone3: Add clone3's clone_args cgroup")
> caused failing clone302:

> tst_buffers.c:56: TINFO: Test is using guarded buffers
> tst_test.c:1559: TINFO: Timeout per run is 0h 00m 30s
> clone302.c:101: TPASS: invalid args: clone3() failed as expected: EFAULT (14)
> clone302.c:101: TPASS: zero size: clone3() failed as expected: EINVAL (22)
> clone302.c:91: TFAIL: short size: clone3() passed unexpectedly
> clone302.c:101: TPASS: extra size: clone3() failed as expected: EFAULT (14)
> clone302.c:101: TPASS: sighand-no-VM: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: thread-no-sighand: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: fs-newns: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: invalid pidfd: clone3() failed as expected: EFAULT (14)
> clone302.c:101: TPASS: invalid signal: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: zero-stack-size: clone3() failed as expected: EINVAL (22)
> clone302.c:101: TPASS: invalid-stack: clone3() failed as expected: EINVAL (22)

FYI include/lapi/sched.h change caused the regression.

Kind regards,
Petr

> Summary:
> passed   10
> failed   1
> broken   0
> skipped  0
> warnings 0
> ### TEST clone302 COMPLETE >>> 1.

> Could you please have look and fix it?

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
