Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23785C4332F
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 09:29:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0F223CD52A
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 10:29:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC2643CA956
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 10:29:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 48D4D1000234
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 10:29:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C95E222237;
 Fri, 11 Nov 2022 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668158970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N1dVUIpFQi8O7Feo048ZZ65SBEEuoI/CXn0xkHOeIQ8=;
 b=LZdrByDsfEwPhehQVcHHbocAJpkj6zR2HNxwZf7CERcVw9IZNSpweoj2AjG27HK+t/ZCBX
 mZj4iULIoNXFmrloqCiJmx8LLzvB82fWehyAZyEqQKyXc8eCHrc5kNSipU7vdsNeEHkZ1k
 p7kw37TBqMli/YQkAQpbe/zmXj4HSLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668158970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N1dVUIpFQi8O7Feo048ZZ65SBEEuoI/CXn0xkHOeIQ8=;
 b=ntvSU9jJFb8JO/N/C45DbT7XTcQeW8VRLcv/T1eopJaPSfX3aijtLJ7dx94qOUCXaxZ0E5
 0E9hnRihOKha/ECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A04B13273;
 Fri, 11 Nov 2022 09:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JCK3GPoVbmOQYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Nov 2022 09:29:30 +0000
Date: Fri, 11 Nov 2022 10:29:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Minchan Kim <minchan@kernel.org>
Message-ID: <Y24V+AUuivt1F/Kw@pevik>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com> <Y2l89dt/t8M6+9go@pevik>
 <Y22DiF5Q5EDUIrZE@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y22DiF5Q5EDUIrZE@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

> On Mon, Nov 07, 2022 at 10:47:33PM +0100, Petr Vorel wrote:
> > Hi Minchan,

> > > On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
> > > > Hi all,

> > > > following bug is trying to workaround an error on ppc64le, where
> > > > zram01.sh LTP test (there is also kernel selftest
> > > > tools/testing/selftests/zram/zram01.sh, but LTP test got further
> > > > updates) has often mem_used_total 0 although zram is already filled.

> > > Hi, Petr,

> > > Is it happening on only ppc64le?
> > I haven't seen it on other archs (x86_64, aarch64).

> > > Is it a new regression? What kernel version did you use?
> > Found on openSUSE kernel, which uses stable kernel releases 6.0.x.
> > It's probably much older, first I've seen it some years ago (I'm not able to find kernel version), but it was random. Now it's much more common.

> > Test runs on VM (I can give qemu command or whatever you need to know about it)
> > I'll try to verify it on some bare metal ppc64le.

> Hi Petr and Martin,

> Thanks for testing and meaning information.

> Could you tell how I could create VM to run ppc64le and run the test?
> I'd like to reproduce in my local to debug it.
I suppose you don't have ppc64le bare metal machine, thus you run on x86_64.

One way would be to install on host qemu-system-ppc64, download iso image of any
distro which supports ppc64le and install it with virt-manager (which would fill
necessary qemu params).

Other way, which I often use is to compile system with Buildroot distribution.
You can clone my Buildroot distro fork, branch debug/zram [1].
I put there in 3 commits my configuration.
I added 0001-zram-Debug-mm_stat_show.patch [2] on the top of 6.0.7 with little debugging.

What is now only needed is to 1) install on host qemu-system-ppc64
(speedup build + Buildroot is configured not to compile qemu-system-ppc64),
then:
$ make # takes time
$ ./output/images/start-qemu.sh serial-only

When I have ppc64le host with enough space, I often use rapido [3],
but that crashed stable kernel (another story which I'll report soon).

Hope that helps.

Kind regards,
Petr

[1] https://github.com/pevik/buildroot/commits/debug/zram
[2] https://github.com/pevik/buildroot/blob/debug/zram/0001-zram-Debug-mm_stat_show.patch
[3] https://github.com/rapido-linux/rapido

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
