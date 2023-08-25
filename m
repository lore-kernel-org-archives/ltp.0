Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2A2C3DA6F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:49:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31DF33CC3B2
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 10:49:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CDB13CC341
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 10:48:54 +0200 (CEST)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 558F814010D9
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 10:48:53 +0200 (CEST)
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7a257fabae5so243829241.2
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692953332; x=1693558132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sbZ3YR5SOTzvg9ICyWHf0Y3N1R2PQGKPLxJHSDkU0rM=;
 b=GYyfYLoayqEhg+1OxKxqtm2fRmYulcaLX4TTxSgt21+qkzsk1exT9j6tQjBpc6866n
 XEyJawRoUgLyEKmHa12McvnPjjYUb7Cd4nGCM8MsADBgoDSOwF/dulMelfLTUyrPluLO
 paCyyivUdXtYjN3IHnW74ErmR3kRj0s4vWJ+M0aA52GjyjOc2dLGmlJBCNXYd1VMkxDe
 1U7bfmMswXlUEBtQBDtUetBffAei96AJwh1jlNs5b2UMj4/O0ieJDqcipj5SV3IlDAPC
 JfHLPwIquqLbAzZDQJw+KPxHYgn+EXchOPo35A/dehuZvaif5wvZmrqEr87FFkkOXyeg
 h0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692953332; x=1693558132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sbZ3YR5SOTzvg9ICyWHf0Y3N1R2PQGKPLxJHSDkU0rM=;
 b=LnsfK4FR85wwBKp+b5PPImqRlRhFj6jr4iUNghG1hTkmisc3Cq1LpZVsiPXhL//d7r
 +6VOHSgxFu8Gw7ZhrKp/cV3nSrD8KQbl3eU/zaC7NmgkKWoUSjyX5Y/ZOprnEFX4xqTc
 J0HJZtxSmmbDunpGJq5dRbWJ3Zv9Urt4kMrHiDdHsGkjAib9kScPcAdWM5A4bExWZlfJ
 Uob8YChQLJ2or0wAOtU9aUJZJZGoCouzolOIidx1C0vPJYz+NKChTPwVqVDTG2+ld3Wa
 q7dGxsl1lGnRvlq3nqT8L8HIEZe4CJTuPzq7+Yv10kUv1QWWb73jJYNu2OkB72UYnCqs
 cauA==
X-Gm-Message-State: AOJu0YxoqcRK++cRyWAp3DSggORMm+XVRslhd4bmyXpIPIIcG8lO9H3+
 M961VluvkEEsWlt/qQGP4bCMHZ4LNO2YQHxkRdtc5g==
X-Google-Smtp-Source: AGHT+IHv9ZXZDpJ4MtbLFtoZRPbeXnm7kBLGoVbXuXoEwFv6MYdMhI1trUVN0f9Wn9gfMN6Tfn8L5YsvCtebNf///wI=
X-Received: by 2002:a67:f8cf:0:b0:44e:906d:58d with SMTP id
 c15-20020a67f8cf000000b0044e906d058dmr5548304vsp.13.1692953332138; Fri, 25
 Aug 2023 01:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230824141447.155846739@linuxfoundation.org>
 <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
 <2023082512-amusement-luncheon-8d8d@gregkh>
In-Reply-To: <2023082512-amusement-luncheon-8d8d@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 Aug 2023 14:18:40 +0530
Message-ID: <CA+G9fYvVGxm0xOYp4LHepRJqccwmK7Zeg--2AhVk5T+T28Kk6A@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6.1 00/15] 6.1.48-rc1 review
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
Cc: lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 stable@vger.kernel.org, shuah@kernel.org, f.fainelli@gmail.com,
 Sherry Yang <sherry.yang@oracle.com>, jonathanh@nvidia.com,
 patches@kernelci.org, linux@roeck-us.net, linux-nfs@vger.kernel.org,
 srw@sladewatkins.net, LTP List <ltp@lists.linux.it>,
 Christian Brauner <brauner@kernel.org>, rwarsow@gmx.de, pavel@denx.de,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 conor@kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 25 Aug 2023 at 13:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 25, 2023 at 12:35:46PM +0530, Naresh Kamboju wrote:
> > + linux-nfs and more
> >
> > On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.48 release.
> > > There are 15 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> >
> > Following test regression found on stable-rc 6.1.
> > Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
> > chown02 tests creating testfile2 on NFS mounted and validating
> > the functionality and found that it was a failure.
> >
> > This is already been reported by others on lore and fix patch merged
> > into stable-rc linux-6.4.y [1] and [2].
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Odd, it's not a regression in this -rc cycle, so it was missed in the
> previous ones somehow?
>
> > Test log:
> > --------
> > chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
> > chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
> > chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> >
> > fchown02.c:57: TPASS: fchown(3, 0, 0) passed
> > fchown02.c:57: TPASS: fchown(4, 0, 0) passed
> > fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
> > expected 0102700
> >
> >
> > ## Build
> > * kernel: 6.1.48-rc1
> > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > * git branch: linux-6.1.y
> > * git commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
> > * git describe: v6.1.47-16-gc079d0dd788a
> > * test details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.47-16-gc079d0dd788a
> >
> > ## Test Regressions (compared to v6.1.46)
> > * bcm2711-rpi-4-b, ltp-syscalls
> >   - chown02
> >   - fchown02
> >
> > * bcm2711-rpi-4-b-64k_page_size, ltp-syscalls
> >   - chown02
> >   - fchown02
> >
> > * bcm2711-rpi-4-b-clang, ltp-syscalls
> >   - chown02
> >   - fchown02
> >
> >
> >
> >
> > Do we need the following patch into stable-rc linux-6.1.y ?
> >
> > I see from mailing thread discussion, says that
> >
> > the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.1.y.
>
> What "above commit"?

Sorry, s/above/below/
I copied that from another email thread as it is.

>
> And what commit should be backported?


  nfsd: use vfs setgid helper
    commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.

Please refer this link,
 - https://lore.kernel.org/linux-nfs/20230502-agenda-regeln-04d2573bd0fd@brauner/


>
> confused,
>
> greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
