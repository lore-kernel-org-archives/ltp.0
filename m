Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70439CA0FE1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:31:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CD003CCD3B
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:31:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A37C43CBB7E
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:31:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EAE8F6006D4
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:31:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CDFB1F8AC;
 Fri,  1 Sep 2023 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693571488;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0++MmlP5+gPELgpQq3z6Es91IW4Q3UEI85XaVeKg5A=;
 b=mu9njyXJX4V3ZvTBBczHKujjMhXTuiH8UgTrGO4mTR6rrTSdhq9gGIjkIZxGGUlOCdiHh8
 EmH3uM3KuScU836si30mYlNnbME5FSqfCQv1FMNVo7gfpSMEpSNIfTGyrUrIhiro8NCkCH
 RrGVcEbUHMR5glsyvRWnndam2vzzfzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693571488;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0++MmlP5+gPELgpQq3z6Es91IW4Q3UEI85XaVeKg5A=;
 b=KFkh+XY/CI+hU8jTUzll9NHRwulPzOuC+yUy0M7IXiji7CBz4RPpRJwbIePCib+rFWqxrb
 icgWvT8/ZfQfAYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2E421358B;
 Fri,  1 Sep 2023 12:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x7XDOJ/Z8WRkJQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Sep 2023 12:31:27 +0000
Date: Fri, 1 Sep 2023 14:31:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230901123126.GA343678@pevik>
References: <20230829073821.2580-1-andrea.cervesato@suse.de>
 <ZO8d3GO_jFgNAXNY@rei> <20230901103758.GC323151@pevik>
 <ZPHWK_Msrqbpmvtt@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZPHWK_Msrqbpmvtt@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add process_madvise01 test
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
> > > > +	TST_EXP_EXPR(map_before.swap < map_after.swap,
> > > > +		"Most of the memory has been swapped out: %dkB out of %dkB",
> > > > +		map_after.swap,

> > > Although it's unlikely that map_before.swap will be non-zero we should
> > > print the difference here, so I've changed this part to:

> > > map_after.swap - map_before.swap

> > > And pushed, thanks.

> > FYI this new test is failing on current openSUSE Tumbleweed (kernel 6.4.12-1):

> > tst_test.c:1559: TINFO: Timeout per run is 0h 00m 30s
> > process_madvise01.c:38: TINFO: Allocate memory: 1048576 bytes
> > process_madvise01.c:99: TINFO: Reclaim memory using MADV_PAGEOUT
> > process_madvise01.c:62: TFAIL: Expect: Most of the memory has been swapped out: 0kB out of 1024kB

> > Summary:
> > passed   0
> > failed   1
> > broken   0
> > skipped  0
> > warnings 0

> > Test works well on current Debian unstable with kernel 6.4.11.
> > Could you please have a look if it's a test or a kernel bug?

> Does the machine where it fails even have any swap?

I has CONFIG_SWAP=y, but vmstat reports si and so as 0.
Therefore machine probably does not have any swap.

> I suppose that we should check for:

> 1) CONFIG_SWAP in the kernel .config
> 2) /proc/meminfo SwapFree: > $pagesize kB

+1.

> I guess that the madvise kicks off the kernel swapper, but it may take
> some time for the memory to be actually swapped.

Sounds reasonable.

BTW I wonder if we should add 'vmstat' or 'cat /proc/meminfo' to ver_linux.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
