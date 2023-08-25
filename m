Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFF8C3DA6F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:08:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42DFF3CC3B5
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 10:08:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 165EA3CC36D
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 10:08:41 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 44FB414010CC
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 10:08:41 +0200 (CEST)
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-48d0c7bfc49so455388e0c.0
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 01:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692950920; x=1693555720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6QcQszMmxdJXwrdj7qv0i9KCRG16x6Uvx3Pa+z1CyMw=;
 b=kEtf7/dJtTkeGYA9DS3Z7w0+USux+OmEZxVGCz29NkVWX3Qsq3XmhIxosoEibdvlge
 4kmMeo9X53/5rlLa4p2CGlpDlmsCvSeaH0IKkM3p0YX0ZSgdo6FhQrFm8DSA+/HsPwNs
 Pdtqggstnu370CZL4cGFTUMqwRXpkVk1EAupqfBGoCFn2zu1qO8jNUtTTkty8KOa46Vp
 oH3ebYMo8M04POs8Yf7S+PbOMfGyqDx//XmIlrvcgiZASOt56kIdPdDkK8Ck/45lXwhM
 3mpNpnLHi9PZ31O6pv8fH/7rZ5A1uAk1u5sF4Q9Z/OniV6tKFgQPVwhjX9Pm5HttSW0G
 /JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692950920; x=1693555720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6QcQszMmxdJXwrdj7qv0i9KCRG16x6Uvx3Pa+z1CyMw=;
 b=f8FzUxGh1VzBwab/otoqDkJj3ulThSAzQo9KbwwXaNukUTjj1SVFnkHcY4P8qbNFys
 XH8uQ9cCCYgwTeUH0HA57N15bwzOmxgGOCtDlfNBrUNBohz/dJVH8yp6nfDiHN0Pamn9
 eyrHxPUPgtdElNtqgq5dcFM5N+aEqBHL9NtgYAiYCPYHCGBfwLr8/1uyUEEQ49phnX68
 efSMj+C4bpq1yrIfE3r/HyIIOJyzCFOjQeh/98kfgc07RaBllz7K5TJxbs49vimZVNBq
 U8QA+q8P3h2o1YDsaekzuRoem28MV34oWf9bT0AGItLPrZaOuxG/D9L8RTvQAipZ5g53
 foXg==
X-Gm-Message-State: AOJu0YyqAAyD9bINgzUpbL6ijDRSNU5hJ1pmUHCktzYExJGinSe7pQpK
 09hKFwZx5JFlf95SjNP+GGPy/RqcCM9N4bqDoCupkw==
X-Google-Smtp-Source: AGHT+IGKlUoZqLtAuC5n6U8/S/LEQzMs7GSNBs/X3ca/L9sMnytTCYWAR49NLSPWdqYY3WSdtWOyVrio55hiXGg7eeY=
X-Received: by 2002:a05:6122:c56:b0:48d:392c:c7d9 with SMTP id
 i22-20020a0561220c5600b0048d392cc7d9mr5516493vkr.6.1692950919958; Fri, 25 Aug
 2023 01:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230824145023.559380953@linuxfoundation.org>
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 Aug 2023 13:38:28 +0530
Message-ID: <CA+G9fYvNipSR9HDcWT7F6j+yvy87jsbzLG-vUQSGH-o2JQv4nQ@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5.15 000/139] 5.15.128-rc1 review
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
Cc: linux-nfs@vger.kernel.org, f.fainelli@gmail.com, rwarsow@gmx.de,
 pavel@denx.de, conor@kernel.org, shuah@kernel.org,
 LTP List <ltp@lists.linux.it>, patches@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
 srw@sladewatkins.net, patches@kernelci.org,
 Sherry Yang <sherry.yang@oracle.com>, akpm@linux-foundation.org,
 jonathanh@nvidia.com, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com, linux@roeck-us.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 24 Aug 2023 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.128 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.128-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The same test regressions found on stable-rc linux.5.15.y as reported
on stable-rc linux.6.1.y branch. LTP syscalls chown02 and fchown02 fails
on arm64 Rpi4 device with the NFS rootfile system.

Test log:
--------
chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

fchown02.c:57: TPASS: fchown(3, 0, 0) passed
fchown02.c:57: TPASS: fchown(4, 0, 0) passed
fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
expected 0102700

  Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Do we need a backport patch ?

  nfsd: use vfs setgid helper
    commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.


## Build
* kernel: 5.15.128-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 00e5f0b76767cab779762a1d27fc17c1cf2a3606
* git describe: v5.15.127-140-g00e5f0b76767
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.127-140-g00e5f0b76767

## Test Regressions (compared to v5.15.127)
* bcm2711-rpi-4-b, ltp-syscalls
  - chown02
  - fchown02

* bcm2711-rpi-4-b-clang, ltp-syscalls
  - chown02
  - fchown02

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
