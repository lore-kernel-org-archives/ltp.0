Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF32C6FD18
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 07:42:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F5B53CC011
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 09:41:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6631F3C8663
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 09:41:48 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7FF3B1000939
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 09:41:47 +0200 (CEST)
Received: by mail-ua1-x92d.google.com with SMTP id ch24so1148802uab.3
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681890106; x=1684482106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1YAu+pywxG/pg2UAfwsrQ9Qv3idmw5UfJ5YDGI+D73s=;
 b=sRUAu/qNvd546ZDE0sBLCP2o/VV/LtSaipRGsARp5ip/Y4m0V2b94fa2MbfpQYXzZZ
 HaxUpXi6uFS2m1GLjDdiCFxNL1yrmjFYoBoPA+telXHwxCLqGMIZ+h042X0ne7jwqcAW
 tpE5PC1t+ah3pxDoiuEP5QhVN6u0hAaIm17MiW2fopDX8EF7DorynxI9rqEtQ7tziGFE
 h6/+ewoe/SigB5ryqo7kdr5FbZQsvmeBG1HklAJACTLMx5ymGeucKc2swir5eWt+s5Vv
 ekcleYfch6VRwlbzQXR5G4uT6hWpcbu8hQk4eAjLTqkpNR+qmzcNvcL5uIm0KzVKqrLM
 mafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681890106; x=1684482106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YAu+pywxG/pg2UAfwsrQ9Qv3idmw5UfJ5YDGI+D73s=;
 b=OiBHbbiniEjo3T82JRt+QsCX67KYGkh++jykOCmWkBS6RIQboKM1sXVz/hXKZE6tIh
 YEmR7b4qgXGZjO6eXFDdd7sOvSUOaRVf1hWPGz2GR4uo/2DiSCtuwmyfcXncHfinZMZy
 YhLGpW7kHhHJSG0oTs7tN0hNVdKpoNqHg9lBkiIf8/bTTymc/Q/0nEjXPZ/Tp99PJPV1
 3b/17kVXfaabuouvdaXnqHLU6wQtR+tMU7Y+msSmP7jZLKGrBwQyoFV83C/OkmH2/sY9
 hpsX3W7KmUvvxEs4zeEbw9xhaMdT6vo1u7fZJnPyXlESCWk1VgJLOngavdzgHgxcerCS
 FjUA==
X-Gm-Message-State: AAQBX9f39Ma+3OitOA2qNlxzG2o6h0Re0iaLxWQZAw59p+sq/3MSf7GP
 hUab37DIhp+EvevQjg1wxaWI4zZCGZs76ClsWCGxkg==
X-Google-Smtp-Source: AKy350ZC9Z4o5gD0Go8LdlZXTSzHHSWR2dHzFHpIEhqi82FNdtApHLdtu+/mFcLbkJNT/Bt6Dw21q0Ty6r163PZOlQI=
X-Received: by 2002:a1f:3d44:0:b0:43f:f268:660f with SMTP id
 k65-20020a1f3d44000000b0043ff268660fmr7278740vka.1.1681890106042; Wed, 19 Apr
 2023 00:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230418120304.658273364@linuxfoundation.org>
In-Reply-To: <20230418120304.658273364@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Apr 2023 13:11:34 +0530
Message-ID: <CA+G9fYuT3N0LFaJGzQW2SYPJxEbEWLONDZO2OfBbeHNrsowy2w@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5.4 00/92] 5.4.241-rc1 review
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

On Tue, 18 Apr 2023 at 17:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.241 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.241-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Recently we have upgraded the LTP test suite version and started noticing
these test failures on 5.4.
Test getting skipped on 4.19 and 4.14 as not supported features.

Need to investigate test case issues or kernel issues.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:

---
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

Test history links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16338751/suite/ltp-syscalls/test/creat09/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16337895/suite/ltp-cve/test/cve-2018-13405/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16338751/suite/ltp-syscalls/test/creat09/log

---

fanotify14.c:161: TCONF: FAN_REPORT_TARGET_FID not supported in kernel?
fanotify14.c:157: TINFO: Test case 7: fanotify_init(FAN_CLASS_NOTIF |
FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, O_RDONLY)
fanotify14.c:161: TCONF: FAN_REPORT_TARGET_FID not supported in kernel?
[  377.081993] EXT4-fs (loop0): mounting ext3 file system using the
ext4 subsystem
fanotify14.c:157: TINFO: Test case 8: fanotify_init(FAN_CLASS_NOTIF |
FAN_REPORT_DFID_FID, O_RDONLY)
[  377.099137] EXT4-fs (loop0): mounted filesystem with ordered data
mode. Opts: (null)
fanotify14.c:175: TFAIL: fanotify_init(tc->init.flags, O_RDONLY)
failed: EINVAL (22)

Test results compare:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16339099/suite/ltp-syscalls/test/fanotify14/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16326877/suite/ltp-syscalls/test/fanotify14/log



## Build
* kernel: 5.4.241-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 230f1bde44b6ca667cdddf6634ea4adc0bbcd0ef
* git describe: v5.4.238-199-g230f1bde44b6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6

## Test Regressions (compared to v5.4.238-107-g73330daa3393)

* qemu-arm64, ltp-cve
  - cve-2018-13405 ( creat09 )

* qemu-arm64, ltp-cve
  - creat09

* qemu_arm64,  qemu-armv7, qemu-x86_64, qemu-i386, ltp-syscalls
  - fanotify14

## Metric Regressions (compared to v5.4.238-107-g73330daa3393)

## Test Fixes (compared to v5.4.238-107-g73330daa3393)

## Metric Fixes (compared to v5.4.238-107-g73330daa3393)

## Test result summary
total: 127111, pass: 101779, fail: 3337, skip: 21744, xfail: 251

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 143 total, 142 passed, 1 failed
* arm64: 43 total, 39 passed, 4 failed
* i386: 26 total, 20 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 12 total, 10 passed, 2 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 36 total, 34 passed, 2 failed

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
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
