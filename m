Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EBEC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D71AF3CC8CD
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 13:02:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37E7B3C0162
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:02:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 799611401109
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:02:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E34FB21AD9;
 Fri, 25 Nov 2022 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669377740;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7mhmJI0+6pCm/9utmvEdYHRRRMdr9gEiZ7QHS1FQAA=;
 b=TtIINt+jXQawCQCgHXDusjgRmZ8pLroHeF02hBKlXzIshT2gundjdOwlMi9LnlsZqL5PXu
 blupbfaj4omaLya+lN2S0s+hy6dr5gkYtFO0frerZSvNyn5N1+y6KdTW5gOPaNPQqxaH34
 Sy/gACxD5pfbTHtRrEngayRsW1T/Z+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669377740;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7mhmJI0+6pCm/9utmvEdYHRRRMdr9gEiZ7QHS1FQAA=;
 b=lA59RXV9MS0C0xXTXWdgosTEvGNyxF3z/lT4lc5RLtvgDi1H5CYSUNyBmHrtJH+BLidOUV
 y1eyYqMt43KeMtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCCB11361C;
 Fri, 25 Nov 2022 12:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LhdvLMyugGNIHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 12:02:20 +0000
Date: Fri, 25 Nov 2022 13:02:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Y4CuyodvMln8/3N1@pevik>
References: <20221117121409.179210-1-david@redhat.com> <Y3eI0Q5BTE12+4zO@yuki>
 <70e7f5af-d0a8-6f08-0b18-36f71e44443f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70e7f5af-d0a8-6f08-0b18-36f71e44443f@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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

> > > +static void cleanup(void)
> > > +{
> > > +	SAFE_UMOUNT(TMP_DIR);
> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +	.needs_checkpoints = 1,
> > > +	.forks_child = 1,
> > > +	.needs_root = 1,

> > We are missing .needs_tmpdir flag here, otherwise the test will create
> > the the TMPDIR in PWD which may fail in certain setups.

> I just noticed that compilation now says:

> testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c: useless tag:
> needs_tmpdir
Good catch.

> So is "needs_tmpdir" indeed usless or are we missing something else?

Although not printing which tags implying .needs_tmpdir is a bit confusing,
the warning is correct - .needs_checkpoints implies .needs_tmpdir

https://github.com/linux-test-project/ltp/blob/e814430fad2e976e4a40c9d2de9e39401456d8eb/metadata/metaparse.c#L797-L806

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
