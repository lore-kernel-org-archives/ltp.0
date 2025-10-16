Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A7ACCD183
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 12:37:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CB9D3CEDF4
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 14:37:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6875A3CEC33
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 14:37:00 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B216D1A000B9
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 14:36:59 +0200 (CEST)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-87c1f607e72so2067396d6.0
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760618218; x=1761223018; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dcy0iNVDvxOcpM+P6uR23YMPjq0UEBlcY5WDx1FY0eo=;
 b=ySVuBroM/vw+czCd3nhJ3Brdvp1rAcoG8odz3D51cPVNUzyDNrd7JcL3DFO/2vJpwZ
 l+Cg6wzabUN5BwCCYHpGvs+2V2pkjrnCbh/LrNoHX5pMAzH2HnFE6RlnnJc/1MVGyi+7
 vtGgTcfmrJdY601CXcR9IJUuiB2rI2jEh1mIpjvNjxzzkzESc49/19exaDxhgVJXXIb0
 LOjCh1yYZkZ66oY6ype0qOFEVAtvBOgN6yD7sQfN0QqFWVNyID3KgHUbUkbtCpjzQDDp
 4XFW+Ln1wG9pnD6mjN0u1VveNCASrUQ3opxCpiUFj5gPowo0IjkD7jBzPV9nyP4Ther2
 zsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760618218; x=1761223018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dcy0iNVDvxOcpM+P6uR23YMPjq0UEBlcY5WDx1FY0eo=;
 b=bNf1Bqx2UG3IVYVDxe78Yx2fI4X7EkS3/59lX65Be4mQe8ECZaqZpxmsEZ9bqH3pLg
 zCygRYL7IGbIRokian0JdKm2noD7+Cln48w6muZJ+wuF3f4kXmqW5qk2gZBI9XFWCC+E
 /Y9fdn4h7L5ljqTZy07kEMHMJYvvTOVQn42Jwvltpia5mbK9QyHX6NX3J/253j4+cbgw
 ES2u4u8jhanJC9299j2Qxj9DZk7dG8avZV/K6GUqiLYh/3wMr1I4ljAExqnTiQNxNEI+
 41DFJffmD/EUVRVY9TmlSs/Ne5hevI7d2hdiEdAG8sb12P/FycY3H4fIWnIkgXyYqMxq
 N0mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhMOcXYSYhU8WR34mm6TeNCoAQbQngR568Ith2Y4q3/goT1R6Zi+ZUef+N906mOTg/Sbc=@lists.linux.it
X-Gm-Message-State: AOJu0Yy/4pxxIZugjffiRFDdidMAObVV1Sp+7g/bSRH0kS05JPQ+HqtY
 BwzYgVMsXwY0469EnSo7EeXKs3+V7H7sl21zmERoDNjyJReiaN5pfTBnzY0XrYa9bXkQp/obK7d
 wL0osWTybo95BXaBM8z72v7t0T8oW6u0GxH7YQIxA
X-Gm-Gg: ASbGncsHkjT7nrJ7RH83KaXRF0tsdx2LSKXsE184T2ymqzpUrcuKsqEq5cJ0IqrggxK
 AsqHm/EYP21hRytPVesozbpjmpf3tLO1zH4XZ5OK7C6EVtCYACQnOxPGDaNWwZF6xPkfZFS8pns
 kospZqw2AuCAmFntOCLheYOKk/UmWX6eMx9ILtQcsj00CE9eJ9DIWPun9VsLlsKaMvFSjM2a6ed
 8yWN7jLVQX/lS5xApYqqoW0r3NL9XoUcueCGVk+NMZXyix5VQIqudquYu+EYdplLpctPX2w
X-Google-Smtp-Source: AGHT+IHEvUfnqfnd8ls/S+c71JskwzQju991FpyKA/HMV1sSTA/71k+h3IpUsWyL6ts64y5NFsJ0lxv4vFbCgnGO0ag=
X-Received: by 2002:a05:6214:f02:b0:87c:159b:8647 with SMTP id
 6a1803df08f44-87c203025camr375346d6.32.1760618218324; Thu, 16 Oct 2025
 05:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251015101533.30220-1-ben.copeland@linaro.org>
 <20251015144247.GB220875@pevik> <aO-2-tN418z9wDKm@stanley.mountain>
 <20251015160224.GC220875@pevik>
In-Reply-To: <20251015160224.GC220875@pevik>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Thu, 16 Oct 2025 13:36:47 +0100
X-Gm-Features: AS18NWCfowPo62nqJdrD6rLXW2KNRQIr2GS44eoZk79cVvK1injhC6rN2dWepf0
Message-ID: <CAL0q8a4Rg1VQn=em5fNA1SKb_mFJFNFNam1Gr8Q_Paah2pWrzg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] overcommit_memory: Fix integer overflow and
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
Cc: arnd@arndb.de, lkft-triage@lists.linaro.org,
 Dan Carpenter <dan.carpenter@linaro.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Petr,

On Wed, 15 Oct 2025 at 17:02, Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Wed, Oct 15, 2025 at 04:42:47PM +0200, Petr Vorel wrote:
> > > > The overcommit test uses sum_total, the sum (memory and swap) to test
> > > > the overcommit settings.
>
> > > > This fixes two problems on 32-bit systems. The first is seen with a
> > > > integer overflow can occur when calculating sum_total * 2, if the
> > > > sum_total is larger than 2GB. The second is limited virtual address
>
> > > You still mention GB ...
>
>
> > Yep.  It is GB.
>
> > > > space (2-3GB) means the test can fail from address space exhaustion
> > > > before overcommit has been tested.
>
> > > > Now the test runs correctly on low-memory 32-bit systems while avoiding
> > > > both the overflow bug and virtual address space issues.
>
> > > > Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > >  .../kernel/mem/tunable/overcommit_memory.c    | 33 +++++++++++++++----
> > > >  1 file changed, 27 insertions(+), 6 deletions(-)
>
> > > > diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
> > > > index 9b2cb479d..7ff5a98d0 100644
> > > > --- a/testcases/kernel/mem/tunable/overcommit_memory.c
> > > > +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> > > > @@ -131,24 +131,45 @@ static void overcommit_memory_test(void)
> > > >   TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);
>
> > > >   update_mem_commit();
> > > > - alloc_and_check(commit_left * 2, EXPECT_FAIL);
> > > > - alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
> > > > + /* Skip tests that would overflow or exceed 32-bit address space */
> > > > + if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
>
> > > ... but TST_GB / TST_KB is actually MB (you could use TST_MB).
>
>
> > The sizes in this test are measured in KB, so it's 1GB but measured in
> > terms of KB not bytes.  Using TST_MB would work mathematically but it's
> > misleading.
>
> Ah, I'm sorry to overlook an obvious point.
>
> Implementation details: thinking about the code twice, shouldn't be the check
> for overflow in alloc_and_check() instead of outside (to keep the condition on
> single place)?

Excellent suggestion. It makes sense to simplify it like that. I will
spin up a v3 patch with those changes.


Ben



>
> Also, if kept outside the 1st and 2nd if could be joined:
>
>         /* Skip tests that would overflow or exceed 32-bit address space */
>         if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
>                 alloc_and_check(commit_left * 2, EXPECT_FAIL);
>                 alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
>                 update_mem_commit();
>                 alloc_and_check(commit_left / 2, EXPECT_PASS);
>         } else {
>                 tst_res(TCONF, "Skipping large allocation tests due to address space limits");
>         }
>
> instead of your proposal:
>
>         update_mem_commit();
>         /* Skip tests that would overflow or exceed 32-bit address space */
>         if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
>                 alloc_and_check(commit_left * 2, EXPECT_FAIL);
>                 alloc_and_check(commit_limit + total_batch_size, EXPECT_FAIL);
>         } else {
>                 tst_res(TCONF, "Skipping large allocation tests due to address space limits");
>         }
>         update_mem_commit();
>         if (tst_kernel_bits() == 64 || (unsigned long)commit_left <= TST_GB / TST_KB) {
>                 alloc_and_check(commit_left / 2, EXPECT_PASS);
>         } else {
>                 tst_res(TCONF, "Skipping commit_left/2 allocation test due to address space limits");
>         }
>
> because update_mem_commit() IMHO just evaluates /proc/meminfo values, but
> when alloc_and_check() is skipped nothing has changed.
>
> Kind regards,
> Petr
>
> > regards,
> > dan carpenter
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
