Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20464CA5FC5
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790779713; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=MF1VBQEyRmPrnJ1vOKUevfQ03Qs0JUplZBJrby/u8gY=;
 b=ieO1qpC/4As6CekIH6PLUJ73o6itqsjZXhXuZKN9l2udkF6pvjP92VIiTYTj8G7i5YNsa
 Y4TMxy7lQiRFMnFFgJnGzT/ztQS23l0K/hymGxJtbl4HQvfkpgfbUhofRU2g6qDETiZRKwB
 EvDVnKd+HvaU1+9PHJ1wNeKXfoU/sDQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 490C33E56AE
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D07FA3E1A5A
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:48:12 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 443D220005A
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:48:12 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so32274555e9.1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790779692; x=1791384492; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r1gcSZ3piscCTqAu1/h7dEE5Oisz6O3cxG0q/lTUpmQ=;
 b=HgsrBnn9XReBuScb4lQmzMe/O4u9ZwhKwqrcdodwKerTLkl13VUEOt9/gQJAtFT5UF
 RmgukWrN1I3mhfou1jTGmVqxFxjWx2hj8FDhc2kaUlKGAtqipKMD78zBZBB/dJEQyuW2
 FuqWR8vLp89Bn/dvzvjIzNFXkWgFjflwt1uFr44FUuz8TPNY/0foylPi+lejgDp1JPa6
 W0pmJr2Tku76g8Vwf64Q+0W74wWPcDIHC/SMNpeHCz7lqihcN3E5nm+I5nyowSrUlrGZ
 xxi4/w7KwxzqpyuWUmcdJx7CeZg3fB5cVoZiB6R5mczANklTazR/q4ICwXj5tI95XLYF
 qhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790779692; x=1791384492;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r1gcSZ3piscCTqAu1/h7dEE5Oisz6O3cxG0q/lTUpmQ=;
 b=oH66u0tNHBZgdCA5jmrScOvEXpRsFbLrO1x07Sh/WUkAVk+4gevH8MvaKsgqbkeu+I
 CdaFo3GuJkn1dqTUfMBOjLQaiOr1Q4ohWMmsBplIp9RbPTNdpyYn8e9VFC6NmhDeHTz4
 SRHwsEEvTTlbkIF4a3eVZkigI1P3EfFQk3uRN7FOkIG9JgIv/+5DlYqCq7HumzkTjm3U
 fAX9yk63snQdb/aJHjmsi6PDTzx1KYboSB/R6wbwa3GsmmXdK/L2m11UFpSFXASz1W2s
 ZpQ3lKQixjkAie93rBbj+jG+QHZNltDsSU4IsLzV3TPShW09AZWOTxzVk5dym4JsJ7Eu
 xdaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhQ8P/JaIWsX5aUcjoE3x589CFvGoED5j4pcthcf9u66jbc19XJ2JgjQQINa+QWdXFOIw=@lists.linux.it
X-Gm-Message-State: AFuF++nrcZVjpGJQtRXTWfcTk5E/Q2Qcd+PgtpA9MNKC/X4SrMAVR+8T
 D24SsSyl4DMPfX1AghFVP+czf83Ume7qfogqv1siYKzSMXFEN1QaZdst2GvFcGUFgog=
X-Gm-Gg: AYBFou19SpFacizFfjrTa57ObeHEeTKHFWG+sZ64jCh3nVkIMW0Zi2NsTVBVfKKyjnC
 3Ltjl5JcZEjn2hpfPgFOHCEdQwoBAZ/iGB9QfBiPXN3HG1ShjEoW6xMut6r6JNWnVht7WWXv/JT
 LJhTy5t3hC8hrypFOqKERkYCzH7ZYTY9ImI4H9O08h141nmw2vfDkcHCbfzFP7mBgLy9kKnMtUx
 7VhHjBPlax/WqLmGd3PjC4+Nx6IHywT8LahOfkG+sobeoLpZoMqToL6HC6vEV2rkw9F61Md4HjP
 AmNK/lKsiy103OOKzIEZ/LtQe+FkHSGXv0EOOGHktEI3xoV1hWKgZgMUZHUJFvQN2BRIu3yRZzP
 +ivW6jc6mIfFH4Bkd9fX6cXjHYItYbM3rjcApTN8B7LeLHRB98FFwRhttUakW5fUtPQjO5Eyeet
 2MaZCc6xvOjSAp06DNn1nMpIe2CERi61CogR3FmaBQSy9WJ55KHY6m6FxazOXCb3epHZsX839F5
 6xb8HKJgiRKdIPkVtGv8hbfnNGOmsHrlUGjvbVfgZUalWEZp1gUI0fB7TdYjxlUMOybScS8ROkV
 7g==
X-Received: by 2002:a05:600c:3144:b0:4a0:1c0e:b2a8 with SMTP id
 5b1f17b1804b1-4a01c0ecb6fmr22390535e9.28.1790779691575; 
 Wed, 30 Sep 2026 07:48:11 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e63e10csm4600565e9.2.2026.09.30.07.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:48:11 -0700 (PDT)
Message-ID: <6abd212b.ea8c0684.18c111.8e28@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260930144146.GB2729765@pevik>
Date: Wed, 30 Sep 2026 14:48:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls: Update numbers to Linux v7.3-rc5
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Andrea,
> 
> > Update architecture syscall tables up to Linux v7.3-rc5 using the
> > updated generate_arch.sh script. This adds clone3 on sparc/sparc64,
> > uprobe on x86_64, and new generic syscalls (listns, rseq_slice_yield,
> > fchroot), while preserving legacy syscall numbers.
> 
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >  include/lapi/syscalls/arc.in         | 3 +++
> >  include/lapi/syscalls/arm.in         | 4 ++++
> >  include/lapi/syscalls/arm64.in       | 3 +++
> >  include/lapi/syscalls/i386.in        | 6 ++++++
> >  include/lapi/syscalls/loongarch64.in | 3 +++
> >  include/lapi/syscalls/mips64.in      | 3 +++
> >  include/lapi/syscalls/mips64n32.in   | 3 +++
> >  include/lapi/syscalls/mipso32.in     | 7 +++++--
> >  include/lapi/syscalls/parisc.in      | 4 ++++
> >  include/lapi/syscalls/powerpc.in     | 7 +++++++
> >  include/lapi/syscalls/powerpc64.in   | 7 +++++++
> >  include/lapi/syscalls/s390x.in       | 4 ++++
> >  include/lapi/syscalls/sh.in          | 4 ++++
> >  include/lapi/syscalls/sparc.in       | 5 +++++
> >  include/lapi/syscalls/sparc64.in     | 5 +++++
> >  include/lapi/syscalls/x86_64.in      | 4 ++++
> >  16 files changed, 70 insertions(+), 2 deletions(-)
> 
> LGTM, thanks! Smaller diff is really better
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
> > index 0f0fbef6b..96b14c1b9 100644
> > --- a/include/lapi/syscalls/arc.in
> > +++ b/include/lapi/syscalls/arc.in
> > @@ -347,3 +347,6 @@ removexattrat 466
> >  open_tree_attr 467
> >  file_getattr 468
> >  file_setattr 469
> > +listns 470
> > +rseq_slice_yield 471
> > +fchroot 472
> > diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
> > index d0238dec5..5b6047bd2 100644
> > --- a/include/lapi/syscalls/arm.in
> > +++ b/include/lapi/syscalls/arm.in
> > @@ -96,6 +96,7 @@ delete_module 129
> >  quotactl 131
> >  getpgid 132
> >  fchdir 133
> > +bdflush 134
> 
> At least this one was added here due your fixes in the first patch, because this
> should have been here before:
> 
> git show b48c7236b13cb5 arch/arm/tools/syscall.tbl # v5.15-rc1
> -134    common  bdflush                 sys_bdflush
> +134    common  bdflush                 sys_ni_syscall
> 
> This commit added it for 15 archs (of 17 at the time).
> 
> Kind regards,
> Petr

thanks for the review. I will merge before the release

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
