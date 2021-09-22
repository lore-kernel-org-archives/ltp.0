Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17DC433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:36:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98716126A
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D98716126A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E46003C7825
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:36:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DE223C2310
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:36:10 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5AF87600F2C
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:36:09 +0200 (CEST)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxYT3-1mmoqH2RQn-00xoYN for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:36:08
 +0200
Received: by mail-wr1-f43.google.com with SMTP id d6so4774620wrc.11
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 02:36:08 -0700 (PDT)
X-Gm-Message-State: AOAM5315Jcbry+CLhXiB+/QIIjHQECgFdNL4SRw7GxA5ULQtQ1D2yAbU
 aUJEozn/TRCed2+PkU9Djnj3pKVKSbj1CHPw8wk=
X-Google-Smtp-Source: ABdhPJwsfHOtthBHhMYj7RntawREErl/gNXDh2elD51lflVYSeYX0WIWYL6DcBkNwC3VMpYByIJ66yyH/mg7lRlO9Aw=
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr9469852wmj.1.1632303368159; 
 Wed, 22 Sep 2021 02:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210921130127.24131-1-rpalethorpe@suse.com>
 <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
 <87o88mkor1.fsf@suse.de> <87lf3qkk72.fsf@suse.de> <87ilytkngp.fsf@suse.de>
In-Reply-To: <87ilytkngp.fsf@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Sep 2021 11:35:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
Message-ID: <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
To: rpalethorpe@suse.de
X-Provags-ID: V03:K1:+VW8GmOidrVYSq48hfNvYqpBT9Yg+fiWx+KABoj0bnpeaq/bZxB
 WEZQurHQyCKXLnzEd0vS/AmguEeodrxqNm9NGYvZxF+hBDDKsVV0BfmOR/9uVtoj8B+HxfI
 of7Oh6RYwCITC31WmVwqlkb6JnRDORMY2xUY3eO1C859nN5woGaJdud7OXmV0HXSmzWi8GP
 SHKsqoXLDRpj7hxIDnk7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F41Zke94Fy4=:xcxXJtOjJNpKvjG61uY07e
 cmWd4/Lu2DvbNmTLtYaz2FRcaqncvTxvHHQ5OGyrdcWzG2yqwGBuYyQ16CIzZCjijdMab74IL
 VE4OsG547Vc3CulDJjoLLIBPgiAVsnqWOdpKZadfCtRLAzJaSl/pFWQkYDfjSBBplTqQqMimw
 6KcXbB3h/FXjejSv7lUvoIpQmwJbUgUQU1shDrntddQv8YluqztF031/he67FLc7x58Yvj7XA
 DpiEA3Ew01aBM1Qby9KYZ/YqBS6eqE6U/ARXZoBAX8wtIJ71wGyoGtWOdXETpss/QBT2CNzUj
 DB/vTR/k+L+/uyl4WHAno046Wn/tF9ypdeE/5tp3l/xctRWfHE+Sq3OniMdmBy0fW/CeZXH7c
 2P/acxhVMy+Ms/hCCvUwzfwRVOknYbrrFoxRgvChIEAmgWE6SwTT62G7sfNYiT7TZ8sPbaOXI
 22b7TJBww243jVXwyJco2ew5DdoUynrnsVkvzTbEqA5siVjgPVLoSWC0CnL3rIklCnOp/71i3
 thMLhJu7gnWHOI6uRDHSHBfmFYJ2Fb7vNzNyPwo2C6A4SO4301aPwTZoJXnj79UvE8qwijht2
 x2cRbe3J/NYOgp82im1A3Hb69vSemhPBiFXa0113Wxt54SbuZaeK4/dEakGqYGtknmkecyRX/
 7xfiHUEeFBo2gNoinL+U4tKvkNEm87LWTbJS6v+aAQYufiMHZC3dalAilAEhF36kGDAl8OvrG
 tQhWi/uSwUabs/IL2v1nLx9Ly+eoWDW6+lLOiDFA9GjIz2L0Di0ny/zhBMTuSXYDa4pfTN/Yi
 7OxJf6IESCzLwOER5SgRMFP7KrbUux3NE5OiL8FaZQqGvvr2UFONLTqIXaGKgWBzUSAPwnPzF
 Hg2NPsqpEHG0Ohmitnww==
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ia32 signed long treated as x64 unsigned int by
 __ia32_sys*
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
Cc: linux-aio <linux-aio@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Sep 22, 2021 at 10:46 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> Richard Palethorpe <rpalethorpe@suse.de> writes:

> >
> > Then the output is:
> >
> > [   11.252268] io_pgetevents(f7f19000, 4294967295, 1, ...)
> > [   11.252401] comparing 4294967295 <= 1
> > io_pgetevents02.c:114: TPASS: invalid min_nr: io_pgetevents() failed as expected: EINVAL (22)
> > [   11.252610] io_pgetevents(f7f19000, 1, 4294967295, ...)
> > [   11.252748] comparing 1 <= 4294967295
> > io_pgetevents02.c:103: TFAIL: invalid max_nr: io_pgetevents() passed unexpectedly
>
> and below is the macro expansion for the automatically generated 32bit to
> 64bit io_pgetevents. I believe it is casting u32 to s64, which appears
> to mean there is no sign extension. I don't know if this is the expected
> behaviour?

Thank you for digging through this, I meant to already reply once more yesterday
but didn't get around to that.

>     __typeof(__builtin_choose_expr(
>         (__builtin_types_compatible_p(typeof((long)0), typeof(0LL)) ||
>          __builtin_types_compatible_p(typeof((long)0), typeof(0ULL))),
>         0LL, 0L)) min_nr,
>     __typeof(__builtin_choose_expr(
>         (__builtin_types_compatible_p(typeof((long)0), typeof(0LL)) ||
>          __builtin_types_compatible_p(typeof((long)0), typeof(0ULL))),
>         0LL, 0L)) nr,

The part that I remembered is in arch/s390/include/asm/syscall_wrapper.h,
which uses this version instead:

#define __SC_COMPAT_CAST(t, a)                                          \
({                                                                      \
        long __ReS = a;                                                 \
                                                                        \
        BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&              \
                     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t) &&           \
                     !__TYPE_IS_LL(t));                                 \
        if (__TYPE_IS_L(t))                                             \
                __ReS = (s32)a;                                         \
        if (__TYPE_IS_UL(t))                                            \
                __ReS = (u32)a;                                         \
        if (__TYPE_IS_PTR(t))                                           \
                __ReS = a & 0x7fffffff;                                 \
        if (__TYPE_IS_LL(t))                                            \
                return -ENOSYS;                                         \
        (t)__ReS;                                                       \
})

This also takes care of s390-specific pointer conversion, which is the
reason for needing an architecture-specific wrapper, but I suppose the
handling of signed arguments as done in s390 should also be done
everywhere else.

I also noticed that only x86 and s390 even have separate entry
points for normal syscalls when called in compat mode, while
the others all just zero the upper halves of the registers in the
low-level entry code and then call the native entry point.

        Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
