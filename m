Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC87C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 10:34:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC7D63C8901
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 11:34:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D33FD3C0B90
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:34:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 396641400BDC
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:34:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D5EA2112B;
 Mon, 13 Dec 2021 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639391686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mk2dVzrth6PitCv1D7b57V/wQ2t7ksZbTsC9pRmjsJ0=;
 b=2700CMVpD+3SbXu+2gubgzcIwrb/UKv7CaPEEC9gFoPHwm4ZDvN3mCr6oQcgy54+2tRQr4
 KZe7ITkMRj9S2fvTRJws8hZVe8GDD02qal63G9iM9I+fcuXx0lk5aG/tN+Hhbbly8rCEpZ
 1gbNuNAjfEwnG5VB51aF0KFvxOq1aHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639391686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mk2dVzrth6PitCv1D7b57V/wQ2t7ksZbTsC9pRmjsJ0=;
 b=/UNA1I0JC42LxWmwhZxVLRuvI7GDEMaLtdav8vW3aNAlhXZQoBeSI9bqAxFJLaVVy8SR8e
 hJ9PIIba/mzGldDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 067D413CE5;
 Mon, 13 Dec 2021 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gZ3fOsUht2HRQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Dec 2021 10:34:45 +0000
Date: Mon, 13 Dec 2021 11:34:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YbchxBlw3jMGwFQ4@pevik>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
 <61B31657.9020008@fujitsu.com> <YbMX66Oeu1byuMiR@pevik>
 <61B31EA0.9020104@fujitsu.com> <Ybb41TwZ1vSiCAzO@pevik>
 <61B6FEE2.3010402@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61B6FEE2.3010402@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

[ Cc Naresh Kamboju who added zram support to kconfig ]

> Hi Petr
> > Hi Xu,

> > ...
> >>>> ps: zram01 need to rmmod and modprobe zram. So if kernel built with
> >>>> CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
> >>> +1

> > We already have v3, but I got confused here in v1, thus asking.

> >> Since zram_lib.sh uses tst_needs_driver to search module in
> >> modules.dep/modules.builtin. Maybe we can introduce a new macro
> >> TST_NEEDS_MODULES (like TST_NEEDS_DIRVERS)?
> > I got lost here, did you suggest zram_lib.sh to switch to use $TST_NEEDS_MODULE?
> Sorry, I don't know ltp shell api already have this TST_NEEDS_MODULE 
> macro and so suggest to add a new macro wrongly.

> Yes, I want to use TST_NEEDS_MODULE instead of TST_NEEDS_DIRVERS because 
> the former is more accurate.

> But it seems  our TST_NEEDS_MODULE only can check custom kernel module 
> but can't check system kernel module(like ext4.ko.xz, xfs.ext4.ko.xz).
Good catch, tst_require_module() in tst_test.sh should be fixed.
Also, if I look correctly, there is no TST_NEEDS_MODULE equivalent for C API
(probably not needed).

> ps: kconfig shell api can also do the thing by using "config_zram=m". So 
> I may use kconfig shell api in here in the feature.
FYI When Naresh Kamboju put LTP zram tests into kselftest back in 2015,
he modified it to support also zram built-in (CONFIG_ZRAM=y).

We don't support it, thus CONFIG_ZRAM=m is OK now, but we should consider to add
at least some minimal support for CONFIG_ZRAM=y.

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
