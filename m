Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD3FCA0EF8
	for <ltp@archiver.kernel.org>; Thu, 21 Aug 2025 06:24:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B8373CCCCC
	for <ltp@archiver.kernel.org>; Thu, 21 Aug 2025 08:24:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA2113C0296
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 14:45:36 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 53168600CD2
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 14:45:33 +0200 (CEST)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24458194d83so47989825ad.2
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755693932; x=1756298732; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+gRhe9SO61ZZX3zSeOGc3YYqkcNZ6w6+wJsLaFnopq8=;
 b=mUXHx5jVn1JA5XF4iqlOG2+4yR5yWcuePDuG4vHwz9QH2Q6A6mtZgSHdvI+tBeaNDK
 Xzntj99G5kq6ryWiiWv7oblyzUfROddcbh7X78GtDxn40MvxNu8srP5e6GiJr4T0wspG
 tVbt+Z5YpSNRNpjKrl0LlkZF7BjDKWCrM9M9K2fzquqIQvOh0Nmb+8TArUtTOhHezMmn
 JO3yogXo8Kt89b5QwLXbYcWCb3M6rdSfUJYt0F8YERls3Bwzs49wsGCUUTm0OE/S/JWO
 ejvBlZPQ5FUvNQXHeSSlE6qP7EpqRnVSQ9c1LC9DILN1cHWq0d5ZnUsG/EOpbBCOFOSb
 4P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755693932; x=1756298732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+gRhe9SO61ZZX3zSeOGc3YYqkcNZ6w6+wJsLaFnopq8=;
 b=HIUuP5m72y41Tl/EGmZFZez2YZcq3aC1mJiY31pHbtOx9Up+0R08Trbk9dSs1lBBRm
 Nk7dyVlx20DCXVTWKz/gpcMvQKTGtxmhQyFDZEIGD0EXAW3wIqVsau60s36tbZu0hoe8
 6+hWeGjwj4h/CUmXltWaoRxRokVIQt8R95TEMUK1jVrOVOWcyXw9DU2bSbc3zxG0p99R
 Z5NqR+4BskcI5llEBemjPOqiuwUjNcPEziEIIBZccMYn79M9/2lhnU0D1var6tI5htRu
 UqmmibzuyTSQeQD/Ih7JYiCFXbhOexOmxsGBkDhhfpAol5KSB9HbLzSrA/Ec8mlpx6eu
 /EGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCtgVRPfnzcpF12hGS0aTm6Ui494fKVjPbwivLaM5IZ9wg0satMUOvQa8nOozDoYjdlgM=@lists.linux.it
X-Gm-Message-State: AOJu0YzeVnemAt4SkSWtbwwQgGKh/uNFLkjpoMRE6WySNfAmzuYD7mcq
 cW4mNsO4PjmmAaaJVnKyABeViBWcjJZSUlrJgKfZrrfec0+aI7EJ2XY2yBht0cv0mWOqqwKLwcK
 2BSxT8zxIYADwhzkByupDjN0JJeqDN1cLt3n4cH749w==
X-Gm-Gg: ASbGncstM4DZ7f8W3Tdi70c9H5qlbPrcWcc94dKDRwAIfDN/wPSi530AMmMJxuSd5NQ
 iAbf/Zr3CQ7Lu3JXv5PHCQA8mt5htIQH/MYNq0wI6JvfKGSUmjQoxjvr882Yq1OJoiX7dzKosKA
 wKUfDk360jc3yyOMAOeiFSnjNGCRMppv/nt9cUCD/LFHQQHPVkKVcfgYwW6SmVxC7rnwuG1lz4O
 aXiqBeCz9rIKRS1ChXT2Kx3fAOCh2BipZe7JWjGqU7oc9te774=
X-Google-Smtp-Source: AGHT+IEo6AZMHBNfNm+wGuts2E1fjpomh+rCZIxZABpTnRUGW4TVydP8e55fzi6K1vdQKBnAE9C73PQOIe+rJ5ddIZo=
X-Received: by 2002:a17:902:ebd1:b0:234:9375:e07c with SMTP id
 d9443c01a7336-245ef2716c0mr38415775ad.46.1755693931471; Wed, 20 Aug 2025
 05:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250819122820.553053307@linuxfoundation.org>
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 18:15:19 +0530
X-Gm-Features: Ac12FXzNj44omXAfHJgi9bZ51uoRtB8H1kwROfJrlwowrwNPU6U7fIeg-6nxe0Q
Message-ID: <CA+G9fYuQ_eHhoWsVdQpbmOSS-e_5BQzpar8Sjvtps41fUbknzA@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 21 Aug 2025 08:23:46 +0200
Subject: Re: [LTP] [PATCH 6.12 000/438] 6.12.43-rc2 review
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
Cc: Jan Kara <jack@suse.cz>, lkft-triage@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, hargar@microsoft.com,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 shuah@kernel.org, jonathanh@nvidia.com, patches@kernelci.org,
 linux-ext4 <linux-ext4@vger.kernel.org>, linux@roeck-us.net,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 srw@sladewatkins.net, broonie@kernel.org,
 Ben Copeland <benjamin.copeland@linaro.org>, LTP List <ltp@lists.linux.it>,
 rwarsow@gmx.de, pavel@denx.de, patches@lists.linux.dev, conor@kernel.org,
 achill@achill.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 19 Aug 2025 at 18:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.43-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As we discussed from the last time LTP syscalls epoll_ctl04 is a known issue
on the Linus master and Linux next.

* ltp-syscalls
  - epoll_ctl04

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

1)
The bisection results pointing to

First bad commit,
eventpoll: Fix semi-unbounded recursion
commit f2e467a48287c868818085aa35389a224d226732 upstream.

2)
A patch has been proposed to update the LTP test case to align with
recent changes in the Linux kernel code.

[LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos
- https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/
- https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.41-808-ge80021fb2304/ltp-syscalls/epoll_ctl04/

## Build
* kernel: 6.12.43-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: e80021fb2304b3e1f96e7b9a132e69d2c1d022f1
* git describe: v6.12.41-808-ge80021fb2304
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.41-808-ge80021fb2304

## Test Regressions (compared to v6.12.41-370-g3566c7a6291d)
* ltp-syscalls
  - epoll_ctl04

## Metric Regressions (compared to v6.12.41-370-g3566c7a6291d)

## Test Fixes (compared to v6.12.41-370-g3566c7a6291d)

## Metric Fixes (compared to v6.12.41-370-g3566c7a6291d)

## Test result summary
total: 284700, pass: 268768, fail: 4803, skip: 10936, xfail: 193

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mm
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* lava
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
