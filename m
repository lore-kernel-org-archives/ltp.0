Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C0CC77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 08:41:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B017C3CC007
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 10:41:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF0753CBFED
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 10:41:42 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AD58320099A
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 10:41:41 +0200 (CEST)
Received: by mail-ua1-x92c.google.com with SMTP id r10so13214477uat.6
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681893700; x=1684485700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=emy47ve69M61/H+lOFyGeFQpmRwakkEYlvCbnQMqfZc=;
 b=ENnv+X68dCRBEv06msiX8E/szw1zR4jEO2EWzjTUvTeuOAAdhKX6tczSGLo6x3t+hv
 73PlTnk0PUtOCULsF/s9pyuiddkUrgUR1CDZWe/q1jDJbj+5WUFURaQW610rQZZ3twru
 m9Zz5oThv/KOTV+pyWaNb12SV8LTwk8dBR6WZHmIDB07gyhmOLjSptO+JCQU9vWFvfmZ
 TDc8EGRIWixLk2vKpZeEprTKhGcSJHQhdeSiZPeRKA6Zv44QDXQiKR/o/R6GH4MsZ/Lm
 UFObZ7UcA9iMzGcqC2MZfCsX8lO/APWIuo02j0lC2nlql/yBp3syxTi4bTPLp4XwwUtR
 mUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681893700; x=1684485700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=emy47ve69M61/H+lOFyGeFQpmRwakkEYlvCbnQMqfZc=;
 b=JP6SX0kKBprhdv1YmdykKI7KoLHwGbX0DMIs8o+lbNpI+62AWrm/aArH3nYqyFxx/K
 JS4VlwcfTUYUXF3CyxRbtQTG05Oyg9gtUISADEkARGkAalo0El9dydItJGViHz9SSSDZ
 n/3uuMFk+2vFEYCMP7IyS3StiNzZdHArKow7A68G6jw9s6QXPKZ2AC92Bcn5XRq4V9pR
 RPSHAkZvblDTubFr1mPvd56slN0MtVojag64E9B8PTYgZ6ntHxrXvNPA3QHW9y29HHc4
 1fw0ziqdCKlasu49qvJFeAQ0hgE5uadkdn0ZsbXJpWbPlG1XbudMvk4+I6c7mRCrJ1g1
 nGXA==
X-Gm-Message-State: AAQBX9eXBivtbxf4JCprVh2nURpJi88mkUegVVd2YuZJ4P5t8abV1RzE
 WikhHBwIrOi2LKIN9uj4p+NuKDOqBw97NXG3dh3nBg==
X-Google-Smtp-Source: AKy350Z3Ni0SSbMTDkN3mmzu1eRZR47Vg3M1yERQUS0xI3yjYTmv0WF06K5Cir25APo9u7T2XdG4FFNMTxTkCObeuhY=
X-Received: by 2002:a1f:6045:0:b0:432:6ec5:69a5 with SMTP id
 u66-20020a1f6045000000b004326ec569a5mr7179757vkb.3.1681893700274; Wed, 19 Apr
 2023 01:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230418120254.687480980@linuxfoundation.org>
In-Reply-To: <20230418120254.687480980@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Apr 2023 14:11:29 +0530
Message-ID: <CA+G9fYvuJFV8bJNO5qObtZzvPDJwNdwjkgmPBo1GfCnL35GFtQ@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4.14 00/37] 4.14.313-rc1 review
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
Cc: f.fainelli@gmail.com, rwarsow@gmx.de, pavel@denx.de, shuah@kernel.org,
 LTP List <ltp@lists.linux.it>, patches@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 lkft-triage@lists.linaro.org, srw@sladewatkins.net, patches@kernelci.org,
 akpm@linux-foundation.org, jonathanh@nvidia.com, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com, linux@roeck-us.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 18 Apr 2023 at 17:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.313 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.313-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Recently we have upgraded the LTP test suite version and started noticing
these test failures on 4.14, 4.19 and 5.4 only on arm64.

Need to investigate test case issues or kernel issues.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
-----
creat09.c:73: TINFO: User nobody: uid = 65534, gid = 65534
creat09.c:75: TINFO: Found unused GID 11: SUCCESS (0)
creat09.c:120: TINFO: File created with umask(0)
creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
creat09.c:112: TPASS: mntpoint/testdir/creat.tmp: Setgid bit not set
creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
creat09.c:112: TPASS: mntpoint/testdir/open.tmp: Setgid bit not set
creat09.c:120: TINFO: File created with umask(S_IXGRP)
creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
creat09.c:110: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
creat09.c:110: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set

links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.311-105-gcdc53f89dfa8/testrun/16316521/suite/ltp-syscalls/test/creat09/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.311-105-gcdc53f89dfa8/testrun/16316521/suite/ltp-syscalls/test/creat09/history/

## Build
* kernel: 4.14.313-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: cdc53f89dfa8e80182c9539a962df6c330a69931
* git describe: v4.14.311-105-gcdc53f89dfa8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.311-105-gcdc53f89dfa8

## Test Regressions (compared to v4.14.311-67-gf4c3927dd933)

* qemu-arm64, ltp-cve
  - cve-2018-13405 ( creat09 )

* qemu-arm64, ltp-syscalls
  - creat09

## Metric Regressions (compared to v4.14.311-67-gf4c3927dd933)

## Test Fixes (compared to v4.14.311-67-gf4c3927dd933)

## Metric Fixes (compared to v4.14.311-67-gf4c3927dd933)

## Test result summary
total: 65426, pass: 54434, fail: 2998, skip: 7868, xfail: 126

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 106 total, 104 passed, 2 failed
* arm64: 33 total, 32 passed, 1 failed
* i386: 20 total, 19 passed, 1 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 24 passed, 1 failed

## Test suites summary
* boot
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-net
* kselftest-net-forwarding
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-zram
* kunit
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktBroadcast
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
