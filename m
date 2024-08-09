Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B48C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 14:36:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E26B3D20C7
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 16:36:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B49A53D20BB
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 16:36:41 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=digikod.net (client-ip=2001:1600:4:17::bc08;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=mic@digikod.net;
 receiver=lists.linux.it)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC8D51401207
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 16:36:39 +0200 (CEST)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WgRLY736Hzj9r;
 Fri,  9 Aug 2024 16:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
 s=20191114; t=1723214197;
 bh=D5oPaDAMbHaR9dWHKpt9+HMm/hwjzPhTcdxPmCCOQFE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Edt8qsRVxWDHVYWwk2bmX+qdQByOMwTVrXYjfJV0HSOpoAhBeygNXy2xeL2wLFA18
 H28T3xRTOW/nvu9uRIc1UBEesNAkQwb3djreAy5Es15M7oW/5soPInPnyYYeLJ1BdH
 pfzHCUrrGBgfJ1yR0Q6UKxXKnEG+CvDOv5Jj/FCw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4WgRLY3gZ2z2n4; Fri,  9 Aug 2024 16:36:37 +0200 (CEST)
Date: Fri, 9 Aug 2024 16:36:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240809.Ohqueicih1ou@digikod.net>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
 <20240801-landlock-v5-3-663d7383b335@suse.com>
 <20240808095824.GC327665@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240808095824.GC327665@pevik>
X-Infomaniak-Routing: alpha
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Disable kernel version check in landlock
 tests
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
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 08, 2024 at 11:58:24AM +0200, Petr Vorel wrote:
> is is really helpful when landlock support has
> > been backported into old kernels.
> 
> Great, I'm glad you removed it from all landlock tests. It really did not make
> sense to guard correct version with 3 guards (kernel version, kernel config and
> ABI). Could you please remove also CONFIG_SECURITY_LANDLOCK=y, because you
> check EOPNOTSUPP in verify_landlock_is_enabled().
> 
> Anyway, feel free to merge these first 3 patches (ideally remove also
> CONFIG_SECURITY_LANDLOCK=y before merge).

My understanding is that LTP only tests supported features to make sure
they work as expected, if enabled.  Is it correct?

I'm then wondering what is the purpose of needs_kconfigs.  If there is
no "needed" config, does that means that Landlock tests will always run
and detect at run time if tests are skipped or not?  If yes, it looks
good to me.

Andrea's commit to remove needs_kconfig:
https://github.com/linux-test-project/ltp/commit/e7ebc637d0d99295490adf57660a3b3a177d65d3

Is there an online dashboard to see some tested kernels?

> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
