Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182A2C7EE29
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 12:22:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D9BA3CD1DD
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 14:22:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F5363C9956
 for <ltp@lists.linux.it>; Thu, 25 May 2023 14:22:24 +0200 (CEST)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3E4DC1000A68
 for <ltp@lists.linux.it>; Thu, 25 May 2023 14:22:23 +0200 (CEST)
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-43951f7002dso289291137.3
 for <ltp@lists.linux.it>; Thu, 25 May 2023 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685017342; x=1687609342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TiwQ2LI2rFbV2HsiZtBqVjQ7FkEpztC2S2POKBZ5Nkw=;
 b=Pairwt/ui9UAklFCQB9R2NjLwqTDpezcblarmRFlxPLxS/GCGHocJjLRyc34vfxCuw
 ztWx54wI1SsPHFrGvS2yg+2OgDfkk17aSmnNanXzCRV9jfRoX2Hrx1RHB/bILDj95yIY
 RyZMLKHFnM0GfURqCgFTF5Tu5f260oGaBlxeEsAOpggnV7pIpNUO0z+Ua6IoA6QiEFWo
 /MgmqkmSrritUbASLXVqR0DfaibX1Ua5psO1KIN9GsRadhyv7ZO0mBMfhRhWU8wqupLx
 WLHn3G0c3sfF4R+fZ5jnRdFbJiMEVAODXZMzC2nbT6Q1AnwH4Z38xRz+A5MVB0OdpSIh
 JpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685017342; x=1687609342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TiwQ2LI2rFbV2HsiZtBqVjQ7FkEpztC2S2POKBZ5Nkw=;
 b=ZmfijtWEKwWlXiL7FXzREABdmYe8Pvn2jvDAYf0xqmEN4uiMdt6T9ULmNJBjCN6PM4
 3WNJ1/IzvzTtiAGW7UHXIQ5bO/yZJlyHcLiNa6UKcxBaSl+DRuanvsKIqebJXzWCMWA1
 7VoygbGTQJEd5zNEcaJOrjoVMffrJiiLA6Z85wEqfbZ7ZSuy5WyEnmx7myk7pdUhLpkR
 omqYns+NEXiQJ1NSoTh5nz70uFqaWGMlXvOnirAkxFyXHggjhnBPBOe3p3tWpjKAWdje
 QgmFOnZYh+DrCVcdL4AN9FTPPNtTmKdJAzBwLslzyPOUBWHiZ382+9fnvdpS2xU8AO30
 OefQ==
X-Gm-Message-State: AC+VfDyvC/J/NHuv+7YUcm06IDiPaz9i/I59I+utxOkIcSdtji8yehW7
 X5BPFGloDB5LqBpba01VI6Z/zKgW6+jnmSiVuAd5VsRqgx/BFzGqu7zfYA==
X-Google-Smtp-Source: ACHHUZ5USy7xBZdaQ9EIY3V990pi9ccxJIXFmf1abk8usVqRBWsZ21K0L8edNCZ/kBX2J+JdfxU2nPBC5SFy1/0xHOE=
X-Received: by 2002:a05:6102:3177:b0:439:63f5:1a7 with SMTP id
 l23-20020a056102317700b0043963f501a7mr2068412vsm.12.1685017341910; Thu, 25
 May 2023 05:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
 <20230524140744.GK4253@hirez.programming.kicks-ass.net>
 <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
 <20230524175442.GO4253@hirez.programming.kicks-ass.net>
 <797a1074-4174-402a-a172-78191dfb426c@app.fastmail.com>
In-Reply-To: <797a1074-4174-402a-a172-78191dfb426c@app.fastmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 25 May 2023 17:52:10 +0530
Message-ID: <CA+G9fYsfp6V8jP3MGNAnOTSGseRUMepEWhAPt_KoUiN7GcGsYA@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] qemu-x86_64 compat: LTP: controllers: RIP:
 0010:__alloc_pages
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, lkft-triage@lists.linaro.org,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 25 May 2023 at 02:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 24, 2023, at 19:54, Peter Zijlstra wrote:
> > On Wed, May 24, 2023 at 09:39:50PM +0530, Naresh Kamboju wrote:
> >> FYI,
> >> These are running in AWS cloud as qemu-i386 and qemu-x86_64.
> >
> > Are these hosted on x86 and using KVM or are they hosted on Graviton and
> > using TCG x86 ?
> >
> > Supposedly TCG x86 is known 'funny' and if that's what you're using it
> > would be very good to confirm the problem on x86 hardware.

I see the following logs while booting.

<3>[    1.834686] kvm_intel: VMX not supported by CPU 0
<3>[    1.835860] kvm_amd: SVM not supported by CPU 0, not amd or hygon

And they are running on x86 machines.

>
> Even on x86 cloud instances you are likely to run with TCG if
> the host does not support nested virtualization. So the question
> really is what specific cloud instance type this was running
> on, and if KVM was actually used or not.  From what I could
> find on the web, Amazon EC2 only supports KVM guests inside of
> bare-metal instances but not any of the normal virtualized ones,
> while other providers using KVM (Google, Microsoft, ...) do support
> nested guests.
>
>       Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
