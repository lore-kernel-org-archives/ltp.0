Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA689C32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 19:28:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6DCE3CA2C2
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 21:28:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71B533CA155
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 21:28:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE397600071
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 21:28:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F20931FBA8;
 Fri, 19 Aug 2022 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660937305;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4JhAhYtqVHiLuemLCzuwsU8zpofcCP6KjmPE8fH0dA4=;
 b=HRooOVmGO7M5TK9e+sgNjL76RGeOnZ6wouG74fa1M9mKm2y/Jz/22Ild5W5RetlKuF/3Ih
 FUdCUxgeroNwnaA8kCw+whSuX1576Av24v5ffbk6jpVqmnpg4/TxrbOh5jTAMX+nDixLaW
 BO42affBPaUzUd4LblanbEue+tbN8Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660937305;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4JhAhYtqVHiLuemLCzuwsU8zpofcCP6KjmPE8fH0dA4=;
 b=jcQl0FqxUBHU3m2t9Ubv+Dc6S72+i6ulFlh7lSvIyCYooh1+UQl5f+LlFNj2ct1hTydHCs
 +xGSlpfIwlJd1dCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71AA113AE9;
 Fri, 19 Aug 2022 19:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JVIUAVjk/2IlWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 19:28:24 +0000
Date: Fri, 19 Aug 2022 21:28:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <Yv/kVXSK0xJGb3RO@pevik>
References: <20220817204015.31420-1-pvorel@suse.cz> <Yv4MBF79PnJKJbwm@yuki>
 <Yv4eiT5L+M7dMkQ5@pevik> <Yv4i0gWiHTkfWB5m@yuki>
 <CAMuHMdUMBjCTwPu7wxrnagXnbyVxxmXN+vHmML0Lr=SyrTw0nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdUMBjCTwPu7wxrnagXnbyVxxmXN+vHmML0Lr=SyrTw0nQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/1] API: Allow to use xfs
 filesystems < 300 MB
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
Cc: linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 automated-testing@yoctoproject.org, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Cyril,

> On Thu, Aug 18, 2022 at 1:28 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> > > > I'm starting to wonder if we should start tracking minimal FS size per
> > > > filesystem since btrfs and xfs will likely to continue to grow and with
> > > > that we will end up disabling the whole fs related testing on embedded
> > > > boards with a little disk space. If we tracked that per filesystem we
> > > > would be able to skip a subset of filesystems when there is not enough
> > > > space. The downside is obviously that we would have to add a bit more
> > > > complexity to the test library.

> > > Maybe I could for start rewrite v2 (I've sent it without Cc kernel devs now it's
> > > mainly LTP internal thing) as it just to have 300 MB for XFS and 256 MB for the
> > > rest. That would require to specify filesystem when acquiring device (NULL would
> > > be for the default filesystem), that's would be worth if embedded folks counter
> > > each MB. It'd be nice to hear from them.

> > The 256MB limit was set previously due to btrfs, I bet that we can
> > create smaller images for ext filesytems for example.

Thanks for input, Geert!

> Yeah, we used to have ext2 root file systems that fit on 1440 KiB floppies.
These nice times when everything simple hadn't been solved yet ... :).
> IIRC, ext3 does have a minimum size of 32 MiB or so.
Interesting, I was able to create smaller.

I did some testing minimal size (verified on chdir01 test):
XFS: 300 MB, btrfs: 109 MB, ntfs: 2 MB, ext3: 2 MB, ext[24]: 1 MB, vfat: 1 MB, exfat: 1 MB.

I guess using XFS: 300 MB, btrfs: 109 MB and 16 MB for the rest could be enough.
But that would require to run all tests to see how many tests actually use
bigger data.

Kind regards,
Petr

> Gr{oetje,eeting}s,

>                         Geert

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
