Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBB7C433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:41:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F10C3CB04E
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 10:41:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C2493C93EF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:41:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3C65A100098A
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:41:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68D6E33E1B;
 Tue, 18 Oct 2022 08:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666082475;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4pgoN7vEpeEera8J2sxjndJsBG4Nw8PIRXEDuqWNQ4=;
 b=Ppp8rjW2/zpXUiYVc9ASz7kGMpnzTRfySJ/fbOCw16J4lMcX/vTxvD+eeiSRctnKjhFDNu
 lT/RititBk26uBEifcPz6grYdSzQvMvlgy6SCUfWt4pL21OI85W2stF2SHuM4poz2S4kbP
 5t7bw6YqWMZVcaQNS3diExIfrGzZ1YY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666082475;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4pgoN7vEpeEera8J2sxjndJsBG4Nw8PIRXEDuqWNQ4=;
 b=rFOWbs3U5XJs+IWrr9vE68Z3YNQxYx0KgKofUufqlhGiu6MLuz5F75SDVNZNQkpTmJXId5
 JWI0aB04h8lJWRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32F1F139D2;
 Tue, 18 Oct 2022 08:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HwQrC6tmTmNTbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Oct 2022 08:41:15 +0000
Date: Tue, 18 Oct 2022 10:41:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y05mqQxG5NVukQNP@pevik>
References: <20221004090810.9023-1-pvorel@suse.cz> <87sfjmmswf.fsf@suse.de>
 <Y01wmJ0ZT+G+N5IE@pevik> <87k04xmt4i.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k04xmt4i.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] df01.sh: Use own fsfreeze implementation for
 XFS
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
Cc: linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
 ltp@lists.linux.it, "Darrick J . Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie,

> >> Hello,

> >> Petr Vorel <pvorel@suse.cz> writes:

> >> > df01.sh started to fail on XFS on certain configuration since mkfs.xfs
> >> > and kernel 5.19. Implement fsfreeze instead of introducing external
> >> > dependency. NOTE: implementation could fail on other filesystems
> >> > (EOPNOTSUPP on exfat, ntfs, vfat).

> >> > Suggested-by: Darrick J. Wong <djwong@kernel.org>
> >> > Suggested-by: Eric Sandeen <sandeen@redhat.com>
> >> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> >> > ---
> >> > Hi,

> >> > FYI the background of this issue:
> >> > https://lore.kernel.org/ltp/Yv5oaxsX6z2qxxF3@magnolia/
> >> > https://lore.kernel.org/ltp/974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com/

> >> > @LTP developers: not sure if the consensus is to avoid LTP API
> >> > completely (even use it just with TST_NO_DEFAULT_MAIN), if required I

> >> Why would that be the consensus? :-)

> > $ ls testcases/lib/*.c |wc -l
> > 19

> > $ git grep -l TST_NO_DEFAULT_MAIN testcases/lib/*.c |wc -l
> > 9

> > => 10 tests not use tst_test.h at all.
> > => none is *not* defining TST_NO_DEFAULT_MAIN (not a big surprise),
> > but 2 of them (testcases/lib/tst_device.c, testcases/lib/tst_get_free_pids.c)
> > implement workaround to force messages to be printed from the new library
> > (tst_test.c).

> Possibly the reason for this is that it's not clear whether some core
> library functions will work as expected if we create an executable with
> TST_NO_DEFAULT_MAIN.

> However most stuff works fine.


> > static struct tst_test test = {
> > };
> > tst_test = &test;

> > My opinion also was based on Cyril's comments on nfs05_make_tree.c patch, but he
> > probably meant to just use TST_NO_DEFAULT_MAIN instead of struct tst_test test:
> > https://lore.kernel.org/ltp/YqxFo1iFzHatNRIl@yuki/

> Certainly we shouldn't put a test struct in anything which is not a
> test. Possibly we could create a util struct


> >> > can rewrite to use it just to get SAFE_*() macros (like
> >> > testcases/lib/tst_checkpoint.c) or even with tst_test workarounds
> >> > (testcases/lib/tst_get_free_pids.c).

> >> Yes, it should work fine with TST_NO_DEFAULT_MAIN
> > Both versions IMHO work well, the question what we prefer more.
> > Do you vote for rewriting?

> Yes, avoiding the LTP library caused a number of problems in sparse-ltp
> and the ltx prototype. Then I found linking in the LTP libs with
> TST_NO_DEFAULT_MAIN to ltx and using tst_res(TBROK, ...) etc. worked
> fine.

Well, this simple utility works without LTP library. It's more a matter of
style. OK, I'll send TST_NO_DEFAULT_MAIN version and let the community decide.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
