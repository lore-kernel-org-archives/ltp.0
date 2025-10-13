Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA9BCCD18E
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 15:58:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B02C3CEC33
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 17:58:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25E783CEBA0
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 17:58:15 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 311851400C6C
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 17:58:15 +0200 (CEST)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-7ea50f94045so64699636d6.1
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760371094; x=1760975894; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rMx4lPicK4cgxKHj4LyIlHUt2URcYLJNzOUDge1Q51M=;
 b=C98X1s6XzwWMrgqelhdpJMhxuUIVCrTEYkElQRjKv30pWgjPy7A9rwYzMdCHhGnGhg
 QcScCnVhTx2wZ/wto0icGHXgdMZJjalTpN79TCYN0QG8cLTSb2V/rulmZ4RJ+mInQJaL
 Ei0THgK12GKOT8gigOy2UlGG1qD7kPUEagCQ/VNWIIWgKCoQayY0vw2YXUu7NOl5U0zm
 PCorwwdwQICAxoSefFm0N2MAGxJdxBjDkajtvF9n16oHrieDQlwJmniTUZ9c9m4yJgcZ
 QId3fTt6cfAsGwW1MsCKa/6NyGBh0Zonc6d9XvLJ6tk8Jlc0dZJb81pBOIxW4RozgWhJ
 N8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760371094; x=1760975894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMx4lPicK4cgxKHj4LyIlHUt2URcYLJNzOUDge1Q51M=;
 b=SLTBZ/+diHIFbro8Iq/bYx/qdq4SUM5MZ+2DslEZnXJ01fxlzkgDTa2mSH4G4/F5ua
 3cdu29eyYBiyVRoWOQiRc0Bg+flIc7Ludc5egNxujvG3PUVsQ5HLlBPg0f4TjCU7A+0a
 84DppxFApwLXJOI1xoiE50UpO+8oD3nJRQOZBj84xb7Fz5XYDlTW0z6Y+soeHR2tOmd/
 bhNnfMBMmPivptNtNt/PFjViXsg9opm0mk/ZgpI1mrQEOwAg+ZuoTQyB/35kw8+e+h+V
 Ow834962BmgF3ESEPwFtGGdJQ2VvG1Uie5qVyII05jXb6iG9DGvAOcpirflT5B5I6Tu8
 Lbaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3K5ZWaU7jpkz5809ZziiaSQduot2gjYnTODj/IbH51UpXZpPWNwxoE92J9/uIHy0sUaQ=@lists.linux.it
X-Gm-Message-State: AOJu0Ywr2GnkGtU8rS8GignG5HUuheiRw0gTmFhPvIBFF7O5aKkuieqO
 HwEB8DybvsrtpAt8GXAOLJdyxOtARf1PxoEF8FyjPjsumbV5DrcHXDjQlPuvQg2fwD2dT2C7SjF
 e0oKddRFmMjoEWUTciPwiuXETRzyCMUvlQYbpSE1x
X-Gm-Gg: ASbGncvSVvO/l3OBar1cx5NV2m/9Kr5YZEXgDlq/DB+WVEqcZ4B6wKfWrzoh2QljzeY
 TCakhMyG39gdSYjxv/Mh9tWZmoabsYJBye38De53tetyXbBA96Yqw7pcYkI/fIfv9hGpS6HEPTB
 xpZReFAU3RqzYOMHvzReUI/Rs8fk4/jxworJ2BIM10TSr/kBNbj3eTnoZRuOudG8/nUDggos/+4
 bKGyvYmgStN5tcl6XYRuIL5+hzbrZ2+H6Cx3YCHz2hC1TVj
X-Google-Smtp-Source: AGHT+IGvKYcXwQlVkbYD6zkrVQkq/d69PycVR5/t2MSKDewoWUGTpUHdU6ncTsujHzE0ot6FOyK9gw9dRSy76UzsZCk=
X-Received: by 2002:ac8:5f0e:0:b0:4cf:1eba:f30d with SMTP id
 d75a77b69052e-4e6de86ab3dmr340940961cf.23.1760371093718; Mon, 13 Oct 2025
 08:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251010090426.2243464-1-ben.copeland@linaro.org>
 <081171be-d613-473a-9e72-6ff603d96dc4@app.fastmail.com>
 <20251013150052.GB97127@pevik>
In-Reply-To: <20251013150052.GB97127@pevik>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Mon, 13 Oct 2025 16:58:02 +0100
X-Gm-Features: AS18NWCTVy8ZZhuIIjpTg5sMqE9rWLfPE7aWEqQBqGcqoXR4bb_4NqrVoX2U9IU
Message-ID: <CAL0q8a7Uo6H+GL-oPyEhiX5uRTzywrBmrpHfn+z7_wVZ5WGZWw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] overcommit_memory: Fix integer overflow and
 32-bit limits
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
Cc: Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org,
 LTP List <ltp@lists.linux.it>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Petr,

On Mon, 13 Oct 2025 at 16:00, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> > On Fri, Oct 10, 2025, at 11:04, Ben Copeland wrote:
> > > The overcommit test uses sum_total, the sum (memory and swap) to test
> > > the overcommit settings.
>
> > > This fixes two problems on 32-bit systems. The first is seen with a
> > > integer overflow can occur when calculating sum_total * 2, if the
> > > sum_total is larger than 2GB. The second is limited virtual address
> > > space (2-3GB) means the test can fail from address space exhaustion
> > > before overcommit has been tested.
>
> > > Now the test runs correctly on low-memory 32-bit systems while avoiding
> > > both the overflow bug and virtual address space issues.
>
> Thanks for looking into the issue.
>
> > > Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
>
> > The logic makes sense to me.
>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> > >     update_mem();
> > >     alloc_and_check(free_total / 2, EXPECT_PASS);
> > > -   alloc_and_check(sum_total * 2, EXPECT_FAIL);
> > > +   /* Skip if sum_total * 2 would exceed address space.
> > > +    * On 32-bit, skip when sum_total > ULONG_MAX/4 (~1GB).
> > > +    * Most 32-bit systems with <=1GB RAM can map 2x that in 3GB vaddr space.
> > > +    * Systems with 2GB+ RAM likely cannot fit allocations in vaddr space. */
> > > +   if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= ONE_GB) {
>
> Why not use TST_GB instead of creating new constant ONE_GB?

This makes sense, I will do that.

>
> > >  #define ONE_GB                 (1024 * 1024 * TST_KB)
>
> Maybe even use static variable holding the condition and set it in setup()?
>
> Otherwise LGTM.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> > > +           alloc_and_check(sum_total * 2, EXPECT_FAIL);
> > > +   } else {
> > > +           tst_res(TCONF, "Skipping large allocation test due to address space limits");
> > > +   }
>
> > It would be nice if it was possible to express this in terms of
> > the kernel's TASK_SIZE constant and not have to check for
> > 64-bit kernels.
>
> > Unfortunately I have not been able find TASK_SIZE from userspace
> > directly other than maybe probing MAP_FIXED mmap() calls which
> > would be overly complicated. Your approach is probably as
> > good as it gets.
>
> Thanks for your time!
>
> BTW in our case (openSUSE Tumbleweed 32 bit) it fails on commit_left,
> which is slightly smaller:
> commit_left: 2221904
> sum_total: 2884328

Ah, good spot. This is failing further up the code; this fix was for
overcommit_memory=1. It's hitting the same integer overflow issue. I
will apply the same fix to overcommit_memory=2 and spin up a v2 patch.

Thanks for the feedback!

Regards,

Ben

>
> tst_kernel.c:90: TINFO: uname.machine=i686 kernel is 32bit
> tst_test.c:2021: TINFO: LTP version: 20251010.79b7f212
> tst_test.c:2024: TINFO: Tested kernel: 6.17.1-1-default #1 SMP PREEMPT_DYNAMIC Tue Oct  7 04:26:30 UTC 2025 (1bf5c2e) i686
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
> tst_test.c:1842: TINFO: Overall timeout per run is 0h 02m 00s
> overcommit_memory.c:103: TINFO: MemTotal is 2050380 kB
> overcommit_memory.c:105: TINFO: SwapTotal is 2098152 kB
> overcommit_memory.c:109: TINFO: CommitLimit is 3121292 kB
> overcommit_memory.c:122: TINFO: Setting /proc/sys/vm/overcommit_ratio to 50
> overcommit_memory.c:125: TINFO: TotalBatchSize is 8008 kB
> overcommit_memory.c:131: TINFO: Setting /proc/sys/vm/overcommit_memory to 2
> overcommit_memory.c:161: TINFO: malloc 5738112 kB successfully
> overcommit_memory.c:188: TFAIL: alloc passed, expected to fail
> overcommit_memory.c:165: TINFO: malloc 3129300 kB failed
> overcommit_memory.c:186: TPASS: alloc failed as expected
> overcommit_memory.c:161: TINFO: malloc 1434528 kB successfully
> overcommit_memory.c:180: TPASS: alloc passed as expected
> overcommit_memory.c:140: TINFO: Setting /proc/sys/vm/overcommit_memory to 0
> overcommit_memory.c:161: TINFO: malloc 1804260 kB successfully
> overcommit_memory.c:180: TPASS: alloc passed as expected
> overcommit_memory.c:165: TINFO: malloc 8297064 kB failed
> overcommit_memory.c:186: TPASS: alloc failed as expected
> overcommit_memory.c:147: TINFO: Setting /proc/sys/vm/overcommit_memory to 1
> overcommit_memory.c:161: TINFO: malloc 2074266 kB successfully
> overcommit_memory.c:180: TPASS: alloc passed as expected
> overcommit_memory.c:165: TINFO: malloc 4148532 kB failed
> overcommit_memory.c:182: TFAIL: alloc failed, expected to pass
> overcommit_memory.c:165: TINFO: malloc 8297064 kB failed
> overcommit_memory.c:182: TFAIL: alloc failed, expected to pass
>
> Kind regards,
> Petr
>
> >       Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
