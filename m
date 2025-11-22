Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EFBD0E6F5
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 15:56:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 531693CE883
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 16:56:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C6F53CAE80
 for <ltp@lists.linux.it>; Sat, 22 Nov 2025 05:41:15 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7E03D1A00342
 for <ltp@lists.linux.it>; Sat, 22 Nov 2025 05:41:14 +0100 (CET)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-bc8ceb76c04so1784919a12.1
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 20:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763786473; x=1764391273; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P2OfHfYMQD7BIWZ550zETvyeOjFs/FkoMlr0NVso26A=;
 b=D954zGCFAi/D5tqSZnFY7yfltQIWKm172aNWdu6uYFDhkFlB4uj4O+3lfkzoVj+vVo
 vr1uTvZJ1WdOo9pU1z01v2OT1aGm7EuuZSde8z4/cFAQxI+a+Zc7SVsBJEQ3RTB6+hM9
 I5ZuzUI7u73y6Vf4qBSC1bJlA3xG9+67e+Ay7NuNWjq/gsLUgOcQnOIYhbmBaXVBGuV8
 VrmoSNroX4Frye8PfakWxBqZ6cuHM/7SFG2VEIvaBNdqvAiyJRbS238BTcjxSKgLkWR3
 QOG4n0IY+BOAn0S/7l5UqjEN1JnvA3Y/YnFLumS+2TAGNsaH3HjCllKAbJxboNo2h7lf
 8hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763786473; x=1764391273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2OfHfYMQD7BIWZ550zETvyeOjFs/FkoMlr0NVso26A=;
 b=EQy16iBEG02YIRT20Wv0h8s9SPMazD8spz4i77r4HGqDD+UjycbmvfXETNwVdozKKq
 vziRdun7thTo0q9zSn5J2EmCfDCHhhUK/O9jZVPEaKG82nEv10jbVvumFuBvY449tWz+
 JjncbFg7i8xw347MdZna5eTowBJ1sgT7FqalpkWF5+2ur88G/zCjsHynJp8M6CSm4RHG
 k0AfScvNKv/a0VidWaRYO+PxRLL63mWMTXhc6ayfpnPgj0IEYynD9nfAO/4gf9B2IQOO
 d1Pur1kDYcjS62RP2QAtP5SB4sGHTMbh4O+JKkhSIEwNQierM8QITJjXJJktpZC71toS
 e0bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm+kZK9Aed8oXn7afrB5CQtHPDV3WDAxLtXPHL0yM9HDZ1+dUDzkQxASHlYT5Uvvls/hk=@lists.linux.it
X-Gm-Message-State: AOJu0YwLBcwgxVJnk4hxmuYrZ5JUsYKlLmv85FzjxZIKQKeSvJKTsAkv
 /N0pbCDLse9bhX655h+9gcla3CeLBAjrJBB70YdBSGUOzvx6zmlfprG96c8pGgtstlZ4m66ZkQy
 c+FPqt4ipTE5O7ozntqHVTSxupemDIiPeeUy0SvibpA==
X-Gm-Gg: ASbGncvs4RXxq6OZfu62odY9grJHVAx1hqe44IuwDUVk+mccvJtmfDqlxDDKHcGTsMa
 piZc2YDgzl9terz+6ZUytt3Dv2+sEs6QS9eFLqyGyCyvEGI/LPrGDdZ+PDthH1Qgvy7txAF6WrX
 bOTKJTUWYVFx8zzXU55aCRKE8B+jgzhlHnVfcp41rMsuVRf8fK2UM8iLonHcJ2I8AgPDLvFhaYC
 iVkuLho0CbR60wDnB83O9dzuxB9SrrdveZ4EBCCLkNjFOWTvNH04X4rYLhkxUSz2c7lwjInU93l
 CagUykI0OMUC37DQfY4LoWSb5e7yduI5GCtUYvY=
X-Google-Smtp-Source: AGHT+IE8oEB0Bk/WUV316rX6l836nB/xJn7OLenveTC22jF0e+Qj166dl6/klF8TEtvtM/R/zQi99gF2oec8bULJg6k=
X-Received: by 2002:a05:7300:b593:b0:2a4:617a:419f with SMTP id
 5a478bee46e88-2a7194a9af6mr2638588eec.2.1763786472525; Fri, 21 Nov 2025
 20:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20251121160640.254872094@linuxfoundation.org>
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 22 Nov 2025 10:11:01 +0530
X-Gm-Features: AWmQ_bnWr_rQO39FsnhRRTwXh3oyCJ2CUpy3Um6q10yQWTSxEQLiDtW17Wfwwms
Message-ID: <CA+G9fYsomsM_07yAZ=MShyjFRXLe26Vm+-tPv81YLOO-SPqo6Q@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 25 Nov 2025 16:55:57 +0100
Subject: Re: [LTP] [PATCH 6.17 000/244] 6.17.9-rc2 review
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
Cc: lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, hargar@microsoft.com,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 shuah@kernel.org, sr@sladewatkins.com, jonathanh@nvidia.com,
 patches@kernelci.org, linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>,
 broonie@kernel.org, Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, rwarsow@gmx.de, pavel@denx.de,
 patches@lists.linux.dev, conor@kernel.org, achill@achill.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 21 Nov 2025 at 21:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.9 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Nov 2025 16:05:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.9-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The LTP syscalls listmount04 failures noticed across the 6.18.0-rc6,
Linux next-20251120, stable-rc 6.17.9-rc1, 6.17.9-rc2 and 6.12.59-rc1.

First seen on 6.17.9-rc1
Good: v6.17.6
Bad: 6.17.9-rc1

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: listmount04.c:128: TFAIL: invalid mnt_id_req.spare
expected EINVAL: EBADF (9)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log,
<8>[  467.451816] <LAVA_SIGNAL_STARTTC listmount04>
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2021: TINFO: LTP version: 20250930
tst_test.c:2024: TINFO: Tested kernel: 6.17.9-rc1 #1 SMP PREEMPT
@1763732790 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
listmount04.c:128: TPASS: request points to unaccessible memory : EFAULT (14)
listmount04.c:128: TPASS: mnt_ids points to unaccessible memory : EFAULT (14)
listmount04.c:128: TPASS: invalid flags : EINVAL (22)
listmount04.c:128: TPASS: insufficient mnt_id_req.size : EINVAL (22)
listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)
listmount04.c:128: TPASS: invalid mnt_id_req.param : EINVAL (22)
listmount04.c:128: TPASS: invalid mnt_id_req.mnt_id : EINVAL (22)
listmount04.c:128: TPASS: non-existant mnt_id : ENOENT (2)

Summary:
passed   7
failed   1
broken   0
skipped  0
warnings 0


## Build
* kernel: 6.17.9-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: ddfe918dc24b5818022af062d1685d31fcdb8b3b
* git describe: v6.17.6-1131-gddfe918dc24b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17.6-1131-gddfe918dc24b

## Test
* Test details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.17.y/v6.17.6-1131-gddfe918dc24b/ltp-syscalls/listmount04/
* Test log: https://lkft.validation.linaro.org/scheduler/job/8533736#L25762
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/35nQWH8wgEwiOrUmrLn0I3NGkyh
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/35nQUZuM39Pa120Y5iFXGyRw4Or/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/35nQUZuM39Pa120Y5iFXGyRw4Or/config

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
