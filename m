Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9545C4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 21:47:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AE3B3CDAD2
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 22:47:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F3D93CDA43
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 22:47:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6D4391A00115
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 22:47:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72B141F889;
 Mon,  7 Nov 2022 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667857656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TlVbo42sNig1NHmDEtnPq6ibjLSSFwdkdUylt0cyH2Q=;
 b=Tgk9qSm80ZFvuHAk2hjDWm9hmWHyMAFhJeIzscpPPIs0Glsh57hT4wRdgBiqhX62Ajz7qW
 ePM/ABozz8yo5scLagq6XTzh2fSyE0O0GFNKCWi6m1EoTO41NhkHb0UnekHUr6YfSsf7XA
 qf0HL5kAvwWNtre+MRgIF53024nO9J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667857656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TlVbo42sNig1NHmDEtnPq6ibjLSSFwdkdUylt0cyH2Q=;
 b=vEJQnljCKIsMt0jZnSmxqtA6QM7E66/z63M7wHL5TIEsbPv1j6QdnP892ieVefiZ6EZbgj
 BRlcDqfoSETxBOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14CFD13AC7;
 Mon,  7 Nov 2022 21:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZY5FA/h8aWOrKgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Nov 2022 21:47:36 +0000
Date: Mon, 7 Nov 2022 22:47:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Minchan Kim <minchan@kernel.org>
Message-ID: <Y2l89dt/t8M6+9go@pevik>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y2l3vJb1y2Jynf50@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/1] Possible bug in zram on ppc64le on vfat
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
Cc: Jens Axboe <axboe@kernel.dk>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, ltp@lists.linux.it,
 linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Minchan,

> On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
> > Hi all,

> > following bug is trying to workaround an error on ppc64le, where
> > zram01.sh LTP test (there is also kernel selftest
> > tools/testing/selftests/zram/zram01.sh, but LTP test got further
> > updates) has often mem_used_total 0 although zram is already filled.

> Hi, Petr,

> Is it happening on only ppc64le?
I haven't seen it on other archs (x86_64, aarch64).

> Is it a new regression? What kernel version did you use?
Found on openSUSE kernel, which uses stable kernel releases 6.0.x.
It's probably much older, first I've seen it some years ago (I'm not able to find kernel version), but it was random. Now it's much more common.

Test runs on VM (I can give qemu command or whatever you need to know about it)
I'll try to verify it on some bare metal ppc64le.

> Actually, mem_used_total indicates how many *physical memory* were
> currently used to keep original data size.

> However, if the test data is repeated pattern of unsigned long
> (https://github.com/torvalds/linux/blob/master/drivers/block/zram/zram_drv.c#L210)
> zram doesn't allocate the physical memory but just mark the unsigned long's value
> in meta area for decompression later.

> Not sure you hit the this case.
Thanks for a hint, I'll try to debug it.

Kind regards,
Petr

> > Patch tries to repeatedly read /sys/block/zram*/mm_stat for 1 sec,
> > waiting for mem_used_total > 0. The question if this is expected and
> > should be workarounded or a bug which should be fixed.

> > REPRODUCE THE ISSUE
> > Quickest way to install only zram tests and their dependencies:
> > make autotools && ./configure && for i in testcases/lib/ testcases/kernel/device-drivers/zram/; do cd $i && make -j$(getconf _NPROCESSORS_ONLN) && make install && cd -; done

> > Run the test (only on vfat)
> > PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=vfat zram01.sh

> > Petr Vorel (1):
> >   zram01.sh: Workaround division by 0 on vfat on ppc64le

> >  .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)

> > -- 
> > 2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
