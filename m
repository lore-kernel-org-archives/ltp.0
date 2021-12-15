Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD3BC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 11:56:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EB3D3C8F2C
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 12:56:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E07C3C042D
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 12:56:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 956B520099D
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 12:56:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3D1D1F3A2;
 Wed, 15 Dec 2021 11:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639569376;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LSFKeMZpc2lli2cgepxWxRF+M348fX2kluVDE4m89bw=;
 b=ytmN3eB9yQlOxonsD1dlXURFZ+LjrX7gC6h6i0P7Eujkyb9cfu3IyqMfcruEo/73dKjyYh
 SBXSydLS1BT5j1Sv7CzPw/Z7JVtRKwOFEiMW/GNm6sGCzvyZKxGokzzP3QgA0WzmNDKlob
 n9ItEJStBffNNyGvNT4iZsCLzm0hBrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639569376;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LSFKeMZpc2lli2cgepxWxRF+M348fX2kluVDE4m89bw=;
 b=degh9OMKDEVCQnfIpurTYtSN+NPAW2RY/VbvNt3JpdzIrYR1YPKcWgPPltoQoKcp8V9uMH
 MFCUnbQ7z4dajZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85A8213B27;
 Wed, 15 Dec 2021 11:56:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C4nyHuDXuWEyIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 11:56:16 +0000
Date: Wed, 15 Dec 2021 12:56:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YbnX3ooGrE9xWg3b@pevik>
References: <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
 <61B31657.9020008@fujitsu.com> <YbMX66Oeu1byuMiR@pevik>
 <61B31EA0.9020104@fujitsu.com> <Ybb41TwZ1vSiCAzO@pevik>
 <61B6FEE2.3010402@fujitsu.com> <YbchxBlw3jMGwFQ4@pevik>
 <61B81386.1050103@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61B81386.1050103@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr
> > Hi Xu,

> > [ Cc Naresh Kamboju who added zram support to kconfig ]
> Oh, I don't know kernel selftest also have these two zram tests.

> >> Hi Petr
> >>> Hi Xu,

> >>> ...
> >>>>>> ps: zram01 need to rmmod and modprobe zram. So if kernel built with
> >>>>>> CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
> >>>>> +1

> >>> We already have v3, but I got confused here in v1, thus asking.

> >>>> Since zram_lib.sh uses tst_needs_driver to search module in
> >>>> modules.dep/modules.builtin. Maybe we can introduce a new macro
> >>>> TST_NEEDS_MODULES (like TST_NEEDS_DIRVERS)?
> >>> I got lost here, did you suggest zram_lib.sh to switch to use $TST_NEEDS_MODULE?
> >> Sorry, I don't know ltp shell api already have this TST_NEEDS_MODULE
> >> macro and so suggest to add a new macro wrongly.

> >> Yes, I want to use TST_NEEDS_MODULE instead of TST_NEEDS_DIRVERS because
> >> the former is more accurate.

> >> But it seems  our TST_NEEDS_MODULE only can check custom kernel module
> >> but can't check system kernel module(like ext4.ko.xz, xfs.ext4.ko.xz).
> > Good catch, tst_require_module() in tst_test.sh should be fixed.
> > Also, if I look correctly, there is no TST_NEEDS_MODULE equivalent for C API
> > (probably not needed).
> Maybe add a issue for this, so we or others can do it in the future.
And is it needed to be added to C API?

> >> ps: kconfig shell api can also do the thing by using "config_zram=m". So
> >> I may use kconfig shell api in here in the feature.
> > FYI When Naresh Kamboju put LTP zram tests into kselftest back in 2015,
> > he modified it to support also zram built-in (CONFIG_ZRAM=y).

> > We don't support it, thus CONFIG_ZRAM=m is OK now, but we should consider to add
> > at least some minimal support for CONFIG_ZRAM=y.
> Yes, kernel selftest supports CONFIG_ZRAM=y. Because zram01.sh in kernel 
> selftest only used one zram device(It only supports ext4 filesystem but 
> ltp supports all possible filesystem).

> Since most distribution should use CONFIG_ZRAM=m, I guess we don't need 
> to support CONFIG_ZRAM=y and ltp can support more filesystems.
> Maybe can add a note that user can use kernel selftest when his kernel 
> config is CONFIG_ZRAM=y.
Not sure.

> Also, It seems kernel selftest zram case is old
> 1) should remove zram_max_streams
> 2) should use mm_stat instead of free -m to calcaute ratio
> 3) should consider the situation that /dev/zram0 is being used
Yes it's old. As some people run only kselftest it might be worth to update it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
