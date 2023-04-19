Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71153C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 08:33:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D0CC3C53E3
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 10:33:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88A1C3C53E3
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 10:33:27 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9741600842
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 10:33:26 +0200 (CEST)
Received: by mail-ua1-x92f.google.com with SMTP id p12so9186962uak.13
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681893205; x=1684485205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TFh8cKtmQeLzdNqi85aci1KA8iIgD65gwTL6N4mvUb4=;
 b=bQfRm00TH335URMWMoIjUAnRVREHVpYBP5fzrRr2WpfOwN1TgW1GKkHzAMlacfepea
 SCBUZRbUt587K6Vtuz5woZ6IKg0vEyy0mT7SmCTjNkdwKQb33cE5FQsv4hQv8WO7M65s
 XOtV8Lj0kFMVi3yNlEhGHuzXrwgYuHQmWhyud8dckS+lNdzpTe5aAAp94YcJzA6LCoeA
 oXFA56Qwo+PmpNv2trpwRsM/1wEISKkFIvkofQL/QkLGU6uUpgge9Uajz7kbsBg6Kc+/
 VgqlAQHRU9B/5J7t7C0haLx8PXj6qmh0EBW/0UKPiodL5A+k1FrySaqprMviSljrLQ3O
 q2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681893205; x=1684485205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TFh8cKtmQeLzdNqi85aci1KA8iIgD65gwTL6N4mvUb4=;
 b=lhCH7JMpzaaKkwLcejNOug7Rfha42It5zdbRgnkUfZBqzF7IXs5jcxA7Z1qd4Yzdgv
 kF1lpIoFWMfnJ3MoJi6M6Nq5f+XVpJ+0+TnJbK1gs2aK/rmHLHKXEHIcmgCwpkdOqizW
 G7OfxTCcDHYQe+dOZhNFJcLkYR9Il9XyYCvIRoBqBmITctAN2jo5werm9OdmsG9tRuQq
 CM9dffhJ4MIBqBSiTcwH6rkOKamnMXxuuJTp+gPpC1OUSJ4upNiu/3Va1ImLXRHB64OG
 alBGGSeNlgKdIY/UIbpnq0G6U5VlqLd+LR20TkrQ3nvTWwZ7rEpWfvTjGdYyRuiF1u1w
 7acQ==
X-Gm-Message-State: AAQBX9d43j2nEsyFqUw7ey5+v70nYVOUQJo7sqX3pKmuvqrCIPyOUxV1
 r608DPnhhVCnbUi5E2jLxuZNo2f8ksbRM72kFrYGHA==
X-Google-Smtp-Source: AKy350aCAj0CmufVadvfZKn2S5DZRP2Jm81ER6UwRvOh7xB9fgGw8ImZRwGXf0ybp4mARVbrEA1jcZXOXojFkttjavs=
X-Received: by 2002:a1f:5c43:0:b0:440:3629:846 with SMTP id
 q64-20020a1f5c43000000b0044036290846mr7225925vkb.2.1681893205569; Wed, 19 Apr
 2023 01:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230418120258.713853188@linuxfoundation.org>
In-Reply-To: <20230418120258.713853188@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Apr 2023 14:03:14 +0530
Message-ID: <CA+G9fYtQZpMB=uuEj9QFVXRp-JteNLd2N7ezpbfOP_ee080DaQ@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4.19 00/57] 4.19.281-rc1 review
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

On Tue, 18 Apr 2023 at 17:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.281 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.281-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Recently we have upgraded the LTP test suite version and started noticing
these test failures on 4.19 and 4.14 only on arm64.

Need to investigate test case issues or kernel issues.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
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

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.279-143-gcc0a9b81697f/testrun/16319970/suite/ltp-syscalls/test/creat09/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.279-143-gcc0a9b81697f/testrun/16319970/suite/ltp-syscalls/test/creat09/history/


## Build
* kernel: 4.19.281-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: cc0a9b81697f7222c51d17365c5960680ba00260
* git describe: v4.19.279-143-gcc0a9b81697f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.279-143-gcc0a9b81697f

## Test Regressions (compared to v4.19.279-85-ge4a87ad39c98)

* qemu-arm64, ltp-cve
  - cve-2018-13405 ( creat09 )

* qemu-arm64, ltp-syscalls
  - creat09

## Metric Regressions (compared to v4.19.279-85-ge4a87ad39c98)

## Test Fixes (compared to v4.19.279-85-ge4a87ad39c98)

## Metric Fixes (compared to v4.19.279-85-ge4a87ad39c98)

## Test result summary
total: 96758, pass: 71960, fail: 3568, skip: 21047, xfail: 183

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 107 passed, 1 failed
* arm64: 34 total, 33 passed, 1 failed
* i386: 20 total, 19 passed, 1 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 28 total, 27 passed, 1 failed

## Test suites summary
* boot
* fwts
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
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
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
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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
